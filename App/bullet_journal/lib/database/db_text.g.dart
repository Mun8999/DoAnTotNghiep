// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'db_text.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TextDBAdapter extends TypeAdapter<TextDB> {
  @override
  final int typeId = 0;

  @override
  TextDB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TextDB(
      fields[5] as int,
      fields[6] as String,
      fields[7] as TextStyle,
      fields[8] as String,
      fields[9] as int,
      fields[0] as double,
      fields[1] as double,
      fields[2] as double,
      fields[3] as double,
      fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, TextDB obj) {
    writer
      ..writeByte(10)
      ..writeByte(5)
      ..write(obj.textId)
      ..writeByte(6)
      ..write(obj.textType)
      ..writeByte(7)
      ..write(obj.textStyle)
      ..writeByte(8)
      ..write(obj.textContent)
      ..writeByte(9)
      ..write(obj.textLine)
      ..writeByte(0)
      ..write(obj.offset_dx)
      ..writeByte(1)
      ..write(obj.offset_dy)
      ..writeByte(2)
      ..write(obj.size_width)
      ..writeByte(3)
      ..write(obj.size_height)
      ..writeByte(4)
      ..write(obj.opacity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TextDBAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
