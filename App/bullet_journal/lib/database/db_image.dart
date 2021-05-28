// @dart=2.9

import 'package:bullet_journal/database/db_component.dart';
import 'package:hive/hive.dart';
part 'db_image.g.dart';

@HiveType(typeId: 2)
class ImageDB extends ComponentDB {
  @HiveField(6)
  String imagePath;
  ImageDB(String imagePath, double offset_dx, double offset_dy,
      double size_width, double size_height, double opacity)
      : super(offset_dx, offset_dy, size_width, size_height, opacity) {
    this.imagePath = imagePath;
  }
}
