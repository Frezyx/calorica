import 'package:calory_calc/common/abstracts/abstracts.dart';
import 'package:calory_calc/repositories/notifications/repository.dart';

abstract class AbstractLocalNotificationsRepository
    implements CommonRepository {
  AbstractLocalNotificationsConfigRepository get configuration;
}
