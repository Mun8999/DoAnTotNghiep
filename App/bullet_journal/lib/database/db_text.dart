// @dart=2.9
import 'dart:ui';

import 'package:bullet_journal/database/db_component.dart';
import 'package:hive/hive.dart';
part 'db_text.g.dart';

@HiveType(typeId: 0)
class TextDB extends ComponentDB {
  @HiveField(5)
  int textId;
  @HiveField(6)
  String textType;
  @HiveField(7)
  TextStyle textStyle;
  @HiveField(8)
  String textContent;
  @HiveField(9)
  int textLine;

  TextDB(
      int textId,
      String textType,
      TextStyle textStyle,
      String textContent,
      int textLine,
      double offset_dx,
      double offset_dy,
      double size_width,
      double size_height,
      double opacity)
      : super(offset_dx, offset_dy, size_width, size_height, opacity) {
    this.textId = textId;
    this.textType = textType;
    this.textStyle = textStyle;
    this.textContent = textContent;
    this.textLine = textLine;
  }
}
