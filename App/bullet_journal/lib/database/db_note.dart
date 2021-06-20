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
  NoteDB(int noteId, String noteTitle, String noteContent, int boxId) {
    this.noteId = noteId;
    this.noteTitle = noteTitle;
    this.noteContent = noteContent;
    this.boxId = boxId;
  }
}
