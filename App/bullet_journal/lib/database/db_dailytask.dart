// @dart=2.9
import 'package:hive/hive.dart';
part 'db_dailytask.g.dart';

@HiveType(typeId: 6)
class DailyTaskDB {
  @HiveField(0)
  int dailyTaskId;
  @HiveField(1)
  DateTime dailyTaskTime;
  @HiveField(2)
  String dailyTaskContent;
  @HiveField(3)
  String dailyTaskDep;
  @HiveField(4)
  bool dailyTaskState;
  @HiveField(5)
  bool reminder;
  DailyTaskDB(DateTime dailyTaskTime, String dailyTaskContent,
      {int dailyTaskId = -1,
      bool dailyTaskState = false,
      bool reminder = false,
      String dailyTaskDepcription}) {
    this.dailyTaskTime = dailyTaskTime;
    this.dailyTaskContent = dailyTaskContent;
    this.dailyTaskId = dailyTaskId;
    this.dailyTaskState = dailyTaskState;
    this.reminder = reminder;
    this.dailyTaskDep = dailyTaskDep;
  }
}
