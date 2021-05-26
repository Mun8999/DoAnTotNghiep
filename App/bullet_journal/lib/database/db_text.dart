// @dart=2.9
import 'package:flutter/material.dart';

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
      {@required String textType,
      @required String textContent,
      @required int textLine,
      @required String textFont,
      @required String textWeight,
      @required String textColor,
      @required int textSize,
      @required String backgroundColor,
      @required double offset_dx,
      @required double offset_dy,
      @required double size_width,
      @required double size_height,
      @required double opacity})
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
}
