// @dart=2.9
import 'package:hive/hive.dart';
part 'db_journalitem.g.dart';

@HiveType(typeId: 10)
class JournalItemDB extends HiveObject {
  @HiveField(0)
  String journalItemId;
  @HiveField(1)
  DateTime date;
  @HiveField(2)
  String textBoxId;
  @HiveField(3)
  String assetBoxId;
  JournalItemDB(String journalItemId, DateTime date, String textBoxId,
      String assetBoxId) {
    this.journalItemId = journalItemId;
    this.date = date;
    this.textBoxId = textBoxId;
    this.assetBoxId = assetBoxId;
  }
}
