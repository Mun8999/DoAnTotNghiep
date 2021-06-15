// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'db_dailytask.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DailyTaskDBAdapter extends TypeAdapter<DailyTaskDB> {
  @override
  final int typeId = 6;

  @override
  DailyTaskDB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailyTaskDB(
      fields[1] as DateTime,
      fields[2] as DateTime,
      fields[3] as String,
      dailyTaskId: fields[0] as int,
      dailyTaskState: fields[5] as bool,
      reminder: fields[6] as bool,
    )..dailyTaskDep = fields[4] as String;
  }

  @override
  void write(BinaryWriter writer, DailyTaskDB obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.dailyTaskId)
      ..writeByte(1)
      ..write(obj.dailyTaskTimeStart)
      ..writeByte(2)
      ..write(obj.dailyTaskTimeEnd)
      ..writeByte(3)
      ..write(obj.dailyTaskContent)
      ..writeByte(4)
      ..write(obj.dailyTaskDep)
      ..writeByte(5)
      ..write(obj.dailyTaskState)
      ..writeByte(6)
      ..write(obj.reminder);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyTaskDBAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
