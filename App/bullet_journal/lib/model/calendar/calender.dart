// @dart=2.9
// import 'package:intl/intl.dart';
import 'package:date_util/date_util.dart';
import 'package:intl/intl.dart';

class Calender {
  List<int> _months = [];
  List<int> _years = [];
  List<int> _days = [];
  List<String> _stringAbbreviationMonths = [];
  List<String> _stringMonths = [];
  _setYear() {
    for (int i = 1950; i <= 2040; i++) {
      _years.add(i);
    }
  }

  _setMonth() {
    for (int i = 1; i <= 12; i++) {
      _months.add(i);
    }
  }

  int getDaysInMonth(int year, int month) {
    return DateUtil().daysInMonth(month, year);
  }

  _setStringMonth(List<int> months) {
    String abbreviationMonth = '', stringMonth = '';
    months.forEach((month) {
      abbreviationMonth = DateFormat.LLL().format(DateTime(2021, month, 1));
      _stringAbbreviationMonths.add(abbreviationMonth);
      stringMonth = DateFormat.LLLL().format(DateTime(2021, month, 1));
      _stringMonths.add(stringMonth);
    });
  }

  Calender() {
    _setYear();
    _setMonth();
    _setStringMonth(_months);
  }
  List<int> get getYear => _years;
  List<int> get getMonth => _months;
  List<String> get getStringMonth => _stringMonths;
  List<String> get getStringAbbreviationMonth => _stringAbbreviationMonths;
}

class Year {
  int _year;
  List<Month> _months = [];
  Year(int year) {
    _init(year);
  }
  _init(int year) async {
    this._year = year;
    await _addMonth();
  }

  _addMonth() {
    Month month;
    for (int i = 0; i < 12; i++) {
      month = Month(this._year, i + 1);
      _months.add(month);
      // this._months.forEach((month) {
      //   print('59> ' + month._firstDayOfMonth.toString());
      // });
    }
  }

  int get getYear => this._year;
  List<Month> get getMonth => this._months;
}

class Month {
  int _month;
  List<int> _days = [];
  int _firstDayOfMonth = -1;
  int _lastDayOfMonth = -1;
  Month(int year, int month) {
    _init(year, month);
  }
  _init(int year, int month) async {
    this._month = month;
    DateTime _dt = DateTime(year, month, 1);
    this._firstDayOfMonth = _dt.weekday;
    int dayOfMonth = DateUtil().daysInMonth(month, year);
    _dt = DateTime(year, month, dayOfMonth);
    this._lastDayOfMonth = _dt.weekday;
    await _addDay(year, month);
    // print('85> first day: ' + this._firstDayOfMonth.toString());
    // print(_days.toString());
  }

  _addDay(int year, int month) async {
    // print('95> tháng: ' + month.toString());
    int dayOfMonth = DateUtil().daysInMonth(month, year);
    for (int i = 0; i < dayOfMonth; i++) {
      _days.add(i + 1);
    }
  }

  // String toString() =>
  //     this._month.toString() + ' ' + this._firstDayOfMonth.toString();
  int get getMonth => this._month;
  List<int> get getDaysOfMonth => this._days;
  int get getFirstDayOfMonth => this._firstDayOfMonth;
  // int getDayOfMonth() => this._firstDayOfMonth;
  int get getLastDayOfMonth => this._lastDayOfMonth;
}
// class DayInMonth {}
// class Month{

// }
// class Year {
//   int _year;
//   Year(int year) {
//     this._year = year;
//   }
//   int get getYear => _year;
// }
