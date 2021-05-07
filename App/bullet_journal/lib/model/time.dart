// @dart=2.9
import 'package:intl/intl.dart';

class MyDateTime {
  MyDate _date;
  MyStringDate _stringDate;
  MyTime _time;
  MyDateTime(DateTime dateTime) {
    this._date = MyDate(dateTime.day, dateTime.month, dateTime.year,
        DateFormat.E().format(dateTime));
    this._stringDate = MyStringDate(
        DateFormat.d().format(dateTime),
        DateFormat.MMM().format(dateTime),
        DateFormat.y().format(dateTime),
        DateFormat.E().format(dateTime));
    if (dateTime.hour != null)
      this._time = MyTime(dateTime.hour, dateTime.minute, dateTime.second);
  }
  MyDate get getDate => this._date;
  MyStringDate get getStringDate => this._stringDate;
  MyTime get getTime => this._time;
}

class MyTime {
  int _h, _m, _s;
  MyTime(int hour, int minute, int second) {
    this._h = hour;
    this._m = minute;
    this._s = second;
  }
  int get getHour => this._h;
  int get getMinute => this._m;
  int get getSecond => this._s;
}

class MyDate {
  int _day, _month, _year;
  String _weekday;
  MyDate(int day, int month, int year, String weekday) {
    this._day = day;
    this._month = month;
    this._year = year;
    this._weekday = weekday;
  }
  int get getDay => this._day;
  int get getMonth => this._month;
  int get getYear => this._year;
  String get getWeekday => this._weekday;
}

class MyStringDate {
  String _stringDay, _stringMonth, _stringYear;
  String _weekday;
  MyStringDate(String stringDate, String stringMonth, String stringYear,
      String weekday) {
    this._stringDay = stringDate;
    this._stringMonth = stringMonth;
    this._stringYear = stringYear;
    this._weekday = weekday;
  }
  String get getStringDay => this._stringDay;
  String get getStringMonth => this._stringMonth;
  String get getStringYear => this._stringYear;
  String get getWeekday => this._weekday;
}
