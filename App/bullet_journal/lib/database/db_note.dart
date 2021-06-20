// @dart=2.9
import 'package:hive/hive.dart';
part 'db_note.g.dart';

@HiveType(typeId: 7)
class NoteDB extends HiveObject {
  @HiveField(0)
  int noteId;
  @HiveField(1)
  String noteTitle;
  @HiveField(2)
  String noteContent;
  @HiveField(3)
  int boxId;
  @HiveField(4)
  DateTime noteTime;
  NoteDB(String noteTitle, String noteContent,
      {int noteId, int boxId, DateTime noteTime}) {
    this.noteId = noteId;
    this.noteTitle = noteTitle;
    this.noteContent = noteContent;
    this.boxId = boxId;
    this.noteTime = noteTime;
  }
}
