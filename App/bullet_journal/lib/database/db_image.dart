// @dart=2.9

import 'package:bullet_journal/database/db_component.dart';
import 'package:hive/hive.dart';
part 'db_image.g.dart';

@HiveType(typeId: 2)
class ImageDB extends ComponentDB {
  @HiveField(6)
  String imagePath;
  @HiveField(7)
  int filterId;
  @HiveField(8)
  int frameId;
  @HiveField(9)
  double frameRadius;
  @HiveField(10)
  int colorFrame;
  @HiveField(11)
  double imageScale;
  @HiveField(12)
  double imageRotetate;
  ImageDB(String imagePath, int filterId, double offset_dx, double offset_dy,
      double size_width, double size_height, double opacity,
      {int frameId,
      double frameRadius,
      int colorFrame,
      double imageScale = 1.0,
      double imageRotetate = 0.0})
      : super(offset_dx, offset_dy, size_width, size_height, opacity) {
    this.imagePath = imagePath;
    this.filterId = filterId;
    if (frameId != null) this.frameId = frameId;
    if (frameRadius != null) this.frameRadius = frameRadius;
    if (colorFrame != null) this.colorFrame = colorFrame;
    this.imageScale = imageScale;
    this.imageRotetate = imageRotetate;
  }
}
