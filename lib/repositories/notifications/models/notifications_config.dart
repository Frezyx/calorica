import 'package:flutter/foundation.dart';

class NotificationsConfig {
  NotificationsConfig({
    @required this.id,
    @required this.enabled,
  });

  final String id;
  final bool enabled;

  NotificationsConfig.initial()
      : this(
          id: 'main_configuration',
          enabled: true,
        );

  NotificationsConfig copyWith({
    bool enabled,
  }) {
    return NotificationsConfig(
      id: this.id,
      enabled: enabled ?? this.enabled,
    );
  }
}
