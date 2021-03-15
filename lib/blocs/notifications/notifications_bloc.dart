import 'package:calory_calc/blocs/notifications/bloc.dart';
import 'package:calory_calc/repositories/notifications/local_notifications_repository/repository.dart';
import 'package:calory_calc/repositories/notifications/models/notifications_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc(
      {@required AbstractLocalNotificationsRepository notificationsRepository})
      : _notificationsRepository = notificationsRepository,
        super(Uninitialized());

  final AbstractLocalNotificationsRepository _notificationsRepository;

  @override
  Stream<NotificationsState> mapEventToState(NotificationsEvent event) async* {
    if (event is Initialize) {
      yield* _mapInitializeToState(event);
    }
  }

  Stream<NotificationsState> _mapInitializeToState(Initialize event) async* {
    try {
      final configuration = _notificationsRepository.configuration.get();
      if (configuration == null) {
        final createdConfiguration = NotificationsConfig.initial();
        await _notificationsRepository.configuration
            .setup(createdConfiguration);
        yield Initialized(config: createdConfiguration);
      } else {
        yield Initialized(config: configuration);
      }
    } on Exception catch (e) {
      yield Uninitialized();
    }
  }
}
