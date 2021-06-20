// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'db_note.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteDBAdapter extends TypeAdapter<NoteDB> {
  @override
  final int typeId = 7;

  @override
  NoteDB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteDB(
      fields[0] as int,
      fields[1] as String,
      fields[2] as String,
      fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, NoteDB obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.noteId)
      ..writeByte(1)
      ..write(obj.noteTitle)
      ..writeByte(2)
      ..write(obj.noteContent)
      ..writeByte(3)
      ..write(obj.boxId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteDBAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
