import 'package:calorica/abstracts/abstracts.dart';
import 'package:calorica/repositories/user_repository/repository.dart';

abstract class AbstractUserRepository implements AbstractCommonRepository{
  Future<void> edit(User user);
  Future<User> get();
}