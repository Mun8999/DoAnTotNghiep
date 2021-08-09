// @dart=2.9
import 'package:bullet_journal/model/component.dart';
import 'package:bullet_journal/model/frame.dart';
import 'package:flutter/material.dart';

class MyText extends Component {
  int _textId;
  String _textType;
  TextStyle _textStyle;
  String _textContent;
  int _textLine;
  Color _textBackgroundColor;
  Frame _textFrame;
  setTextId(int textId) => this._textId = textId;
  setTextType(String textType) => this._textType = textType;
  setTextStyle(TextStyle textStyle) => this._textStyle = textStyle;
  setTextContent(String textContent) => this._textContent = textContent;
  setTextLine(int textLine) => this._textLine = textLine;
  setTextBackgroundColor(Color color) => this._textBackgroundColor = color;
  setTextFram(Frame frame) => this._textFrame = frame;
  MyText(String textType, TextStyle textStyle, String textContent,
      Offset offset, Size size,
      {int textId = -1,
      int textLine = 1,
      Frame frame,
      Color textBackgroundColor})
      : super(offset, size) {
    this._textId = textId;
    this._textType = textType;
    this._textStyle = textStyle;
    this._textContent = textContent;
    this._textBackgroundColor = textBackgroundColor;
    this._textId = textId;
    this._textLine = textLine;
    if (frame != null) this._textFrame = frame;
  }
  int get getTextId => this._textId;
  String get getTextType => this._textType;
  TextStyle get getTextStyle => this._textStyle;
  String get getTextContent => this._textContent;
  int get getTextLine => this._textLine;
  Color get getTextBackgroundColor => this._textBackgroundColor;
  Frame get getTextFrame => this._textFrame;
}
