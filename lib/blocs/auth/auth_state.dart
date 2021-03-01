import 'package:calory_calc/models/dbModels.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {}

class Authorized extends AuthState {
  Authorized(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}

class Unauthorized extends AuthState {}
