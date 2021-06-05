// @dart=2.9
import 'package:hive/hive.dart';
part 'db_diary.g.dart';

@HiveType(typeId: 5)
class DiaryDB {
  @HiveField(0)
  int diaryId;
  @HiveField(1)
  String diaryTitle;
  @HiveField(2)
  String diaryContent;
  @HiveField(3)
  String diaryImage;
  @HiveField(4)
  DateTime diaryTime;

  /// 1. private
  /// 2. public
  @HiveField(5)
  int securityMode;
  @HiveField(6)
  int diaryBox;
  DiaryDB(DateTime diaryTime,
      {int diaryId = -1,
      String diaryTitle = '',
      String diaryContent = '',
      String diaryImage = '',
      int securityMode = 1,
      int diaryBox = -1}) {
    this.diaryId = diaryId;
    this.diaryTitle = diaryTitle;
    this.diaryContent = diaryContent;
    this.diaryTime = diaryTime;
    this.diaryImage = diaryImage;
    this.securityMode = securityMode;
    this.diaryBox = diaryBox; //bai hoc xuong mau nho gan bien day du nha ba nọi
  }
}
