// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'db_emotion.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmotionDBAdapter extends TypeAdapter<EmotionDB> {
  @override
  final int typeId = 3;

  @override
  EmotionDB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmotionDB(
      fields[6] as String,
      fields[7] as String,
      fields[8] as String,
      fields[0] as double,
      fields[1] as double,
      fields[2] as double,
      fields[3] as double,
      fields[4] as double,
      state: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, EmotionDB obj) {
    writer
      ..writeByte(9)
      ..writeByte(6)
      ..write(obj.emotionId)
      ..writeByte(7)
      ..write(obj.emotionName)
      ..writeByte(8)
      ..write(obj.emotionImage)
      ..writeByte(0)
      ..write(obj.offset_dx)
      ..writeByte(1)
      ..write(obj.offset_dy)
      ..writeByte(2)
      ..write(obj.size_width)
      ..writeByte(3)
      ..write(obj.size_height)
      ..writeByte(4)
      ..write(obj.opacity)
      ..writeByte(5)
      ..write(obj.state);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmotionDBAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
