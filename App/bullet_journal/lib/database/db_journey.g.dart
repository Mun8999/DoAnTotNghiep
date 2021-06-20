// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'db_journey.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JourneyDBAdapter extends TypeAdapter<JourneyDB> {
  @override
  final int typeId = 9;

  @override
  JourneyDB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return JourneyDB(
      fields[1] as String,
      journeyId: fields[0] as int,
      boxId: fields[2] as int,
      journeyTime: fields[3] as DateTime,
      jouneyImage: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, JourneyDB obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.journeyId)
      ..writeByte(1)
      ..write(obj.journeyTitle)
      ..writeByte(2)
      ..write(obj.boxId)
      ..writeByte(3)
      ..write(obj.journeyTime)
      ..writeByte(4)
      ..write(obj.jouneyImage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JourneyDBAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
