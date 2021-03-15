import 'package:calory_calc/repositories/notifications/repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class AbstractLocalNotificationsServie {
  Future<void> initialize();

  Future<void> show({
    @required String title,
    @required String body,
    String payload,
  });

  Future<void> showPeriodically({
    @required String title,
    @required String body,
    @required RepeatInterval repeat,
    String payload,
  });

  Future<void> setupNotifications(NotificationsConfig config);

  Future<void> cancelAll();
}
