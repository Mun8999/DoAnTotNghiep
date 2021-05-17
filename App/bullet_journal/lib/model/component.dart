// @dart=2.9
import 'dart:ui';

class Component {
  Offset _offset;
  Size _size;
  double _opacity;
  int _state;
  bool _isEdited;
  bool _onLongPress;
  setOffset(Offset offset) => this._offset = offset;
  setSize(Size size) => this._size = _size;
  setOpacity(double opacity) => this._opacity = opacity;
  setState(int state) => this._state = state;
  setEditState(bool editState) => this._isEdited = editState;
  setResizeState(bool resizeState) => this._onLongPress = resizeState;

  /// innitstate = 1
  /// updatestate = 2
  /// deletestate = 3
  Component(Offset offset, Size size,
      {int state = 1,
      bool editState = false,
      double opacity = 1,
      bool resizeState = false}) {
    this._offset = offset;
    this._size = size;
    this._opacity = opacity;
    this._state = state;
    this._isEdited = editState;
    this._onLongPress = resizeState;
  }
  Offset get getOffset => this._offset;
  Size get getSize => this._size;
  double get getOpacity => this._opacity;
  int get getState => this._state;
  bool get getEditState => this._isEdited;
  bool get getResizeState => this._onLongPress;
}
