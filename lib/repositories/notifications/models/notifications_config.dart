import 'package:flutter/foundation.dart';

class NotificationsConfig {
  NotificationsConfig({
    @required this.id,
    @required this.enabled,
  });

  final int id;
  final bool enabled;

  NotificationsConfig.initial()
      : this(
          id: 1,
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
