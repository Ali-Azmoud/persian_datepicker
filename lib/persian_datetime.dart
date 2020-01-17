import 'jalaali_js.dart';

class PersianDateTime {
  DateTime datetime;
  Jalaali _jalaaliDateTime;

  int jalaaliYear;
  int jalaaliMonth;
  int jalaaliDay;
  int jalaaliShortYear;
  String jalaaliZeroLeadingDay;
  String jalaaliZeroLeadingMonth;
  String jalaaliMonthName;

  int gregorianYear;
  int gregorianMonth;
  int gregorianDay;
  int gregorianShortYear;
  String gregorianZeroLeadingDay;
  String gregorianZeroLeadingMonth;
  String gregorianMonthName;
  String gregorianShortMonthName;

  PersianDateTime({jalaaliDateTime}) {
    _makeStandardDateTimeFromJalaaliString(jalaaliDateTime);
  }

  PersianDateTime.fromGregorian({gregorianDateTime}) {
    if (gregorianDateTime == null) {
      DateTime now = DateTime.now();
      gregorianDateTime = now.year.toString() +
          '-' +
          now.month.toString() +
          '-' +
          now.day.toString();
    }
    List<String> datetimeParts = gregorianDateTime.split("-");
    Gregorian gregorian = Gregorian(int.parse(datetimeParts[0]),
        int.parse(datetimeParts[1]), int.parse(datetimeParts[2]));
    _makeStandardDateTimeFromJalaaliString(gregorian.toJalaali().toString());
  }

  String toJalaali({String format = 'YYYY/MM/DD'}) {
    return translate(format, _jalaaliDateTime, false);
  }

  String toGregorian({String format = 'YYYY-MM-DD'}) {
    return translateStandardDateTime(format, datetime);
  }

  bool isAfter(PersianDateTime otherDate) {
    return this.datetime.isAfter(otherDate.datetime) ? true : false;
  }

  bool isBefore(PersianDateTime otherDate) {
    return this.datetime.isBefore(otherDate.datetime) ? true : false;
  }

  bool isEqual(PersianDateTime otherDate) {
    return this.datetime.compareTo(otherDate.datetime) == 0 ? true : false;
  }

  PersianDateTime add(Duration duration) {
    DateTime newDateTime = this.datetime.add(duration);
    return PersianDateTime(
        jalaaliDateTime:
            Gregorian(newDateTime.year, newDateTime.month, newDateTime.day)
                .toJalaali()
                .toString());
  }

  PersianDateTime subtract(Duration duration) {
    DateTime newDateTime = this.datetime.subtract(duration);
    return PersianDateTime(
        jalaaliDateTime:
            Gregorian(newDateTime.year, newDateTime.month, newDateTime.day)
                .toJalaali()
                .toString());
  }

  Duration difference(PersianDateTime otherDate) {
    return this.datetime.difference(otherDate.datetime);
  }

  String toString() {
    return translate('YYYY/MM/DD', this._jalaaliDateTime, false);
  }

  void _makeJalaaliDateTimeFromJalaaliString(String jalaaliString) {
    if (jalaaliString == null) {
      _jalaaliDateTime = Jalaali.now();
    } else {
      List<String> datetimeParts = jalaaliString.split("/");
      _jalaaliDateTime = Jalaali(int.parse(datetimeParts[0]),
          int.parse(datetimeParts[1]), int.parse(datetimeParts[2]));
    }
  }

  void _makeStandardDateTimeFromJalaaliString(String jalaaliString) {
    _makeJalaaliDateTimeFromJalaaliString(jalaaliString);
    this.datetime = _jalaaliDateTime.toGregorian().toDateTime();

    jalaaliYear = _jalaaliDateTime.year;
    jalaaliMonth = _jalaaliDateTime.month;
    jalaaliDay = _jalaaliDateTime.day;
    jalaaliShortYear =
        int.parse(_jalaaliDateTime.year.toString().substring(2, 4));
    jalaaliZeroLeadingDay = _jalaaliDateTime.day.toString().padLeft(2, "0");
    jalaaliZeroLeadingMonth = _jalaaliDateTime.month.toString().padLeft(2, "0");
    jalaaliMonthName = getJalaaliMonthName(_jalaaliDateTime.month);

    gregorianYear = this.datetime.year;
    gregorianMonth = this.datetime.month;
    gregorianDay = this.datetime.day;
    gregorianShortYear =
        int.parse(this.datetime.year.toString().substring(2, 4));
    gregorianZeroLeadingDay = this.datetime.day.toString().padLeft(2, "0");
    gregorianZeroLeadingMonth = this.datetime.month.toString().padLeft(2, "0");
    gregorianMonthName = getGregorianMonthName(this.datetime.month);
    gregorianShortMonthName = getGregorianMonthNameAbbr(this.datetime.month);
  }
}
