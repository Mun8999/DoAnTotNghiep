// @dart=2.9
import 'package:bullet_journal/database/db_component.dart';
import 'package:hive/hive.dart';
part 'db_emotion.g.dart';

@HiveType(typeId: 3)
class EmotionDB extends ComponentDB {
  @HiveField(5)
  String emotionId;
  @HiveField(6)
  String emotionName;
  @HiveField(7)
  String emotionImage;
  EmotionDB(
      String emotionId,
      String emotionName,
      String emotionImage,
      double offset_dx,
      double offset_dy,
      double size_width,
      double size_height,
      double opacity)
      : super(offset_dx, offset_dy, size_width, size_height, opacity) {
    this.emotionId = emotionId;
    this.emotionName = emotionName;
    this.emotionImage = emotionImage;
  }
}
