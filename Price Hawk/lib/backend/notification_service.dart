import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// 🔧 Call this once during app init
  static Future<void> initialize() async {
    // 🔔 Ask user for permission
    await _messaging.requestPermission();

    // ✅ Init local notification plugin
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings =
        InitializationSettings(android: androidSettings);

    await _flutterLocalNotificationsPlugin.initialize(initSettings);

    // 📥 Handle background message
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showNotification(message.notification?.title ?? 'Price Drop!',
          message.notification?.body ?? 'Check your tracked product.');
    });
  }

  /// 🔔 Show notification locally
  static Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'price_channel',
      'Price Alerts',
      channelDescription: 'Sends price drop alerts',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails platformDetails =
        NotificationDetails(android: androidDetails);

    await _flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformDetails,
    );
  }
}
