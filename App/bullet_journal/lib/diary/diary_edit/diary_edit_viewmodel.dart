// @dart=2.9
import 'package:bullet_journal/model/emotion.dart';
import 'package:bullet_journal/model/location.dart';
import 'package:rxdart/rxdart.dart';

class DiaryEditViewModel {
  /// Variables
  final _addressController = new BehaviorSubject<String>();
  final _emotionController = new BehaviorSubject<List<Emotion>>();
  final _bottomStateController = new BehaviorSubject<List<bool>>();
  final _emotionStatus = new BehaviorSubject<Emotion>();
  MyAddress _myAddress;
  ListEmotion _emotions;
  List<bool> _bottomState;

  /// Contructor
  DiaryEditViewModel() {
    initState();
  }
  initState() {
    _setBottomState();
    _setEmotionController();
    _setAddressController();
  }

  _setEmotionController() {
    _emotions = ListEmotion();
    _emotionController.sink.add(_emotions.getEmotions);
  }

  _setBottomState() {
    _bottomState = [false, false, false, false, false];
    this._bottomStateController.sink.add(_bottomState);
  }

  _setAddressController() async {
    _myAddress = MyAddress();
    await _myAddress.initAddress();
    _addressController.sink.add(_myAddress.getFullAddress());
  }

  setBottomStateController(int index, bool state) {
    _bottomState[index] = state;
    this._bottomStateController.sink.add(_bottomState);
  }

  setEmotionStatus(Emotion emotion) => this._emotionStatus.sink.add(emotion);

  /// Get stream
  Stream get getAddressStream => this._addressController.stream;
  Stream get getEmotionStream => this._emotionController.stream;
  Stream get getBottomStateStream => this._bottomStateController.stream;
  Stream get getEmotionStatusStream => this._emotionStatus.stream;
  Sink get getEmotionStatusSink => this._emotionStatus.sink;
}
