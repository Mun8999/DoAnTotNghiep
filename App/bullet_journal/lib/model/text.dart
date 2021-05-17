// @dart=2.9
import 'package:bullet_journal/model/component.dart';
import 'package:flutter/cupertino.dart';

class MyText extends Component {
  int _textId;
  String _textType;
  TextStyle _textStyle;
  String _textContent;
  int _textLine;
  setTextId(int textId) => this._textId = textId;
  setTextType(String textType) => this._textType = textType;
  setTextStyle(TextStyle textStyle) => this._textStyle = textStyle;
  setTextContent(String textContent) => this._textContent = textContent;
  setTextLine(int textLine) => this._textLine = textLine;
  MyText(String textType, TextStyle textStyle, String textContent,
      Offset offset, Size size,
      {int textId = -1, int textLine = 1})
      : super(offset, size) {
    this._textId = textId;
    this._textType = textType;
    this._textStyle = textStyle;
    this._textContent = textContent;
    this._textId = textId;
    this._textLine = textLine;
  }
  int get getTextId => this._textId;
  String get getTextType => this._textType;
  TextStyle get getTextStyle => this._textStyle;
  String get getTextContent => this._textContent;
  int get getTextLine => this._textLine;
}
