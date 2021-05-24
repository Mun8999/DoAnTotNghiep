// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'db_image_demo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImageDataAdapter extends TypeAdapter<ImageData> {
  @override
  final int typeId = 0;

  @override
  ImageData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ImageData()
      ..imageId = fields[0] as int
      ..imageFile = fields[1] as String;
  }

  @override
  void write(BinaryWriter writer, ImageData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.imageId)
      ..writeByte(1)
      ..write(obj.imageFile);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
