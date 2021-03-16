import 'package:calory_calc/repositories/notifications/repository.dart';
import 'package:flutter/foundation.dart';

class RepositoriesContainer {
  RepositoriesContainer({
    @required this.notificationsRepository,
  });
  final AbstractLocalNotificationsRepository notificationsRepository;

  Future<void> initialize() async {
    Future.wait([
      notificationsRepository.open(),
    ]);
  }

  Future<void> close() async {
    Future.wait([
      notificationsRepository.close(),
    ]);
  }
}
