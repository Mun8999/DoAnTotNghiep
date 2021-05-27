// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'db_text.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TextDBAdapter extends TypeAdapter<TextDB> {
  @override
  final int typeId = 1;

  @override
  TextDB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TextDB(
      fields[5] as String,
      fields[6] as String,
      fields[7] as int,
      fields[8] as String,
      fields[9] as String,
      fields[10] as String,
      fields[11] as int,
      fields[12] as String,
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
      ..writeByte(13)
      ..writeByte(5)
      ..write(obj.textType)
      ..writeByte(6)
      ..write(obj.textContent)
      ..writeByte(7)
      ..write(obj.textLine)
      ..writeByte(8)
      ..write(obj.textFont)
      ..writeByte(9)
      ..write(obj.textWeight)
      ..writeByte(10)
      ..write(obj.textColor)
      ..writeByte(11)
      ..write(obj.textSize)
      ..writeByte(12)
      ..write(obj.backgroundColor)
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
