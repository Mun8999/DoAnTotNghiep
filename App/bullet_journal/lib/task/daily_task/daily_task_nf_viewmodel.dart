// @dart=2.9
import 'package:bullet_journal/model/calender.dart';
import 'package:rxdart/rxdart.dart';

class DailyTaskNewsFeedViewModel {
  List<int> _years = [];
  List<int> _months = [];
  List<String> _stringMonths = [];
  List<String> _stringAbbreviationMonths = [];
  final _daysInMonth = BehaviorSubject<int>();
  final _monthSelectedController = BehaviorSubject<String>();
  Calender _calender = Calender();

  DailyTaskNewsFeedViewModel() {
    _setYearData();
    _setStringMonthData();
    _setAbbreviationMonthData();
    _setMonths();
  }
  setMonthSelected(String month) {
    _monthSelectedController.sink.add(month);
  }

  _setYearData() => _years.addAll(_calender.getYear);

  _setStringMonthData() => _stringMonths.addAll(_calender.getStringMonth);

  _setAbbreviationMonthData() =>
      _stringAbbreviationMonths.addAll(_calender.getStringAbbreviationMonth);

  _setMonths() => _months.addAll(_calender.getMonth);

  int getDayData(int year, int month) {
    int days = _calender.getDaysInMonth(year, month);
    _daysInMonth.sink.add(days);
    return days;
  }

  List<int> get getYears => this._years;
  List<String> get getStringMonths => this._stringMonths;
  List<String> get getStringAbbreviationMonths =>
      this._stringAbbreviationMonths;
  Stream get getMonthSelectedStream => this._monthSelectedController.stream;
}
