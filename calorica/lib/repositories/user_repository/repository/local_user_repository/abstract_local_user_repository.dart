import 'package:calorica/abstracts/abstracts.dart';
import 'package:calorica/repositories/user_repository/repository.dart';

abstract class AbstractLocalUserRepository implements AbstractCommonRepository{
  Future<void> edit(User user);
  Future<User> get();
  Stream<User> get updatesStream;
}