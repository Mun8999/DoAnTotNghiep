// @dart=2.9
import 'package:bullet_journal/model/image.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class DiaryEditViewModel {
  final _imagesController = new BehaviorSubject<List<MyImage>>();
  final _imageController = new BehaviorSubject<MyImage>();
  // List<MyImage> _images = [];
  DiaryEditViewModel() {
    // _imagesController.sink.add([]);
  }
  // addImageData(MyImage image) {
  //   print('>Stream' + image.toString());
  //   // _images = _imagesController.stream.value;
  //   _images.add(image);
  //   _imagesController.sink.add(_images);
  // }
  addImageData(MyImage image) {
    _imageController.sink.add(image);
  }

  Stream get getImageStream => _imageController.stream;
  Stream get getImagesStream => _imagesController.stream;
}
