import 'package:calory_calc/repositories/notifications/models/notifications_config.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class NotificationsState extends Equatable {
  NotificationsState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends NotificationsState {}

class Initialized extends NotificationsState {
  final NotificationsConfig config;

  Initialized({@required this.config});

  @override
  List<Object> get props => [config];
}
