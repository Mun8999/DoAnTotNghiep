// @dart=2.9
import 'dart:ui';

import 'package:bullet_journal/model/component.dart';

class MyImage extends Component {
  int _imageId;
  String _imagePath;
  MyImage(int imageId, String imagePath, Offset offset) : super(offset) {
    this._imageId = imageId;
    this._imagePath = imagePath;
  }
  int get getImageId => this._imageId;
  String get getImagePath => this._imagePath;
  Offset get getImageOffset => this.getOffset;
  double get getImageOpacity => this.getOpacity;
}
