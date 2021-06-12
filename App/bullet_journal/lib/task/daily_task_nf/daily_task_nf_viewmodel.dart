// @dart=2.9

import 'package:bullet_journal/model/calendar/calender.dart';
import 'package:rxdart/rxdart.dart';

class DailyTaskNewsFeedViewModel {
  DateTime _dateNow;
  Year _year;
  Month _month;
  List<int> _days = []; //// nhớ khởi tạo mảng dùm cái ==
  final _yearController = BehaviorSubject<Year>();
  final _monthController = BehaviorSubject<Month>();
  DailyTaskNewsFeedViewModel() {
    _init();
  }
  _init() async {
    _dateNow = DateTime.now();
    _year = Year(2020);
    // _yearController.sink.add(_year);
    // _month = Month(_year.getYear, _dateNow.month);
    // _monthController.sink.add(_month);
    setDay(5);
  }

  setMonthSelected(Month month) {
    _monthController.sink.add(month);
  }

  Future<void> setDay(int month) async {
    int preMonth = month - 1, nexMonth = month + 1;
    print('31> ----' + month.toString());
    int firstDay = _year.getMonth[month].getFirstDayOfMonth;
    print('32> first day: ' + firstDay.toString());
    int lastDay = _year.getMonth[month].getLastDayOfMonth;
    print('34> last day: ' + lastDay.toString());
    // _year.getMonth.forEach((_month) {
    //   print('35>tháng ' + _month.getMonth.toString());
    //   print('ngày ' + _month.getDaysOfMonth.toString());
    // });
    int day;
    // print('40> 1232312 ' + _year.getMonth[preMonth].getDaysOfMonth.toString());
    // print(
    //     '42> hahaha ' + _year.getMonth[preMonth].getDaysOfMonth[30].toString());
    int preDays = _year.getMonth[preMonth].getDaysOfMonth.length;
    for (int i = preDays - firstDay + 1; i < preDays; i++) {
      day = _year.getMonth[preMonth].getDaysOfMonth[i];
      this._days.add(day);
    }
    for (int i = 0; i < _year.getMonth[month].getDaysOfMonth.length; i++) {
      this._days.add(_year.getMonth[month].getDaysOfMonth[i]);
    }
    int nextDayLength = 7 - lastDay;
    if (nextDayLength > 0) {
      for (int i = 0; i < nextDayLength; i++) {
        this._days.add(_year.getMonth[nexMonth].getDaysOfMonth[i]);
      }
    }

    print('51> ngày trong tháng');
    print(_days.toString());
  }

  Stream get getMonthStream => this._monthController.stream;
  List<Month> get getMonthList => _year.getMonth;

  // List<int> _years = [];
  // List<int> _months = [];
  // List<String> _stringMonths = [];
  // List<String> _stringAbbreviationMonths = [];
  // final _daysInMonth = BehaviorSubject<int>();
  // final _monthSelectedController = BehaviorSubject<String>();
  // Calender _calender = Calender();

  // DailyTaskNewsFeedViewModel() {
  //   _setYearData();
  //   _setStringMonthData();
  //   _setAbbreviationMonthData();
  //   _setMonths();
  // }
  // setMonthSelected(String month) {
  //   _monthSelectedController.sink.add(month);
  // }

  // _setYearData() => _years.addAll(_calender.getYear);

  // _setStringMonthData() => _stringMonths.addAll(_calender.getStringMonth);

  // _setAbbreviationMonthData() =>
  //     _stringAbbreviationMonths.addAll(_calender.getStringAbbreviationMonth);

  // _setMonths() => _months.addAll(_calender.getMonth);

  // int getDayData(int year, int month) {
  //   int days = _calender.getDaysInMonth(year, month);
  //   _daysInMonth.sink.add(days);
  //   return days;
  // }

  // List<int> get getYears => this._years;
  // List<String> get getStringMonths => this._stringMonths;
  // List<String> get getStringAbbreviationMonths =>
  //     this._stringAbbreviationMonths;
  // Stream get getMonthSelectedStream => this._monthSelectedController.stream;
}
