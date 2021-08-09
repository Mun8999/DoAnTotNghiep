// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'db_image.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImageDBAdapter extends TypeAdapter<ImageDB> {
  @override
  final int typeId = 2;

  @override
  ImageDB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ImageDB(
      fields[6] as String,
      fields[7] as int,
      fields[0] as double,
      fields[1] as double,
      fields[2] as double,
      fields[3] as double,
      fields[4] as double,
      frameId: fields[8] as int,
      frameRadius: fields[9] as double,
      colorFrame: fields[10] as int,
      imageScale: fields[11] as double,
      imageRotetate: fields[12] as double,
    )..state = fields[5] as int;
  }

  @override
  void write(BinaryWriter writer, ImageDB obj) {
    writer
      ..writeByte(13)
      ..writeByte(6)
      ..write(obj.imagePath)
      ..writeByte(7)
      ..write(obj.filterId)
      ..writeByte(8)
      ..write(obj.frameId)
      ..writeByte(9)
      ..write(obj.frameRadius)
      ..writeByte(10)
      ..write(obj.colorFrame)
      ..writeByte(11)
      ..write(obj.imageScale)
      ..writeByte(12)
      ..write(obj.imageRotetate)
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
      other is ImageDBAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
