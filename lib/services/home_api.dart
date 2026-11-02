import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'auth_api.dart';

class HomeApi {
  static Future<List<Map<String, dynamic>>> _list(String path) async {
    final client = HttpClient()..connectionTimeout = const Duration(seconds: 5);
    try {
      final request = await client
          .getUrl(Uri.parse('${AuthApi.baseUrl}$path'))
          .timeout(const Duration(seconds: 8));
      if (AuthApi.usesNgrok) {
        request.headers.set('ngrok-skip-browser-warning', '1');
      }
      final token = await AuthApi.readToken();
      if (token != null) {
        request.headers.set('Authorization', 'Bearer $token');
      }
      final response = await request.close().timeout(
        const Duration(seconds: 8),
      );
      final body = jsonDecode(await utf8.decoder.bind(response).join());
      if (response.statusCode != 200 || body is! Map || body['data'] is! List) {
        throw ApiException(
          body is Map
              ? body['message']?.toString() ?? 'Could not load home content.'
              : 'The server returned an unexpected response.',
        );
      }
      return (body['data'] as List)
          .whereType<Map>()
          .map((item) => Map<String, dynamic>.from(item))
          .toList();
    } on SocketException {
      throw const ApiException('Cannot connect to the backend.');
    } on TimeoutException {
      throw const ApiException('The backend did not respond in time.');
    } on FormatException {
      throw const ApiException('The server returned invalid JSON.');
    } finally {
      client.close(force: true);
    }
  }

  static Future<List<Map<String, dynamic>>> banners() => _list('/api/banners');

  /// Published trending audios available to the signed-in Creator.
  static Future<List<Map<String, dynamic>>> trendingAudios() =>
      _list('/api/trending-audios');

  static Future<List<Map<String, dynamic>>> videos(String audience) async {
    final result = await _list('/api/videos');
    return result
        .where(
          (item) =>
              item['status'] == 'published' &&
              (item['audience'] == audience || item['audience'] == 'both'),
        )
        .toList();
  }

  static Future<List<Map<String, dynamic>>> creatorCampaigns() async {
    final token = await AuthApi.readToken();
    if (token == null) throw const ApiException('Please log in again.');
    return _list('/api/collab/campaigns');
  }

  /// Instagram posts/reels belonging to the currently signed-in Creator.
  /// This deliberately uses the existing Node endpoint; no automation data is
  /// created or stored from the app.
  static Future<List<Map<String, dynamic>>> creatorInstagramMedia() async {
    final result = await AuthApi.request('GET', '/api/instagram/media');
    final data = result['data'];
    if (data is! List) return const [];
    return data
        .whereType<Map>()
        .map((item) => Map<String, dynamic>.from(item))
        .toList();
  }

  /// Complete Instagram data for the signed-in Creator, including live
  /// profile statistics and media. The server returns an error when no
  /// Instagram Business account has been connected yet.
  static Future<Map<String, dynamic>> creatorInstagramProfile() async {
    final result = await AuthApi.request('GET', '/api/instagram/profile-full');
    final data = result['data'];
    if (data is! Map) {
      throw const ApiException(
        'The server returned an invalid Instagram profile.',
      );
    }
    return Map<String, dynamic>.from(data);
  }

  static String? mediaUrl(Object? path) {
    final value = path?.toString().trim();
    if (value == null || value.isEmpty) return null;
    final uri = Uri.tryParse(value);
    if (uri == null) return null;
    if (uri.hasScheme) {
      if (!uri.isScheme('http') && !uri.isScheme('https')) return null;
      if (Platform.isAndroid &&
          (uri.host == 'localhost' || uri.host == '127.0.0.1')) {
        return uri.replace(host: '10.0.2.2').toString();
      }
      return value;
    }
    return '${AuthApi.baseUrl}/${value.replaceAll('\\', '/').replaceFirst(RegExp(r'^/+'), '')}';
  }
}
