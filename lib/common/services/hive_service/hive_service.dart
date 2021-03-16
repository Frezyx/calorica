import 'package:calory_calc/repositories/notifications/repository.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  Future<void> initialize() async {
    await Hive.initFlutter();
    _registerAdapters();
  }

  void _registerAdapters() {
    Hive.registerAdapter(
      NotificationsConfigAdapter(0),
    );
  }
}
