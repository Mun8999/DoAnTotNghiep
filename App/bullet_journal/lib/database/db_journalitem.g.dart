// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'db_journalitem.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JournalItemDBAdapter extends TypeAdapter<JournalItemDB> {
  @override
  final int typeId = 10;

  @override
  JournalItemDB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return JournalItemDB(
      fields[0] as String,
      fields[1] as DateTime,
      fields[2] as String,
      fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, JournalItemDB obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.journalItemId)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.textBoxId)
      ..writeByte(3)
      ..write(obj.assetBoxId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JournalItemDBAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
