import 'package:calory_calc/repositories/notifications/repository.dart';
import 'package:hive/hive.dart';

class HiveLocalNotificationsConfigRepository
    implements AbstractLocalNotificationsConfigRepository {
  static const NOTIFICATIONS_CONFIG_BOX = 'notifications_config_box';
  static const MAIN_CONFIG_KEY = 'main_config';

  Box<NotificationsConfig> _box;

  @override
  Future<void> open() async {
    _box = await Hive.openBox<NotificationsConfig>(NOTIFICATIONS_CONFIG_BOX);
  }

  @override
  NotificationsConfig get() => _box.get(MAIN_CONFIG_KEY);

  @override
  Future<void> setup(NotificationsConfig config) async {
    await _box.put(MAIN_CONFIG_KEY, config);
  }

  @override
  Future<void> close() async {
    await _box?.compact();
  }
}
