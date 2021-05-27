// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'db_address.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddressDBAdapter extends TypeAdapter<AddressDB> {
  @override
  final int typeId = 4;

  @override
  AddressDB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddressDB(
      fields[5] as String,
      fields[0] as double,
      fields[1] as double,
      fields[2] as double,
      fields[3] as double,
      fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, AddressDB obj) {
    writer
      ..writeByte(6)
      ..writeByte(5)
      ..write(obj.address)
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
      other is AddressDBAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
