import 'dart:async';

import 'package:calorica/repositories/user_repository/repository.dart';
import 'package:hive/hive.dart';

class LocalUserRepository extends AbstractLocalUserRepository {
  Box<User> _userBox;
  static const BOX_NAME = 'user_box';
  static const USER_KEY = 0;

  final _updatesController = StreamController<User>.broadcast();

  @override
  Stream<User> get updatesStream => _updatesController.stream;

  @override
  Future<void> initialize() async {
    _userBox = await Hive.openBox(BOX_NAME);
  }

  @override
  Future<void> edit(User user) async {
    await _userBox.putAt(USER_KEY, user);
  }

  @override
  Future<User> get() async {
    return _userBox.getAt(USER_KEY);
  }

  @override
  Future<void> close() async {
    await _userBox.close();
    await _updatesController?.close();
  }
}
