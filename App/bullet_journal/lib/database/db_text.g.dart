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
      fields[6] as String,
      fields[7] as String,
      fields[8] as int,
      fields[9] as String,
      fields[11] as int,
      fields[0] as double,
      fields[1] as double,
      fields[2] as double,
      fields[3] as double,
      textFrameId: fields[14] as int,
      opacity: fields[4] as double,
      textWeight: fields[10] as int,
      textSize: fields[12] as double,
    )
      ..backgroundColor = fields[13] as int
      ..state = fields[5] as int;
  }

  @override
  void write(BinaryWriter writer, TextDB obj) {
    writer
      ..writeByte(15)
      ..writeByte(6)
      ..write(obj.textType)
      ..writeByte(7)
      ..write(obj.textContent)
      ..writeByte(8)
      ..write(obj.textLine)
      ..writeByte(9)
      ..write(obj.textFont)
      ..writeByte(10)
      ..write(obj.textWeight)
      ..writeByte(11)
      ..write(obj.textColor)
      ..writeByte(12)
      ..write(obj.textSize)
      ..writeByte(13)
      ..write(obj.backgroundColor)
      ..writeByte(14)
      ..write(obj.textFrameId)
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
      other is TextDBAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
