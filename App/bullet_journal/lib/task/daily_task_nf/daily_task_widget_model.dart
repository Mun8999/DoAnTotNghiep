// @dart=2.9
import 'package:bullet_journal/database/db_dailytask.dart';
import 'package:hive/hive.dart';

class DailyTaskWidgetViewModel {
  List<DailyTaskDB> tasks = [
    DailyTaskDB(
        DateTime(2021, 15, 6, 5, 0), DateTime(2021, 15, 6, 5, 30), 'Chạy bộ',
        reminder: true, dailyTaskDepcription: '12323243', dailyTaskState: true),
    DailyTaskDB(
        DateTime(2021, 15, 6, 7, 0), DateTime(2021, 15, 6, 8, 0), 'Đọc sách'),
    DailyTaskDB(
        DateTime(2021, 15, 6, 11, 0), DateTime(2021, 15, 6, 12, 0), 'Ăn trưa'),
    DailyTaskDB(DateTime(2021, 1, 1, 14, 30), DateTime(2021, 15, 6, 15, 0),
        'Làm bài tập',
        reminder: true, dailyTaskDepcription: 'Môn lập trình nâng cao'),
    DailyTaskDB(
        DateTime(2021, 1, 1, 16, 0), DateTime(2021, 15, 6, 17, 0), 'Dọn nhà')
  ];

  Future prepareTask(Box<DailyTaskDB> dailyTaskBox) async {
    dailyTaskBox.clear();
    tasks.forEach((task) async {
      await dailyTaskBox.add(task);
    });
  }
}
