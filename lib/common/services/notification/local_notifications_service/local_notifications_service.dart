import 'package:calory_calc/common/services/notification/service.dart';
import 'package:calory_calc/common/theme/custom_theme/custom_theme.dart';
import 'package:calory_calc/repositories/notifications/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

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

    final android = AndroidInitializationSettings('notify_icon');
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
  Future<void> setupNotifications(NotificationsConfig config) async {
    if ((await notifyPlugin.pendingNotificationRequests()).isNotEmpty) {
      await notifyPlugin.cancelAll();
    }

    if (!config.enabled) {
      return;
    }

    //TODO: Replace in localization
    showPeriodically(
      title: "Не сбивайте свой режим!",
      body: "Чтоб диета была продуктивной - нужно вести ежедневный учет",
      repeat: RepeatInterval.daily,
    );
  }

  @override
  Future<void> show({
    @required String title,
    @required String body,
    String payload = '',
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
  Future<void> showPeriodically({
    @required String title,
    @required String body,
    @required RepeatInterval repeat,
    String payload = '',
  }) async {
    final generalNotificationDetails = NotificationDetails(
      android: androidDefaultDetails,
      iOS: iOSDefaultSettings,
    );

    await notifyPlugin.periodicallyShow(
      2,
      title,
      body,
      repeat,
      generalNotificationDetails,
      androidAllowWhileIdle: true,
      payload: payload,
    );
  }

  @override
  Future<void> cancelAll() async {
    await notifyPlugin.cancelAll();
  }
}
