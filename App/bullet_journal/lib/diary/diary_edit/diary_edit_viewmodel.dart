// @dart=2.9
import 'package:bullet_journal/database/db_diary.dart';
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

  dispose() {
    _addressController.close();
    _emotionController.close();
    _bottomStateController.close();
    _emotionStatus.close();
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
  Future<void> saveDiary(DiaryDB diaryBD, List<MyImage> images,
      List<MyText> editTexts, Emotion emotion, int state) async {
    ///kiem tra trang thai tao moi hoac luu lai
    diaryBD.diaryTime = DateTime.now();
    var diaryBox = Hive.box<DiaryDB>('diaries');
    int index = diaryBox.length;

    if (state == 1) {
      if (index == 0) {
        diaryBD.diaryId = 0;
        diaryBD.diaryBox = 0;
      } else {
        diaryBD.diaryId = index;
        int diaryBoxId = diaryBox.getAt(index - 1).diaryBox + 1;
        diaryBD.diaryBox = diaryBoxId;
      }
      await diaryBox.add(diaryBD);
    }
    var textBox =
        await Hive.openBox<TextDB>('texts' + diaryBD.diaryBox.toString());
    await textBox.clear();
    var imageBox =
        await Hive.openBox<ImageDB>('images' + diaryBD.diaryBox.toString());
    await imageBox.clear();

    await _saveImage(images, diaryBD, imageBox);
    await _saveText(editTexts, diaryBD, textBox);
    await _saveEmotion(emotion, diaryBD);
    await diaryBox.putAt(diaryBD.diaryId, diaryBD);
  }

  Future<void> _saveImage(
      List<MyImage> images, DiaryDB diaryBD, Box<ImageDB> imageBox) async {
    if (images.length == 0) {
      diaryBD.diaryImage = '';
      return;
    }
    ImageDB imageDB;
    images.forEach((image) async {
      imageDB = ImageDB(
          image.getImageFile.path,
          image.getImageFilter.getId,
          image.getOffset.dx,
          image.getOffset.dy,
          image.getSize.width,
          image.getSize.height,
          image.getOpacity,
          frameId: image.getImageFrame.getFrameId,
          frameRadius: image.getImageRadius,
          imageScale: image.getScale,
          imageRotetate: image.getRotetate);
      if (image.getImageFrameColor != null)
        imageDB.colorFrame = image.getImageFrameColor.value;
      // imageBox.put(image.getImageId, imageDB);
      imageBox.add(imageDB);
    });
    diaryBD.diaryImage = imageBox.getAt(0).imagePath;
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

  Future<void> _saveText(
      List<MyText> editTexts, DiaryDB diaryBD, Box<TextDB> textBox) async {
    if (editTexts.length == 0) {
      diaryBD.diaryContent = '';
      return;
    }
    // var textBox = await Hive.openBox<TextDB>('texts');
    // var textBox =
    //     await Hive.openBox<TextDB>('texts' + diaryBD.diaryId.toString());
    // await textBox.clear();

    TextDB textDB;
    editTexts.forEach((text) async {
      textDB = TextDB(
        '',
        text.getTextContent,
        2,
        text.getTextStyle.fontFamily,
        text.getTextStyle.color.value,
        text.getOffset.dx,
        text.getOffset.dy,
        0,
        0,
      );
      if (text.getTextBackgroundColor != null)
        textDB.backgroundColor = text.getTextBackgroundColor.value;
      if (text.getTextFrame != null)
        textDB.textFrameId = text.getTextFrame.getFrameId;
      // textBox.put(text.getTextId, textDB);
      textBox.add(textDB);
    });
    diaryBD.diaryContent = textBox.getAt(0).textContent;
    textBox.values.toList().forEach((element) {
      print('>content ' + element.textContent);
    });
    await textBox.close();
  }

  Future<void> _saveEmotion(Emotion emotion, DiaryDB diaryBD) async {
    if (emotion == null || emotion.getEmotionComponent.getState == 3) return;
    var emotionBox =
        await Hive.openBox<EmotionDB>('emotion' + diaryBD.diaryBox.toString());
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
    if (emotion.getEmotionComponent.getState == 3) return;
    await emotionBox.add(emotionDB);

    // print('133> emotion: ' + emotion.getEmotionImage);
    await emotionBox.close();
  }
}
