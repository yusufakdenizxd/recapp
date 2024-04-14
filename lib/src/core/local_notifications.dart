import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

class LocalNotification {
  static LocalNotification instance = LocalNotification();
  var flp = FlutterLocalNotificationsPlugin();

  var notInfo = const NotificationDetails(
    android: AndroidNotificationDetails(
      "kanal id",
      "kanal başlık",
      channelDescription: "kanal açıklama",
      priority: Priority.max,
      importance: Importance.max,
    ),
    iOS: DarwinNotificationDetails(),
  );

  Future<void> clearAllNotifications() async {
    await flp.cancelAll();
  }

  Future<void> addNotification({required String title, required String body, required DateTime notificationTime}) async {
    tzdata.initializeTimeZones();
    final scheduleTime = tz.TZDateTime.from(notificationTime, tz.local);
    await flp.zonedSchedule(
      Random().nextInt(25550),
      title,
      body,
      scheduleTime,
      notInfo,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> show({required String title, required String body}) async {
    await flp.show(
      Random().nextInt(2555),
      title,
      body,
      notInfo,
    );
  }

  Future<void> setup() async {
    var androidSettings = const AndroidInitializationSettings("@mipmap/ic_launcher");
    var iosSettings = const DarwinInitializationSettings();
    var initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    await flp.initialize(initSettings);
  }
}
