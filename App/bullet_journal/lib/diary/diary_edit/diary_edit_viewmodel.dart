// @dart=2.9
import 'package:bullet_journal/model/emotion.dart';
import 'package:bullet_journal/model/location.dart';
import 'package:rxdart/rxdart.dart';

class DiaryEditViewModel {
  final _addressController = new BehaviorSubject<String>();
  final _emotionController = new BehaviorSubject<Emotion>();
  MyAddress _myAddress;
  ListEmotion _emotions;
  initState() async {
    _emotions = ListEmotion();
    _emotions.getEmotions.forEach((element) {
      print(element.toString());
    });
    _myAddress = MyAddress();
    await _myAddress.initAddress();
    _addressController.sink.add(_myAddress.getFullAddress());
  }

  DiaryEditViewModel() {
    initState();
  }
  Stream get getAddressStream => this._addressController;
}
