// @dart=2.9
import 'package:bullet_journal/model/emotion.dart';
import 'package:bullet_journal/model/location.dart';
import 'package:rxdart/rxdart.dart';

class DiaryEditViewModel {
  /// Variables
  final _addressController = new BehaviorSubject<String>();
  final _emotionController = new BehaviorSubject<List<Emotion>>();
  final _bottomStateController = new BehaviorSubject<int>();
  final _emotionStatus = new BehaviorSubject<Emotion>();
  MyAddress _myAddress;
  ListEmotion _emotions;

  /// Contructor
  DiaryEditViewModel() {
    initState();
  }
  initState() {
    _setEmotionController();
    _setAddressController();
  }

  _setEmotionController() {
    _emotions = ListEmotion();
    // _emotions.getEmotions.forEach((element) {
    //   print(element.toString());
    // });
    _emotionController.sink.add(_emotions.getEmotions);
  }

  _setAddressController() async {
    _myAddress = MyAddress();
    await _myAddress.initAddress();
    _addressController.sink.add(_myAddress.getFullAddress());
  }

  setBottomStateController(int state) =>
      this._bottomStateController.sink.add(state);
  setEmotionStatus(Emotion emotion) => this._emotionStatus.sink.add(emotion);

  /// Get stream
  Stream get getAddressStream => this._addressController.stream;
  Stream get getEmotionStream => this._emotionController.stream;
  Stream get getBottomStateStream => this._bottomStateController.stream;
  Stream get getEmotionStatusStream => this._emotionStatus.stream;
  Sink get getEmotionStatusSink => this._emotionStatus.sink;
}
