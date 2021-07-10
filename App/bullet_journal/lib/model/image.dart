// @dart=2.9
import 'dart:io';
import 'dart:ui';

import 'package:bullet_journal/model/component.dart';
import 'package:flutter/cupertino.dart';

class MyImage extends Component {
  int _imageId;
  File _imageFile;
  setImageId(int imageId) => this._imageId = imageId;
  setImageFile(File imageFile) => this._imageFile = imageFile;
  MyImage(File imageFile, Offset offset, Size size,
      {int imageId,
      GlobalKey globalKey,
      double scale,
      double rotetate,
      double opacity,
      BlendMode blendMode})
      : super(offset, size,
            globalKey: globalKey,
            scale: scale,
            rotetate: rotetate,
            opacity: opacity,
            blendMode: blendMode) {
    this._imageId = imageId;
    this._imageFile = imageFile;
  }
  String toString() {
    return '>>Id: ' +
        this._imageId.toString() +
        '\nFile: ' +
        this._imageFile.toString() +
        '\nOffset: ' +
        getOffset.toString() +
        '\nState: ' +
        getState.toString();
  }

  int get getImageId => this._imageId;
  File get getImageFile => this._imageFile;
}
