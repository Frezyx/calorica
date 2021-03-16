import 'package:calory_calc/repositories/notifications/repository.dart';
import 'package:hive/hive.dart';

class NotificationsConfigAdapter extends TypeAdapter<NotificationsConfig> {
  NotificationsConfigAdapter(this.typeId);

  @override
  final int typeId;

  @override
  NotificationsConfig read(BinaryReader reader) {
    return NotificationsConfig(
      id: reader.readString(),
      enabled: reader.readBool() ?? true,
    );
  }

  @override
  void write(BinaryWriter writer, NotificationsConfig obj) {
    writer
      ..writeString(obj.id)
      ..writeBool(obj.enabled ?? true);
  }
}
