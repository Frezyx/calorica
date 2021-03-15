import 'package:calory_calc/blocs/notifications/bloc.dart';
import 'package:calory_calc/common/services/notification/local_notifications_service/service.dart';
import 'package:calory_calc/repositories/notifications/local_notifications_repository/repository.dart';
import 'package:calory_calc/repositories/notifications/models/notifications_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc({
    @required AbstractLocalNotificationsRepository notificationsRepository,
  })  : _notificationsRepository = notificationsRepository,
        super(Uninitialized());

  final AbstractLocalNotificationsRepository _notificationsRepository;

  @override
  Stream<NotificationsState> mapEventToState(NotificationsEvent event) async* {
    if (event is Initialize) {
      yield* _mapInitializeToState(event);
    } else if (event is EditConfiguration) {
      yield* _mapEditConfigurationToState(event);
    } else {
      yield Uninitialized();
    }
  }

  Stream<NotificationsState> _mapEditConfigurationToState(
    EditConfiguration event,
  ) async* {
    yield NotificationsLoading();
  }

  Stream<NotificationsState> _mapInitializeToState(Initialize event) async* {
    yield NotificationsLoading();
    try {
      var configuration = _notificationsRepository.configuration.get();
      if (configuration == null) {
        configuration = NotificationsConfig.initial();
      }
      await _notificationsRepository.configuration.setup(configuration);
      LocalNotificationsService.instance.setupNotifications(configuration);
      yield Initialized(config: configuration);
    } on Exception catch (e) {
      yield Uninitialized();
    }
  }
}
