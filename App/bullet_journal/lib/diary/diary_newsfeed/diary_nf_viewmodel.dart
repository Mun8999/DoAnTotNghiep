// @dart=2.9
import 'package:bullet_journal/database/db_diary.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';

List<DiaryDB> diaries;

class DiaryNewsFeedViewModel {
  var diaryBox;
  final _searchController = new BehaviorSubject<List<DiaryDB>>();
  Stream get getSearchStream => this._searchController.stream;
  List<DiaryDB> _diaryData = [];
  List<DiaryDB> _diarySearch = [];
  DiaryNewsFeedViewModel(List<DiaryDB> diaryDBData) {
    initData(diaryDBData);
    // _diaryData.clear();
    // _diaryData.addAll(diaryDBData);
  }

  bool searchDiary(String key, List<DiaryDB> diaryDBData) {
    initData(diaryDBData);
    if (key.isEmpty) {
      _searchController.sink.add(_diaryData);
      return true;
    }
    _diarySearch = [];
    for (int i = 0; i < _diaryData.length; i++) {
      if (_diaryData[i].diaryContent.contains(key))
        _diarySearch.add(_diaryData[i]);
    }
    _searchController.sink.add(_diarySearch);
    if (_diarySearch.isEmpty)
      return false;
    else
      return true;
  }

  backEvent() {
    _searchController.sink.add(_diaryData);
  }

  prepareDB(Box<DiaryDB> box) async {
    DiaryDB diaryDB;
    for (int i = 0; i < 4; i++) {
      diaryDB = DiaryDB(
        DateTime.now(),
        diaryId: i,
        diaryContent: 'abcdefggggshdg',
      );
      box.add(diaryDB);
    }
  }

  // addDiary(DiaryDB diaryDB) async {
  //   await diaryBox.add(diaryDB);
  // }

  getDiaries(Box<DiaryDB> box) async {
    // var diaryBox = Hive.box<DiaryDB>('diaries');
    box.values.toList().forEach((element) {
      print('28>Diary content: ' +
          element.diaryContent +
          '\nImage: ' +
          element.diaryImage +
          '\nDatetime: ' +
          element.diaryTime.toString());
    });
  }

  Future<void> initData(List<DiaryDB> diaryDBData) async {
    _searchController.sink.add(diaryDBData);
    _diaryData = diaryDBData;
  }
}
