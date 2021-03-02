import 'package:calory_calc/models/dbModels.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class Authorize extends AuthEvent {
  const Authorize({@required this.user});

  final User user;

  @override
  List<Object> get props => [user];
}

class LoadAuthorization extends AuthEvent {}
