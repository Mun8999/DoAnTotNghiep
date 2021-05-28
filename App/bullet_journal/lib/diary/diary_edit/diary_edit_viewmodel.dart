// @dart=2.9
import 'package:bullet_journal/database/db_emotion.dart';
import 'package:bullet_journal/database/db_image.dart';
import 'package:bullet_journal/database/db_text.dart';
import 'package:bullet_journal/model/emotion.dart';
import 'package:bullet_journal/model/image.dart';
import 'package:bullet_journal/model/location.dart';
import 'package:bullet_journal/model/text.dart';
import 'package:hive/hive.dart';
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

  Future<void> saveImage(List<MyImage> images) async {
    if (images.length == 0) return;
    var imageBox = await Hive.openBox<ImageDB>('images');
    await imageBox.clear();
    ImageDB imageDB;
    images.forEach((image) async {
      imageDB = ImageDB(
          image.getImageFile.path,
          image.getOffset.dx,
          image.getOffset.dy,
          image.getSize.width,
          image.getSize.height,
          image.getOpacity);
      // imageBox.put(image.getImageId, imageDB);
      imageBox.add(imageDB);
    });
    imageBox.values.toList().forEach((element) {
      print('>path ' +
          element.imagePath +
          '\n>offset ' +
          element.offset_dx.toString() +
          ', ' +
          element.offset_dy.toString());
    });
    await imageBox.close();
  }

  Future<void> saveText(List<MyText> editTexts) async {
    if (editTexts.length == 0) return;
    // var textBox = await Hive.openBox<TextDB>('texts');
    var textBox = await Hive.openBox<TextDB>('texts');
    await textBox.clear();
    TextDB textDB;
    editTexts.forEach((text) async {
      textDB = TextDB(
          '',
          text.getTextContent,
          2,
          'textFont',
          'textWeight',
          'textColor',
          1,
          'backgroundColor',
          text.getOffset.dx,
          text.getOffset.dy,
          0,
          0,
          0);
      // textBox.put(text.getTextId, textDB);
      textBox.add(textDB);
    });
    textBox.values.toList().forEach((element) {
      print('>content ' + element.textContent);
    });
    await textBox.close();
  }

  Future<void> saveEmotion(Emotion emotion) async {
    // if (emotion.getEmotionComponent.getState == 3) return;
    // print('121>12321312312321');
    var emotionBox = await Hive.openBox<EmotionDB>('emotion');
    emotionBox.clear();
    EmotionDB emotionDB = EmotionDB(
        emotion.getEmotionId,
        emotion.getEmotionName,
        emotion.getEmotionImage,
        emotion.getEmotionComponent.getOffset.dx,
        emotion.getEmotionComponent.getOffset.dy,
        emotion.getEmotionComponent.getSize.width,
        emotion.getEmotionComponent.getSize.height,
        emotion.getEmotionComponent.getOpacity,
        state: emotion.getEmotionComponent.getState);
    await emotionBox.add(emotionDB);
    // print('133> emotion: ' + emotion.getEmotionImage);
    await emotionBox.close();
  }
}
