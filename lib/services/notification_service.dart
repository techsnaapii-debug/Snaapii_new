import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'auth_api.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

/// Handles notification permission, FCM tokens, and foreground notification UI.
///
/// Device tokens are registered with the API after sign-in when Firebase is
/// configured for the installed app.
class NotificationService {
  NotificationService._();

  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();
  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'high_importance_channel',
    'Snaapii notifications',
    description: 'Campaign, message, and account notifications.',
    importance: Importance.high,
  );

  static StreamSubscription<RemoteMessage>? _foregroundSubscription;
  static StreamSubscription<String>? _tokenRefreshSubscription;
  static bool _initialized = false;

  static Future<void> initialize() async {
    if (_initialized) return;

    try {
      await Firebase.initializeApp();
      final messaging = FirebaseMessaging.instance;
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
      await messaging.requestPermission(alert: true, badge: true, sound: true);

      const androidInitialization = AndroidInitializationSettings(
        '@drawable/ic_stat_notification',
      );
      await _localNotifications.initialize(
        const InitializationSettings(android: androidInitialization),
      );

      final androidPlugin = _localNotifications
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      await androidPlugin?.createNotificationChannel(_channel);

      await messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
      _foregroundSubscription = FirebaseMessaging.onMessage.listen(
        _showForegroundNotification,
      );
      _tokenRefreshSubscription = messaging.onTokenRefresh.listen(
        (_) => registerCurrentToken(),
      );
      _initialized = true;
    } on FirebaseException catch (error) {
      // Firebase config is not committed to source control. The app stays
      // usable until google-services.json / GoogleService-Info.plist is added.
      debugPrint('Notifications are not configured: ${error.code}');
    } catch (error) {
      debugPrint('Unable to initialise notifications: $error');
    }
  }

  static Future<String?> currentToken() async {
    if (!_initialized) return null;
    return FirebaseMessaging.instance.getToken();
  }

  /// Registers this device after a user session has been established.
  ///
  /// The latest backend exposes this at POST /api/fcm/token. Failures are
  /// intentionally non-blocking so authentication remains available while an
  /// older backend is still deployed or the device is offline.
  static Future<void> registerCurrentToken() async {
    if (!_initialized) return;

    try {
      final token = await currentToken();
      if (token == null || token.isEmpty) return;
      await AuthApi.request('POST', '/api/fcm/token', {
        'fcm_token': token,
        'device_type': kIsWeb
            ? 'web'
            : Platform.isIOS
            ? 'ios'
            : 'android',
      });
    } catch (error) {
      debugPrint('Unable to register the notification token: $error');
    }
  }

  static void _showForegroundNotification(RemoteMessage message) {
    final notification = message.notification;
    if (notification == null) return;

    _localNotifications.show(
      notification.hashCode,
      notification.title ?? 'Snaapii',
      notification.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel',
          'Snaapii notifications',
          channelDescription: 'Campaign, message, and account notifications.',
          importance: Importance.high,
          priority: Priority.high,
          icon: '@drawable/ic_stat_notification',
        ),
      ),
    );
  }

  static Future<void> dispose() async {
    await _foregroundSubscription?.cancel();
    await _tokenRefreshSubscription?.cancel();
  }
}
