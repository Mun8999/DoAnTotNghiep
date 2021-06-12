// @dart=2.9
import 'package:intl/intl.dart';

class MyDateTime {
  MyDate _date;
  MyStringDate _stringDate;
  MyTime _time;
  MyDateTime(DateTime dateTime) {
    this._date =
        MyDate(dateTime.day, dateTime.month, dateTime.year, dateTime.weekday);
    this._stringDate = MyStringDate(
        DateFormat.d().format(dateTime),
        DateFormat.MMM().format(dateTime),
        DateFormat.y().format(dateTime),
        dateTime.weekday);
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
  @override
  String toString() {
    String h, m;
    if (this._h > 9)
      h = this._h.toString();
    else
      h = '0' + this._h.toString();
    if (this._m > 9)
      m = this._m.toString();
    else
      m = '0' + this._m.toString();
    return h + ':' + m;
  }
}

class MyDate {
  int _day, _month, _year;
  int _weekday;
  MyDate(int day, int month, int year, int weekday) {
    this._day = day;
    this._month = month;
    this._year = year;
    this._weekday = weekday;
  }
  int get getDay => this._day;
  int get getMonth => this._month;
  int get getYear => this._year;
  int get getWeekday => this._weekday;
  @override
  String toString() {
    String day, month;
    if (this._day > 9)
      day = this._day.toString();
    else
      day = '0' + this._day.toString();
    if (this._month > 9)
      month = this._month.toString();
    else
      month = '0' + this._month.toString();
    return day + ' - ' + month + ' - ' + this._year.toString();
  }
}

class MyStringDate {
  String _stringDay, _stringMonth, _stringYear;
  int _weekday;
  MyStringDate(
      String stringDate, String stringMonth, String stringYear, int weekday) {
    this._stringDay = stringDate;
    this._stringMonth = stringMonth;
    this._stringYear = stringYear;
    this._weekday = weekday;
  }
  String get getStringDay => this._stringDay;
  String get getStringMonth => this._stringMonth;
  String get getStringYear => this._stringYear;
  int get getWeekday => this._weekday;
}
