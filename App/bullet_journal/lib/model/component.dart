// @dart=2.9
import 'dart:ui';

import 'package:flutter/cupertino.dart';

class Component {
  GlobalKey _globalKey;
  Offset _offset;
  Size _size;
  double _scale;
  double _rotetate;

  double _opacity;
  BlendMode _blendMode;

  int _state;
  bool _isEdited;
  setGlobalKey(GlobalKey globalKey) => this._globalKey = globalKey;
  setScale(double scale) => this._scale = scale;
  setRotetate(double rotetate) => this._rotetate = rotetate;
  setBlendMode(BlendMode blendMode) => this._blendMode = blendMode;
  setOffset(Offset offset) => this._offset = offset;
  setSize(Size size) => this._size = _size;
  setOpacity(double opacity) => this._opacity = opacity;
  setState(int state) => this._state = state;
  setEditState(bool editState) => this._isEdited = editState;

  /// innitstate = 1
  /// updatestate = 2
  /// deletestate = 3
  Component(Offset offset, Size size,
      {GlobalKey globalKey,
      int state = 1,
      bool editState = false,
      double opacity = 1.0,
      double scale = 1.0,
      double rotetate = 0.0,
      BlendMode blendMode}) {
    if (globalKey != null) this._globalKey = globalKey;
    this._offset = offset;
    this._size = size;
    this._opacity = opacity;
    this._state = state;
    this._isEdited = editState;
    this._scale = scale;
    this._rotetate = rotetate;
    if (blendMode != null) this._blendMode = blendMode;
  }
  GlobalKey get getGlobalKey => this._globalKey;
  double get getScale => this._scale;
  double get getRotetate => this._rotetate;
  BlendMode get getBlendMode => this._blendMode;
  Offset get getOffset => this._offset;
  Size get getSize => this._size;
  double get getOpacity => this._opacity;
  int get getState => this._state;
  bool get getEditState => this._isEdited;
}
