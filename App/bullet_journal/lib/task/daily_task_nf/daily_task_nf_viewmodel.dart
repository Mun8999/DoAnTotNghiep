// @dart=2.9

import 'package:bullet_journal/model/calendar/calender.dart';
import 'package:rxdart/rxdart.dart';

class DailyTaskNewsFeedViewModel {
  DateTime _dateNow;
  Year _year;
  // Month _month;
  List<DayCalendar> _days = []; //// nhớ khởi tạo mảng dùm cái ==
  final _calendarController = BehaviorSubject<Year>();
  final _dayController = BehaviorSubject<List<DayCalendar>>();
  // final _monthController = BehaviorSubject<Month>();
  DailyTaskNewsFeedViewModel() {
    _init();
  }
  _init() async {
    _dateNow = DateTime.now();
    _year = Year(_dateNow.year);
    _calendarController.sink.add(_year);
    // _month = Month(_year.getYear, _dateNow.month);
    // _monthController.sink.add(_month);
    setDayInMonth(_dateNow.month);
  }
  // setMonthSelected(Month month) {
  //   _monthController.sink.add(month);
  // }

  Future<void> setDayInMonth(int month) async {
    _days.clear();
    month--;
    int preMonth = month - 1, nexMonth = month + 1;
    print('31> ----' +
        _year.getMonth[month].getAbbrMonth +
        ', ' +
        _year.getMonth[month].getStringMonth);
    int firstDay = _year.getMonth[month].getFirstDayOfMonth;
    print('32> first day: ' + firstDay.toString());
    int lastDay = _year.getMonth[month].getLastDayOfMonth;
    // if (lastDay == 0) lastDay = 6;
    // if (lastDay == 6) lastDay = 0;
    print('34> last day: ' + lastDay.toString());
    // _year.getMonth.forEach((_month) {
    //   print('35>tháng ' + _month.getMonth.toString());
    //   print('ngày ' + _month.getDaysOfMonth.toString());
    // });
    // print('40> 1232312 ' + _year.getMonth[preMonth].getDaysOfMonth.toString());
    // print(
    //     '42> hahaha ' + _year.getMonth[preMonth].getDaysOfMonth[30].toString());
    DayCalendar day;

    if (month > 0) {
      int preDays = _year.getMonth[preMonth].getDaysOfMonth.length;
      for (int i = preDays - firstDay + 1; i < preDays; i++) {
        day = DayCalendar(_year.getMonth[preMonth].getDaysOfMonth[i], preMonth);
        this._days.add(day);
      }
    }
    for (int i = 0; i < _year.getMonth[month].getDaysOfMonth.length; i++) {
      day = DayCalendar(_year.getMonth[month].getDaysOfMonth[i], month);
      this._days.add(day);
    }
    int nextDayLength = 7 - lastDay;
    print('62>nextDay ' + nextDayLength.toString());
    if (nexMonth < 12) {
      for (int i = 0; i < nextDayLength; i++) {
        day = DayCalendar(_year.getMonth[nexMonth].getDaysOfMonth[i], nexMonth);
        this._days.add(day);
      }
    }
    await _dayController.sink.add(_days);
    print('51> ngày trong tháng');
    print(_days.toString());
  }

  Stream get getCalendarController => this._calendarController.stream;
  Stream get getDayController => this._dayController.stream;
  // Stream get getMonthStream => this._monthController.stream;
  List<Month> get getMonthList => _year.getMonth;
  // List<DayCalendar> get getDays => this._days;
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

class DayCalendar {
  int _day;
  int _month;
  DayCalendar(int day, int month) {
    this._day = day;
    this._month = month;
  }
  String toString() => this._month.toString() + ' - ' + this._day.toString();
  int get getDay => this._day;
  int get getMonth => this._month;
}
