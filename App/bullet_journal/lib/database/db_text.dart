// @dart=2.9

import 'package:bullet_journal/database/db_component.dart';
import 'package:hive/hive.dart';
part 'db_text.g.dart';

@HiveType(typeId: 1)
class TextDB extends ComponentDB {
  @HiveField(6)
  String textType;
  @HiveField(7)
  String textContent;
  @HiveField(8)
  int textLine;
  @HiveField(9)
  String textFont;
  @HiveField(10)
  int textWeight;
  @HiveField(11)
  int textColor;
  @HiveField(12)
  double textSize;
  @HiveField(13)
  int backgroundColor;
  @HiveField(14)
  int textFrameId;
  TextDB(
    String textType,
    String textContent,
    int textLine,
    String textFont,
    int textColor,
    double offset_dx,
    double offset_dy,
    double size_width,
    double size_height, {
    int textBackgroundColor,
    int textFrameId,
    double opacity = 1.0,
    int textWeight,
    double textSize = 18,
  }) : super(offset_dx, offset_dy, size_width, size_height, opacity) {
    this.textType = textType;
    this.textFont = textFont;
    this.textWeight = textWeight;
    this.textColor = textColor;
    this.textSize = textSize;
    this.textContent = textContent;
    this.textLine = textLine;
    if (textFrameId != null) this.textFrameId = textFrameId;
    if (textBackgroundColor != null) this.backgroundColor = textBackgroundColor;
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
