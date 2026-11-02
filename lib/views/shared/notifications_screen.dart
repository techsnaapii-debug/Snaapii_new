import 'package:flutter/material.dart';

import '../../services/auth_api.dart';
import '../../services/notification_api.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<AppNotification> _notifications = const [];
  bool _loading = true;
  bool _markingAll = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    if (mounted) {
      setState(() {
        _loading = true;
        _error = null;
      });
    }
    try {
      final notifications = await NotificationApi.list();
      if (!mounted) return;
      setState(() => _notifications = notifications);
    } on ApiException catch (error) {
      if (mounted) setState(() => _error = error.message);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _markAllRead() async {
    if (_markingAll) return;
    setState(() => _markingAll = true);
    try {
      await NotificationApi.markAllRead();
      if (!mounted) return;
      setState(() {
        _notifications = _notifications
            .map(
              (item) => AppNotification(
                id: item.id,
                title: item.title,
                body: item.body,
                isRead: true,
                createdAt: item.createdAt,
              ),
            )
            .toList();
      });
    } on ApiException catch (error) {
      if (mounted) _message(error.message);
    } finally {
      if (mounted) setState(() => _markingAll = false);
    }
  }

  Future<void> _open(AppNotification item) async {
    if (item.isRead || item.id.isEmpty) return;
    try {
      await NotificationApi.markRead(item.id);
      if (!mounted) return;
      setState(() {
        _notifications = _notifications
            .map(
              (entry) => entry.id == item.id
                  ? AppNotification(
                      id: entry.id,
                      title: entry.title,
                      body: entry.body,
                      isRead: true,
                      createdAt: entry.createdAt,
                    )
                  : entry,
            )
            .toList();
      });
    } on ApiException catch (error) {
      if (mounted) _message(error.message);
    }
  }

  void _message(String value) => ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text(value)));

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Notifications'),
      actions: [
        TextButton(
          onPressed: _markingAll || _notifications.every((item) => item.isRead)
              ? null
              : _markAllRead,
          child: Text(_markingAll ? 'Saving…' : 'Mark all read'),
        ),
      ],
    ),
    body: _loading
        ? const Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            onRefresh: _load,
            child: _error != null
                ? ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Text(_error!, textAlign: TextAlign.center),
                      ),
                    ],
                  )
                : _notifications.isEmpty
                ? ListView(
                    children: const [
                      SizedBox(height: 150),
                      Icon(Icons.notifications_none_rounded, size: 48),
                      SizedBox(height: 12),
                      Center(child: Text('You have no notifications yet.')),
                    ],
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: _notifications.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 10),
                    itemBuilder: (_, index) {
                      final item = _notifications[index];
                      return Material(
                        color: item.isRead
                            ? Colors.white
                            : const Color(0xFFF1EEFF),
                        borderRadius: BorderRadius.circular(14),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(14),
                          onTap: () => _open(item),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: const Color(0xFFE4DFFF),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  item.isRead
                                      ? Icons.notifications_none_rounded
                                      : Icons.notifications_rounded,
                                  color: const Color(0xFF6B4EFF),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.title,
                                        style: TextStyle(
                                          fontWeight: item.isRead
                                              ? FontWeight.w500
                                              : FontWeight.w700,
                                        ),
                                      ),
                                      if (item.body.isNotEmpty) ...[
                                        const SizedBox(height: 4),
                                        Text(item.body),
                                      ],
                                      if (item.createdAt != null) ...[
                                        const SizedBox(height: 5),
                                        Text(
                                          item.createdAt!,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
  );
}
