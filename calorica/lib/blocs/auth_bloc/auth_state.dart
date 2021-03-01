import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class Loading extends AuthState {}

class Authenticated extends AuthState {}

class Unauthenticated extends AuthState {
  const Unauthenticated({this.isFirstLaunch = false});
  final bool isFirstLaunch;
  @override
  List<Object> get props => [];
}
