// @dart=2.9
import 'package:hive/hive.dart';
part 'db_dailytask.g.dart';

@HiveType(typeId: 6)
class DailyTaskDB {
  @HiveField(0)
  int dailyTaskId;
  @HiveField(1)
  DateTime dailyTaskTimeStart;
  @HiveField(2)
  DateTime dailyTaskTimeEnd;
  @HiveField(3)
  String dailyTaskContent;
  @HiveField(4)
  String dailyTaskDep;
  @HiveField(5)
  bool dailyTaskState;
  @HiveField(6)
  bool reminder;
  DailyTaskDB(DateTime dailyTaskTimeStart, DateTime dailyTaskTimeEnd,
      String dailyTaskContent,
      {int dailyTaskId = -1,
      bool dailyTaskState = false,
      bool reminder = false,
      String dailyTaskDepcription}) {
    this.dailyTaskTimeStart = dailyTaskTimeStart;
    this.dailyTaskTimeEnd = dailyTaskTimeEnd;
    this.dailyTaskContent = dailyTaskContent;
    this.dailyTaskId = dailyTaskId;
    this.dailyTaskState = dailyTaskState;
    this.reminder = reminder;
    this.dailyTaskDep = dailyTaskDep;
  }
}
