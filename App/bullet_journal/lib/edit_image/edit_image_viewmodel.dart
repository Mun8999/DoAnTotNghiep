import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class EditImageViewModel {
  final _sliderController = BehaviorSubject<double>();
  final _filterImageController = BehaviorSubject<BlendMode>();
  Stream get sliderStream => _sliderController.stream;
  Sink get sliderSink => _sliderController.sink;
  Stream get filterImageStream => _filterImageController.stream;
  Sink get filterImageSink => _filterImageController.sink;
  changeValueOfSliderEvent(double value) {
    sliderSink.add(value);
  }

  changeFilterEvent(BlendMode blendMode) {
    filterImageSink.add(blendMode);
  }
}
