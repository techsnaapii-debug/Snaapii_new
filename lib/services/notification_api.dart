import 'auth_api.dart';

class AppNotification {
  const AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.isRead,
    this.createdAt,
  });

  final String id;
  final String title;
  final String body;
  final bool isRead;
  final String? createdAt;

  factory AppNotification.fromJson(Map item) {
    final rawRead = item['is_read'] ?? item['read'];
    final isRead = rawRead == true || rawRead == 1 || rawRead == '1';
    return AppNotification(
      id: (item['id'] ?? item['notification_id'] ?? '').toString(),
      title: (item['title'] ?? item['notification_title'] ?? 'Snaapii')
          .toString(),
      body: (item['body'] ?? item['message'] ?? item['notification_body'] ?? '')
          .toString(),
      isRead: isRead,
      createdAt: item['created_at']?.toString(),
    );
  }
}

class NotificationApi {
  static Future<List<AppNotification>> list() async {
    final result = await AuthApi.request('GET', '/api/fcm');
    final data = result['data'];
    if (data is! List) {
      throw const ApiException('The server returned invalid notifications.');
    }
    return data.whereType<Map>().map(AppNotification.fromJson).toList();
  }

  static Future<int> unreadCount() async {
    final result = await AuthApi.request('GET', '/api/fcm/unread-count');
    final data = result['data'];
    final count = data is Map ? (data['count'] ?? data['unread_count']) : null;
    return count is num ? count.toInt() : int.tryParse('$count') ?? 0;
  }

  static Future<void> markRead(String id) =>
      AuthApi.request('PATCH', '/api/fcm/${Uri.encodeComponent(id)}/read');

  static Future<void> markAllRead() =>
      AuthApi.request('PATCH', '/api/fcm/read-all');
}
