// @dart=2.9
import 'dart:ui';

class Component {
  Offset _offset;
  double _opacity;
  Component(Offset offset, {double opacity = 1}) {
    this._offset = offset;
    this._opacity = opacity;
  }
  Offset get getOffset => this._offset;
  double get getOpacity => this._opacity;
}
