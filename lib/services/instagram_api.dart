import 'package:url_launcher/url_launcher.dart';

import 'auth_api.dart';

class InstagramConnectionStatus {
  const InstagramConnectionStatus({
    required this.connected,
    required this.reconnectRequired,
  });

  final bool connected;
  final bool reconnectRequired;
}

class InstagramAnalytics {
  const InstagramAnalytics({required this.stats, required this.media});

  final Map<String, dynamic> stats;
  final List<Map<String, dynamic>> media;
}

class InstagramApi {
  /// Reads the server-side connection state for the logged-in user. The user
  /// identity comes from the Snaapii JWT; Flutter does not send a user ID.
  static Future<InstagramConnectionStatus> connectionStatus() async {
    final result = await AuthApi.request(
      'GET',
      '/api/instagram/connection-status',
    );
    final data = result['data'];
    if (data is! Map) {
      throw const ApiException(
        'The server returned an invalid connection status.',
      );
    }
    return InstagramConnectionStatus(
      connected: data['connected'] == true,
      reconnectRequired: data['reconnect_required'] == true,
    );
  }

  /// Gets a short-lived Meta authorization URL from the backend and opens it
  /// outside the app. The backend owns OAuth state and all Meta secrets.
  static Future<void> startConnection() async {
    final result = await AuthApi.request('GET', '/api/instagram/auth-url');
    final data = result['data'];
    final rawUrl = data is Map ? data['auth_url']?.toString() : null;
    final uri = rawUrl == null ? null : Uri.tryParse(rawUrl);
    if (uri == null || !uri.hasScheme || uri.host.isEmpty) {
      throw const ApiException(
        'The server did not return a valid Meta login URL.',
      );
    }
    final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!opened) {
      throw const ApiException('Could not open Meta login. Please try again.');
    }
  }

  /// Detailed per-post analytics for the currently signed-in account.
  static Future<InstagramAnalytics> mediaInsights() async {
    final result = await AuthApi.request(
      'GET',
      '/api/instagram/media-insights',
    );
    final data = result['data'];
    if (data is! Map) {
      throw const ApiException(
        'The server returned invalid Instagram analytics.',
      );
    }
    final media = data['media'];
    return InstagramAnalytics(
      stats: Map<String, dynamic>.from(data['stats'] as Map? ?? const {}),
      media: (media as List? ?? const [])
          .whereType<Map>()
          .map((item) => Map<String, dynamic>.from(item))
          .toList(),
    );
  }

  static Future<Map<String, dynamic>> weeklyGrowth() async {
    final result = await AuthApi.request('GET', '/api/instagram/weekly-growth');
    final data = result['data'];
    if (data is! Map) {
      throw const ApiException(
        'The server returned invalid weekly growth data.',
      );
    }
    return Map<String, dynamic>.from(data);
  }
}
