import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final notificationPlugin = FlutterLocalNotificationsPlugin();
  bool _isIntialization = false;

  bool get isInitialization => _isIntialization;

  //Initialization
  Future<void> initNotification() async {
    if (_isIntialization) return;

    const initSettingsAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const initSettingIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingIOS,
    );

    await notificationPlugin.initialize(initSettings);
    _isIntialization = true;
  }

  //   Notification Detail SETUP
  NotificationDetails notificationDetails() {
    const androidDetails = AndroidNotificationDetails(
      'daily_channel_id', // MUST be non-null and unique
      'Daily Notification',
      channelDescription: 'This channel is for daily notifications',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableLights: true,
      enableVibration: true,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    return const NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
  }


  // showNotification
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    print("Showing notification...");
    await notificationPlugin.show(
      id,
      title,
      body,
      notificationDetails(),
    );
  }
}
