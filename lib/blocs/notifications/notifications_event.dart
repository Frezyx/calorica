import 'package:calory_calc/repositories/notifications/models/notifications_config.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class NotificationsEvent extends Equatable {
  NotificationsEvent();

  @override
  List<Object> get props => [];
}

class Initialize extends NotificationsEvent {}

class EditConfiguration extends NotificationsEvent {
  EditConfiguration({@required this.config});

  final NotificationsConfig config;

  @override
  List<Object> get props => [config];
}
