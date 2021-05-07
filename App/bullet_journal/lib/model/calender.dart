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
    for (int i = 1950; i <= 2050; i++) {
      _years.add(i);
    }
  }

  _setMonth() {
    for (int i = 1; i <= 12; i++) {
      _months.add(i);
    }
  }

  setDay(int year, int month) {
    int daysInMonth = DateUtil().daysInMonth(month, year);
    for (int i = 1; i <= daysInMonth; i++) {
      _days.add(i);
    }
  }

  _setStringMonth(List<int> months) {
    String abbreviationMonth = '', stringMonth = '';
    // months.forEach((month) {
    //   print(month);
    //   abbreviationMonth = DateFormat.LLL().format(DateTime(1, month, 2021));
    //   _stringAbbreviationMonths.add(abbreviationMonth);
    //   stringMonth = DateFormat.LLLL().format(DateTime(1, month, 2021));
    //   _stringMonths.add(stringMonth);
    // });
    for (int month = 1; month <= 12; month++) {
      abbreviationMonth = DateFormat.MMM().format(DateTime(2021, month, 1));
      _stringAbbreviationMonths.add(abbreviationMonth);
      stringMonth = DateFormat.MMMM().format(DateTime(1, month, 2021));
      _stringMonths.add(stringMonth);
    }
  }

  Calender() {
    _setYear();
    _setMonth();
    _setStringMonth(_months);
  }
  List<int> get getYear => _years;
  List<int> get getMonth => _months;
  List<int> get getDay => _days;
  List<String> get getStringMonth => _stringMonths;
  List<String> get getStringAbbreviationMonth => _stringAbbreviationMonths;
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
