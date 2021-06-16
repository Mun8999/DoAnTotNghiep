// @dart=2.9
import 'dart:math';
import 'package:rxdart/subjects.dart';

class NoteViewNewsFeedViewModel {
  List<double> _random = [];
  final _randomController = BehaviorSubject<List<double>>();
  NoteViewNewsFeedViewModel() {
    //_init();
  }
  _init() async {
    Random rd = Random();
    for (int i = 0; i < 7; i++) {
      i = rd.nextInt(4) + 2;
      _random.add(i.toDouble());
    }
    await _randomController.sink.add(_random);
  }

  Stream get getRadomController => this._randomController.stream;
}
