// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'db_component.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ComponentDBAdapter extends TypeAdapter<ComponentDB> {
  @override
  final int typeId = 2;

  @override
  ComponentDB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ComponentDB(
      fields[0] as double,
      fields[1] as double,
      fields[2] as double,
      fields[3] as double,
      fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, ComponentDB obj) {
    writer
      ..writeByte(5)
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
      other is ComponentDBAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
