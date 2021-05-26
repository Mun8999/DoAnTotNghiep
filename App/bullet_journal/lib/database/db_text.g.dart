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
      textType: fields[5] as String,
      textContent: fields[6] as String,
      textLine: fields[7] as int,
      textFont: fields[8] as String,
      textWeight: fields[9] as String,
      textColor: fields[10] as String,
      textSize: fields[11] as int,
      backgroundColor: fields[12] as String,
      offset_dx: fields[0] as double,
      offset_dy: fields[1] as double,
      size_width: fields[2] as double,
      size_height: fields[3] as double,
      opacity: fields[4] as double,
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
