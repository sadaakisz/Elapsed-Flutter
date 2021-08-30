// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_routine.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomRoutineAdapter extends TypeAdapter<CustomRoutine> {
  @override
  final int typeId = 0;

  @override
  CustomRoutine read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomRoutine(
      name: fields[0] as String,
      timerTime: fields[1] as int,
      breakTime: fields[2] as int,
      labelColor: fields[3] as String?,
      background: fields[4] as String?,
      notificationVolume: fields[5] as int?,
      vibrate: fields[6] as bool?,
      autoStart: fields[7] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, CustomRoutine obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.timerTime)
      ..writeByte(2)
      ..write(obj.breakTime)
      ..writeByte(3)
      ..write(obj.labelColor)
      ..writeByte(4)
      ..write(obj.background)
      ..writeByte(5)
      ..write(obj.notificationVolume)
      ..writeByte(6)
      ..write(obj.vibrate)
      ..writeByte(7)
      ..write(obj.autoStart);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomRoutineAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
