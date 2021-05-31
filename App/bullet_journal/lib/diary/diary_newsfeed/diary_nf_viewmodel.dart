// @dart=2.9
import 'package:bullet_journal/database/db_diary.dart';
import 'package:hive/hive.dart';

List<DiaryDB> diaries;

class DiaryNewsFeedViewModel {
  var diaryBox;
  DiaryNewsFeedViewModel() {
    // prepareDB();
    // getDiaries();
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
}
