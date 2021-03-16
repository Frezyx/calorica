import 'package:calory_calc/common/abstracts/common_repository.dart';
import 'package:calory_calc/repositories/notifications/repository.dart';

abstract class AbstractLocalNotificationsConfigRepository
    implements CommonRepository {
  NotificationsConfig get();
  Future<void> setup(NotificationsConfig config);
}
