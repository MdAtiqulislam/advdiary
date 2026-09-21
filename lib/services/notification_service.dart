
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import '../app/routes/app_pages.dart';
import 'package:http/http.dart' as http;

class NotificationServices {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  /// Subscribe to FCM topic
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _messaging.subscribeToTopic(topic);
      if (kDebugMode) print("Subscribed to topic: $topic");
    } catch (e) {
      if (kDebugMode) print("Error subscribing topic: $e");
    }
  }

  /// Request iOS permissions (skip Android)
  Future<void> requestPermission() async {
    if (Platform.isAndroid) return;
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    if (kDebugMode) print("Permission: ${settings.authorizationStatus}");
  }

  /// Initialize local notifications
  Future<void> initLocalNotification() async {
    const AndroidInitializationSettings androidInit =
    AndroidInitializationSettings('@mipmap/launcher_icon');

    const DarwinInitializationSettings iosInit = DarwinInitializationSettings();

    const InitializationSettings initSettings =
    InitializationSettings(android: androidInit, iOS: iosInit);

    await _flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (payload) {
        if ((payload.payload ?? "").isNotEmpty) {
          _handleTap(payload.payload);
        }
      },
    );

    // Create notification channel (important for Android release)
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'Used for important notifications',
      importance: Importance.high,
      playSound: true,
    );

    final androidPlugin = _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    if (androidPlugin != null) {
      await androidPlugin.createNotificationChannel(channel);
    }
  }

  /// Show notification for foreground messages
  Future<void> showForegroundNotification(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) return;

    String? imageUrl;
    if (message.notification?.android?.imageUrl != null) {
      imageUrl = message.notification!.android!.imageUrl;
    } else if (message.notification?.apple?.imageUrl != null) {
      imageUrl = message.notification!.apple!.imageUrl;
    }

    AndroidNotificationDetails androidDetails;

    if (imageUrl != null && imageUrl.isNotEmpty) {
      final String localPath = await _downloadAndSaveImage(imageUrl, 'notif_image.jpg');

      final bigPictureStyle = BigPictureStyleInformation(
        FilePathAndroidBitmap(localPath),
        contentTitle: notification.title,
        summaryText: notification.body,
      );

      androidDetails = AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        channelDescription: 'Used for important notifications',
        importance: Importance.high,
        priority: Priority.high,
        playSound: true,
        styleInformation: bigPictureStyle,
      );
    } else {
      androidDetails = const AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        channelDescription: 'Used for important notifications',
        importance: Importance.high,
        priority: Priority.high,
        playSound: true,
      );
    }

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final NotificationDetails details =
    NotificationDetails(android: androidDetails, iOS: iosDetails);

    await _flutterLocalNotificationsPlugin.show(
      0,
      notification.title,
      notification.body,
      details,
      payload: message.data["function"],
    );
  }

  /// Download image to local storage
  Future<String> _downloadAndSaveImage(String url, String fileName) async {
    try {
      final Directory dir = await getApplicationDocumentsDirectory();
      final String filePath = '${dir.path}/$fileName';
      final http.Response response = await http.get(Uri.parse(url));
      final File file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      return filePath;
    } catch (_) {
      return '';
    }
  }

  /// Handle notification tap
  void _handleTap(String? functionName) {
/*    if (functionName == null || functionName.isEmpty) return;

    if (!Get.isRegistered<WebPageViewController>()) {
      Get.put(WebPageViewController());
    }

    final controller = Get.find<WebPageViewController>();
    controller.loadData(functionName);
    Get.toNamed(Routes.WEB_PAGE_VIEW);*/
  }

  /// Setup Firebase Messaging listeners
  Future<void> setupFirebaseMessaging() async {
    FirebaseMessaging.onMessage.listen((message) async {
      if (kDebugMode) print("🔔 Foreground FCM: ${message.data}");
      await showForegroundNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (kDebugMode) print("🔔 Notification tapped: ${message.data}");
      _handleTap(message.data["function"]);
    });

    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null && initialMessage.data.isNotEmpty) {
      _handleTap(initialMessage.data["function"]);
    }
  }

  /// Get device token
  Future<String?> getDeviceToken() async {
    try {
      final token = await _messaging.getToken();
      if (kDebugMode) print("FCM Token: $token");
      return token;
    } catch (_) {
      return null;
    }
  }
}

