// @dart=2.9
import 'package:bullet_journal/database/db_diary.dart';
import 'package:hive/hive.dart';

List<DiaryDB> diaries;

class DiaryNewsFeedViewModel {
  var diaryBox;
  DiaryNewsFeedViewModel() {
    prepareDB();
    getDiaries();
  }
  prepareDB() async {
    diaryBox = await Hive.box<DiaryDB>('diaries');
    DiaryDB diaryDB = DiaryDB(DateTime.now(),
        diaryContent: 'abcdefggggshdg',
        diaryImage: 'assets/images/FB_IMG_1619006556060.jpg');
    for (int i = 0; i < 4; i++) {
      await addDiary(diaryDB);
    }
  }

  addDiary(DiaryDB diaryDB) async {
    await diaryBox.add(diaryDB);
  }

  getDiaries() async {
    // var diaryBox = Hive.box<DiaryDB>('diaries');
    diaryBox.values.toList().forEach((element) {
      print('28>Diary content: ' +
          element.diaryContent +
          '\nImage: ' +
          element.diaryImage +
          '\nDatetime: ' +
          element.diaryTime.toString());
    });
  }
}
