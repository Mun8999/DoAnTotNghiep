// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'db_diary.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DiaryDBAdapter extends TypeAdapter<DiaryDB> {
  @override
  final int typeId = 5;

  @override
  DiaryDB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DiaryDB(
      fields[4] as DateTime,
      diaryId: fields[0] as int,
      diaryTitle: fields[1] as String,
      diaryContent: fields[2] as String,
      diaryImage: fields[3] as String,
      securityMode: fields[5] as int,
      diaryBox: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, DiaryDB obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.diaryId)
      ..writeByte(1)
      ..write(obj.diaryTitle)
      ..writeByte(2)
      ..write(obj.diaryContent)
      ..writeByte(3)
      ..write(obj.diaryImage)
      ..writeByte(4)
      ..write(obj.diaryTime)
      ..writeByte(5)
      ..write(obj.securityMode)
      ..writeByte(6)
      ..write(obj.diaryBox);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiaryDBAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
