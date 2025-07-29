import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';

import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;


class NotificationService {
  final notificationPlugin = FlutterLocalNotificationsPlugin();
  bool _isIntialization = false;

  bool get isInitialization => _isIntialization;

  //Initialization
  Future<void> initNotification() async {
    if (_isIntialization) return;
    // initialize the timezone
    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    const initSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettingIOS = DarwinInitializationSettings(requestAlertPermission: true, requestBadgePermission: true, requestSoundPermission: true);

    const initSettings = InitializationSettings(android: initSettingsAndroid, iOS: initSettingIOS);

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

    const iosDetails = DarwinNotificationDetails(presentAlert: true, presentBadge: true, presentSound: true);

    return const NotificationDetails(android: androidDetails, iOS: iosDetails);
  }

  // showNotification --> INSTANT NOTIFICATION
  Future<void> showNotification({required int id, required String title, required String body}) async {
    print("Showing notification...");
    await notificationPlugin.show(id, title, body, notificationDetails());
  }


  // Future<void> scheduleNotification({required int id, required String title, required String body, required int hour, required int minute }) async {
  //   // get the current date time in device for local timezone
  //   print ("checking Schedule Notification");
  //  try{
  //    print("schedule ");
  //    final now = tz.TZDateTime.now(tz.local);
  //    var scheduleDate = tz.TZDateTime(
  //      tz.local,
  //      now.year,
  //      now.month,
  //      now.day,
  //      hour,
  //      minute,
  //    );
  //    if (scheduleDate.isBefore(now)) {
  //      print("🔁 Time is in the past, moving to next day");
  //      scheduleDate = scheduleDate.add(Duration(days: 1));
  //    }
  //    await notificationPlugin.zonedSchedule(
  //        id,
  //        title,
  //        body,
  //        scheduleDate,
  //        notificationDetails(),
  //        //android specific datetime
  //        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  //        //if you want to repeat daily at the same time
  //        matchDateTimeComponents: DateTimeComponents.time
  //    );
  //  }catch(e){
  //    print("failed to schedule notification");
  //  }
  //
  //
  // }
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute
  }) async {
    print("📆 Checking Schedule Notification");

    try {
      final now = tz.TZDateTime.now(tz.local);
      var scheduleDate = tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        now.day,
        hour,
        minute,
      );

      if (scheduleDate.isBefore(now)) {
        print("🔁 Time is in the past, moving to next day");
        scheduleDate = scheduleDate.add(Duration(days: 1));
      }

      await notificationPlugin.zonedSchedule(
        id,
        title,
        body,
        scheduleDate,
        notificationDetails(),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        // uiLocalNotificationDateInterpretation:
        // UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );

      print("✅ Notification scheduled for $scheduleDate");
    } catch (e, stack) {
      print("❌ Failed to schedule notification: $e");
      print("📌 Stack trace: $stack");
    }
  }

  // to cancel all Notification that are currently active
  Future<void> cancelAllNotification () async{
    await notificationPlugin.cancelAll();
  }
}
