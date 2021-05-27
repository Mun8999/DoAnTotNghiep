// @dart=2.9

import 'package:bullet_journal/database/db_component.dart';
import 'package:hive/hive.dart';
part 'db_text.g.dart';

@HiveType(typeId: 1)
class TextDB extends ComponentDB {
  @HiveField(5)
  String textType;
  @HiveField(6)
  String textContent;
  @HiveField(7)
  int textLine;
  @HiveField(8)
  String textFont;
  @HiveField(9)
  String textWeight;
  @HiveField(10)
  String textColor;
  @HiveField(11)
  int textSize;
  @HiveField(12)
  String backgroundColor;

  TextDB(
      String textType,
      String textContent,
      int textLine,
      String textFont,
      String textWeight,
      String textColor,
      int textSize,
      String backgroundColor,
      double offset_dx,
      double offset_dy,
      double size_width,
      double size_height,
      double opacity)
      : super(offset_dx, offset_dy, size_width, size_height, opacity) {
    this.textType = textType;
    this.textFont = textFont;
    this.textWeight = textWeight;
    this.textColor = textColor;
    this.textSize = textSize;
    this.backgroundColor = backgroundColor;
    this.textContent = textContent;
    this.textLine = textLine;
  }
  // TextDB(
  // String textType,
  // String textContent,
  // int textLine,
  // String textFont,
  // String textWeight,
  // String textColor,
  // int textSize,
  // String backgroundColor,
  // ) {
  // this.textType = textType;
  // this.textFont = textFont;
  // this.textWeight = textWeight;
  // this.textColor = textColor;
  // this.textSize = textSize;
  // this.backgroundColor = backgroundColor;
  // this.textContent = textContent;
  // this.textLine = textLine;
  // }
}
