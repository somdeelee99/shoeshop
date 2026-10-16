import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import '../constants/app_constants.dart';
import 'storage_service.dart';

/// Push notification service backed by Firebase Cloud Messaging.
/// Initialization is fail-safe: the app keeps working without Firebase config.
class NotificationService {
  NotificationService._();

  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static Future<void> init() async {
    try {
      // Requires `flutterfire configure` (google-services.json / GoogleService-Info.plist)
      await Firebase.initializeApp();

      final settings = await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      debugPrint('FCM permission: ${settings.authorizationStatus}');

      final token = await _messaging.getToken();
      if (token != null) {
        await StorageService.setSecure(AppConstants.keyFcmToken, token);
        debugPrint('FCM token: $token');
      }

      _messaging.onTokenRefresh.listen((t) {
        StorageService.setSecure(AppConstants.keyFcmToken, t);
      });

      FirebaseMessaging.onMessage.listen(_onForeground);
      FirebaseMessaging.onMessageOpenedApp.listen(_onOpen);
    } catch (e) {
      debugPrint('NotificationService.init skipped: $e');
    }
  }

  static void _onForeground(RemoteMessage message) {
    debugPrint('FCM foreground: ${message.notification?.title}');
  }

  static void _onOpen(RemoteMessage message) {
    debugPrint('FCM opened: ${message.data}');
  }

  static Future<String?> getToken() async {
    try {
      return await _messaging.getToken();
    } catch (_) {
      return StorageService.getSecure(AppConstants.keyFcmToken);
    }
  }

  static Future<void> subscribe(String topic) async {
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      try {
        await _messaging.subscribeToTopic(topic);
      } catch (e) {
        debugPrint('subscribe($topic) failed: $e');
      }
    }
  }
}
