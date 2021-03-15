import 'package:calory_calc/config/adMobConfig.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

import 'calorica_app.dart';
import 'common/services/hive_service/hive_service.dart';
import 'common/services/notification/service.dart';
import 'repositories/notifications/local_notifications_repository/repository.dart';
import 'repositories/repositories_container/repositories_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final _hiveService = HiveService();
  final _repositoriesContainer = RepositoriesContainer(
    notificationsRepository: HiveLocalNotificationsRepository(
      configRepository: HiveLocalNotificationsConfigRepository(),
    ),
  );
  await FirebaseAdMob.instance.initialize(appId: AdMobConfig.APP_ID);
  await LocalNotificationsService.instance.initialize();
  await _hiveService.initialize();
  await _repositoriesContainer.initialize();

  runApp(
    CaloricaApp(
      repositoriesContainer: _repositoriesContainer,
    ),
  );
}
