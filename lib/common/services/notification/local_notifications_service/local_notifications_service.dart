import 'package:calory_calc/common/services/notification/service.dart';
import 'package:calory_calc/common/services/time_zone/service.dart';
import 'package:calory_calc/common/theme/custom_theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class LocalNotificationsService implements AbstractLocalNotificationsServie {
  LocalNotificationsService._();
  static LocalNotificationsService _service;

  FlutterLocalNotificationsPlugin notifyPlugin =
      FlutterLocalNotificationsPlugin();

  static LocalNotificationsService get instance {
    if (_service == null) {
      _service = LocalNotificationsService._();
    }
    return _service;
  }

  final androidDefaultDetails = new AndroidNotificationDetails(
    "calorica_default_notifications_channel",
    "Clorica Default Android Notifications Channel",
    "For default notifications",
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    color: CustomTheme.mainColor,
  );
  final iOSDefaultSettings = new IOSNotificationDetails();

  @override
  Future<void> initialize() async {
    final String currentTimeZone =
        await FlutterNativeTimezone.getLocalTimezone();
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    final android = AndroidInitializationSettings('ic_notification');
    final iOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (
        int id,
        String title,
        String body,
        String payload,
      ) async {},
    );
    final initSettings = InitializationSettings(android: android, iOS: iOS);
    await notifyPlugin.initialize(
      initSettings,
    );
  }

  @override
  Future<void> setupNotifications(NotificationsConfig config) {}

  @override
  Future<void> show({
    @required String title,
    @required String body,
    String payload,
  }) async {
    final generalNotificationDetails = NotificationDetails(
      android: androidDefaultDetails,
      iOS: iOSDefaultSettings,
    );
    await notifyPlugin.show(
      0,
      title,
      body,
      generalNotificationDetails,
      payload: payload,
    );
  }

  @override
  Future<void> showPeriodically(
      {String title, String body, RepeatInterval repeat, String payload}) {
    // TODO: implement showPeriodically
    throw UnimplementedError();
  }

  @override
  Future<void> cancelAll() {
    // TODO: implement cancelAll
    throw UnimplementedError();
  }
}
