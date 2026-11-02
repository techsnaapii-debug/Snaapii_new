import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiException implements Exception {
  final String message;
  const ApiException(this.message);

  @override
  String toString() => message;
}

class AuthApi {
  static const _configuredBaseUrl = String.fromEnvironment('API_BASE_URL');
  static const _liveBaseUrl = 'https://bash-varsity-penny.ngrok-free.dev';
  static const _tokenKey = 'auth_token';
  static const _userKey = 'auth_user';
  static const _storage = FlutterSecureStorage();

  static Future<String?> readToken() => _storage.read(key: _tokenKey);

  static Future<Map<String, dynamic>?> readUser() async {
    final raw = await _storage.read(key: _userKey);
    if (raw == null) return null;
    final user = jsonDecode(raw);
    return user is Map<String, dynamic> ? user : null;
  }

  static Future<void> saveUser(Map<String, dynamic> user) =>
      _storage.write(key: _userKey, value: jsonEncode(user));

  static Future<void> clearToken() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _userKey);
  }

  /// Ends the server session when possible, then always removes the local
  /// session so the user cannot remain signed in on this device.
  static Future<void> logout() async {
    try {
      await request('POST', '/api/auth/logout');
    } on ApiException {
      // Local sign-out must still succeed if the device is offline or the
      // token has already expired.
    } finally {
      await clearToken();
    }
  }

  static Future<void> deleteCurrentAccount() async {
    if (await readToken() == null) {
      throw const ApiException('Please log in again.');
    }
    await request('DELETE', '/api/auth/delete-account');
    await clearToken();
  }

  static Future<void> disconnectInstagram() async {
    if (await readToken() == null) {
      throw const ApiException('Please log in again.');
    }
    await request('POST', '/api/instagram/disconnect');
  }

  /// Restores a locally valid session for application launch.
  ///
  /// The expiry check only decides whether the app can restore its UI. Protected
  /// requests still send the token to the backend, where its signature and
  /// permissions are enforced.
  static Future<int?> restoreSessionRole() async {
    final token = await readToken();
    final user = await readUser();
    if (token == null || user == null || !_isTokenCurrent(token)) {
      await clearToken();
      return null;
    }

    final roleId = int.tryParse(
      (user['rtype_id'] ?? user['usertype_id'])?.toString() ?? '',
    );
    if (roleId != 2 && roleId != 3) {
      await clearToken();
      return null;
    }
    return roleId;
  }

  /// Checks a locally restored JWT with an authenticated, read-only endpoint.
  /// A token can still be unexpired locally after the server has revoked it or
  /// changed signing keys. Network failures deliberately keep the local
  /// session so a temporarily offline user is not signed out.
  static Future<bool> validateStoredSession() async {
    try {
      await request('GET', '/api/instagram/connection-status');
      return true;
    } on ApiException catch (error) {
      final message = error.message.toLowerCase();
      final isRejectedToken =
          message.contains('invalid token') ||
          message.contains('token missing') ||
          message.contains('session expired') ||
          message.contains('unauthorized');
      if (isRejectedToken) {
        await clearToken();
        return false;
      }
      return true;
    }
  }

  static bool _isTokenCurrent(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return false;
      final payload = jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))),
      );
      if (payload is! Map) return false;
      final expiry = int.tryParse(payload['exp']?.toString() ?? '');
      if (expiry == null) return false;
      return DateTime.now().isBefore(
        DateTime.fromMillisecondsSinceEpoch(expiry * 1000),
      );
    } catch (_) {
      return false;
    }
  }

  /// `API_BASE_URL` takes priority, allowing release builds to supply their
  /// deployed API without changing source code.
  static String get baseUrl =>
      _configuredBaseUrl.isNotEmpty ? _configuredBaseUrl : _liveBaseUrl;

  static bool get usesNgrok =>
      Uri.tryParse(baseUrl)?.host.endsWith('.ngrok-free.dev') ?? false;

  static Future<Map<String, dynamic>> request(
    String method,
    String path, [
    Map<String, dynamic>? body,
    Duration responseTimeout = const Duration(seconds: 8),
  ]) =>
      _request(method, path, body, responseTimeout, retryOnSocketFailure: true);

  static Future<Map<String, dynamic>> _request(
    String method,
    String path,
    Map<String, dynamic>? body,
    Duration responseTimeout, {
    required bool retryOnSocketFailure,
  }) async {
    final client = HttpClient()
      ..connectionTimeout = const Duration(seconds: 12);
    final isAuthenticationRequest =
        path.startsWith('/api/auth/login') ||
        path.startsWith('/api/auth/signup');
    try {
      final request = await client
          .openUrl(method, Uri.parse('$baseUrl$path'))
          .timeout(const Duration(seconds: 12));
      request.headers.contentType = ContentType.json;
      // Free ngrok tunnels otherwise return their HTML warning page instead
      // of the API response. This header is only sent for a tunnel URL.
      if (usesNgrok) {
        request.headers.set('ngrok-skip-browser-warning', '1');
      }
      if (!isAuthenticationRequest) {
        final token = await readToken();
        if (token != null) {
          request.headers.set('Authorization', 'Bearer $token');
        }
      }
      if (body != null) request.write(jsonEncode(body));
      final response = await request.close().timeout(responseTimeout);
      final raw = await utf8.decoder.bind(response).join();
      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) {
        throw const ApiException('The server returned an unexpected response.');
      }
      if (response.statusCode < 200 ||
          response.statusCode >= 300 ||
          decoded['status'] == false ||
          decoded['status'] == 'fail') {
        throw ApiException(decoded['message']?.toString() ?? 'Request failed.');
      }
      return decoded;
    } on SocketException {
      if (retryOnSocketFailure) {
        await Future<void>.delayed(const Duration(milliseconds: 500));
        return _request(
          method,
          path,
          body,
          responseTimeout,
          retryOnSocketFailure: false,
        );
      }
      throw const ApiException('Cannot connect to the backend.');
    } on HandshakeException {
      throw const ApiException('Could not establish a secure connection.');
    } on FormatException {
      throw const ApiException('The server returned invalid JSON.');
    } on HttpException {
      throw const ApiException('The server closed the connection.');
    } on TimeoutException {
      throw const ApiException('The backend did not respond in time.');
    } finally {
      client.close(force: true);
    }
  }

  static Future<int> countryCodeId(String code) async {
    final result = await request('GET', '/api/admin/country-phone-codes');
    final codes = result['data'];
    if (codes is List) {
      for (final item in codes) {
        if (item is Map && item['country_code']?.toString() == code) {
          final id = item['id'];
          if (id is int) return id;
          final parsed = int.tryParse(id.toString());
          if (parsed != null) return parsed;
        }
      }
    }
    throw ApiException('Country code $code is not available on the backend.');
  }

  static Future<void> signup({
    required String name,
    required String email,
    required String password,
    required bool isCreator,
    required String phone,
    required String countryCode,
  }) async {
    final parts = name.trim().split(RegExp(r'\s+'));
    final codeId = phone.isEmpty ? null : await countryCodeId(countryCode);
    await request('POST', '/api/auth/signup', {
      'name': name,
      'first_name': parts.first,
      'last_name': parts.length > 1 ? parts.sublist(1).join(' ') : '',
      'country_code_id': codeId,
      'mobile_number': phone.isEmpty ? null : phone,
      'email': email,
      'password': password,
      'rtype_id': isCreator ? 2 : 3,
    });
  }

  static Future<String> requestPasswordReset(String email) async {
    final result = await request('POST', '/api/auth/forgot-password', {
      'email': email.trim(),
    });
    final data = result['data'];
    final userId = data is Map ? data['user_id']?.toString() : null;
    if (userId == null || userId.isEmpty) {
      throw const ApiException('The server did not return a reset request.');
    }
    return userId;
  }

  /// Verifies the OTP and returns the short-lived token required by the
  /// current reset-password API.
  static Future<String> verifyPasswordResetOtp({
    required String userId,
    required String otp,
  }) async {
    final result = await request(
      'POST',
      '/api/auth/verify-forgot-password-otp',
      {'user_id': userId, 'otp': otp.trim()},
    );
    final data = result['data'];
    final resetToken = data is Map ? data['reset_token']?.toString() : null;
    if (resetToken == null || resetToken.isEmpty) {
      throw const ApiException(
        'The server did not return a password reset token.',
      );
    }
    return resetToken;
  }

  static Future<void> resetPassword({
    required String resetToken,
    required String password,
  }) => request('POST', '/api/auth/reset-password', {
    'reset_token': resetToken,
    'new_password': password,
  });

  static Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) => request('POST', '/api/auth/change-password', {
    'old_password': oldPassword,
    'new_password': newPassword,
  });

  static Future<void> login({
    required String login,
    required String password,
    required bool isCreator,
  }) async {
    final result = await request('POST', '/api/auth/login', {
      'login': login,
      'password': password,
    });
    final data = result['data'];
    final token = data is Map ? data['token'] : null;
    if (token is! String || token.isEmpty) {
      throw const ApiException('The login response did not include a token.');
    }
    final user = data is Map ? data['user'] : null;
    if (user is! Map) {
      throw const ApiException('The login response did not include a user.');
    }
    final roleId = int.tryParse(
      (user['rtype_id'] ?? user['usertype_id'])?.toString() ?? '',
    );
    if (roleId != (isCreator ? 2 : 3)) {
      throw ApiException(
        isCreator
            ? 'This account is not a Creator account.'
            : 'This account is not a Brand or Agency account.',
      );
    }
    await _storage.write(key: _tokenKey, value: token);
    await saveUser(Map<String, dynamic>.from(user));
  }
}
