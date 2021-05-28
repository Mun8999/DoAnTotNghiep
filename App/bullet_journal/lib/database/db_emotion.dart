// @dart=2.9
import 'package:bullet_journal/database/db_component.dart';
import 'package:hive/hive.dart';
part 'db_emotion.g.dart';

@HiveType(typeId: 3)
class EmotionDB extends ComponentDB {
  @HiveField(6)
  String emotionId;
  @HiveField(7)
  String emotionName;
  @HiveField(8)
  String emotionImage;
  EmotionDB(
      String emotionId,
      String emotionName,
      String emotionImage,
      double offset_dx,
      double offset_dy,
      double size_width,
      double size_height,
      double opacity,
      {int state})
      : super(offset_dx, offset_dy, size_width, size_height, opacity,
            state: state) {
    this.emotionId = emotionId;
    this.emotionName = emotionName;
    this.emotionImage = emotionImage;
  }
}
