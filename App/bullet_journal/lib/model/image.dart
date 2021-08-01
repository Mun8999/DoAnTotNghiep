// @dart=2.9
import 'dart:io';
import 'dart:ui';

import 'package:bullet_journal/model/component.dart';
import 'package:bullet_journal/model/filter.dart';
import 'package:bullet_journal/model/frame.dart';
import 'package:flutter/cupertino.dart';

class MyImage extends Component {
  int _imageId;
  File _imageFile;
  Filter _imageFilter;
  Frame _imageFrame;
  double _radius;
  setImageId(int imageId) => this._imageId = imageId;
  setImageFile(File imageFile) => this._imageFile = imageFile;
  setImageFilter(Filter imageFilter) => this._imageFilter = imageFilter;
  setImageRadius(double radius) => this._radius = radius;
  setImageFrame(Frame frame) => this._imageFrame = frame;
  MyImage(File imageFile, Offset offset, Size size,
      {int imageId,
      Filter imageFilter,
      GlobalKey globalKey,
      double scale,
      double rotetate,
      double opacity = 1.0,
      double radius = 0.0,
      BlendMode blendMode,
      Frame imageFrame})
      : super(offset, size,
            globalKey: globalKey,
            scale: scale,
            rotetate: rotetate,
            opacity: opacity,
            blendMode: blendMode) {
    this._imageId = imageId;
    this._imageFile = imageFile;
    this._radius = radius;
    if (imageFilter != null) {
      this._imageFilter = imageFilter;
    }
    if (imageFrame != null) {
      this._imageFrame = imageFrame;
    }
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
  Filter get getImageFilter => this._imageFilter;
  double get getImageRadius => this._radius;
  Frame get getImageFrame => this._imageFrame;
}
