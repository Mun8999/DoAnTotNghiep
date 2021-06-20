// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'db_asset.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AssetDBAdapter extends TypeAdapter<AssetDB> {
  @override
  final int typeId = 8;

  @override
  AssetDB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AssetDB(
      fields[0] as String,
      fields[1] as String,
      fields[2] as int,
      fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, AssetDB obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.identifier)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.originalWidth)
      ..writeByte(3)
      ..write(obj.originalHeight);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AssetDBAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
