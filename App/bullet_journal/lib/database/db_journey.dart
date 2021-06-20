// @dart=2.9
import 'package:hive/hive.dart';
part 'db_journey.g.dart';

@HiveType(typeId: 9)
class JourneyDB extends HiveObject {
  @HiveField(0)
  int journeyId;
  @HiveField(1)
  String journeyTitle;
  @HiveField(2)
  int boxId;
  @HiveField(3)
  DateTime journeyTime;
  @HiveField(4)
  String jouneyImage;
  JourneyDB(String journeyTitle,
      {int journeyId, int boxId, DateTime journeyTime, String jouneyImage}) {
    this.journeyId = journeyId;
    this.journeyTitle = journeyTitle;
    this.boxId = boxId;
    this.journeyTime = journeyTime;
    this.jouneyImage = jouneyImage;
  }
}
