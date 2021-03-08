import 'package:calory_calc/repositories/notifications/repository.dart';
import 'package:flutter/foundation.dart';

class HiveLocalNotificationsRepository
    implements AbstractLocalNotificationsRepository {
  const HiveLocalNotificationsRepository({
    @required AbstractLocalNotificationsConfigRepository configRepository,
  }) : _configRepository = configRepository;
  final AbstractLocalNotificationsConfigRepository _configRepository;

  @override
  Future<void> close() async {
    await _configRepository.close();
  }

  @override
  AbstractLocalNotificationsConfigRepository get configuration =>
      _configRepository;

  @override
  Future<void> open() async {
    await _configRepository.open();
  }
}
