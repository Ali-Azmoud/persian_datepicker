import 'package:flutter/material.dart';
import 'jalaali_js.dart';

enum GregorianDaysLocation { topLeft, topRight, bottomLeft, bottomRight }

class PersianDatePicker {
  final TextEditingController controller;

  final Function(String oldText, String newText) onChange;

  String datetime;
  String finishDatetime;
  String gregorianDatetime;
  String gregorianFinishDatetime;
  String outputFormat;
  String rangeSeparator;
  String headerTodayCaption;
  String fontFamily;

  /// حداکثر تاریخی که میتوان در دیت پیکر انتخاب کرد
  String maxDatetime;

  /// حداقل تاریخی که میتوان در دیت پیکر انتخاب کرد
  String minDatetime;

  /// حداکثر فاصله ای که تاریخ شروع و تاریخ پایان میتوانند نسبت به یکدیگر داشته باشند
  Duration maxSpan;

  /// حداقل فاصله ای که تاریخ شروع و تاریخ پایان میتوانند نسبت به یکدیگر داشته باشند
  Duration minSpan;

  bool farsiDigits;
  bool rangeDatePicker;
  bool showGregorianDays;

  double datePickerHeight;
  double daysBorderWidth;

  Curve yearSelectionAnimationCurve;
  Curve monthSelectionAnimationCurve;

  Duration monthSelectionAnimationDuration;
  Duration yearSelectionAnimationDuration;
  Duration changePageDuration;

  TextStyle yearSelectionHighlightTextStyle;
  TextStyle yearSelectionTextStyle;
  TextStyle monthSelectionTextStyle;
  TextStyle monthSelectionHighlightTextStyle;
  TextStyle weekCaptionsTextStyle;
  TextStyle headerTextStyle;
  TextStyle daysTextStyle;
  TextStyle currentDayTextStyle;
  TextStyle selectedDayTextStyle;
  TextStyle disabledDayTextStyle;
  TextStyle headerTodayTextStyle;
  TextStyle gregorianDaysTextStyle;

  Color yearSelectionBackgroundColor;
  Color yearSelectionHighlightBackgroundColor;
  Color monthSelectionBackgroundColor;
  Color monthSelectionHighlightBackgroundColor;
  Color weekCaptionsBackgroundColor;
  Color headerBackgroundColor;
  Color daysBackgroundColor;
  Color selectedDayBackgroundColor;
  Color headerTodayBackgroundColor;
  Color disabledDayBackgroundColor;
  Color daysBorderColor;
  Color selectedDayBorderColor;
  Color selectedDaysInnerBorderColor;
  Color currentDayBorderColor;
  Color currentDayBackgroundColor;
  Color rangeFirstDaySelectedBackgroundColor;
  Color rangeLastDaySelectedBackgroundColor;

  Color selectionGradientColor;

  Icon headerTodayIcon;

  List<String> weekCaptions;

  GregorianDaysLocation gregorianDaysLocation;

  double dayBlockRadius;

  PersianDatePicker({
    @required this.controller,
    this.onChange,
    this.datetime,
    this.gregorianDatetime,
    this.finishDatetime,
    this.gregorianFinishDatetime,
    this.outputFormat = 'YYYY/MM/DD',
    this.rangeSeparator = ' # ',
    this.farsiDigits = false,
    this.datePickerHeight = 320,
    this.fontFamily = 'Roboto',
    this.rangeDatePicker = false,
    this.showGregorianDays = true,
    this.yearSelectionAnimationDuration = const Duration(milliseconds: 700),
    this.yearSelectionAnimationCurve = Curves.elasticOut,
    this.monthSelectionAnimationDuration = const Duration(milliseconds: 700),
    this.monthSelectionAnimationCurve = Curves.elasticOut,
    this.yearSelectionBackgroundColor = Colors.white,
    this.yearSelectionTextStyle =
        const TextStyle(fontSize: 16, color: Colors.black),
    this.yearSelectionHighlightBackgroundColor = const Color(0xffFAF4E1),
    this.yearSelectionHighlightTextStyle =
        const TextStyle(fontSize: 16, color: Color(0xff734505)),
    this.monthSelectionBackgroundColor = Colors.white,
    this.monthSelectionTextStyle =
        const TextStyle(fontSize: 16, color: Colors.black),
    this.monthSelectionHighlightBackgroundColor = const Color(0xffFAF4E1),
    this.monthSelectionHighlightTextStyle =
        const TextStyle(fontSize: 16, color: Color(0xff734505)),
    this.weekCaptionsBackgroundColor = Colors.blue,
    this.weekCaptionsTextStyle =
        const TextStyle(color: Colors.white, fontSize: 16),
    this.headerBackgroundColor = Colors.white,
    this.headerTextStyle = const TextStyle(color: Colors.black, fontSize: 18),
    this.daysBackgroundColor = Colors.transparent,
    this.daysTextStyle = const TextStyle(color: Colors.black87, fontSize: 16),
    this.currentDayBackgroundColor = const Color(0xffDDE8CA),
    this.currentDayTextStyle =
        const TextStyle(color: Colors.black, fontSize: 16),
    this.selectedDayBackgroundColor = const Color(0xffE9ECF5),
    this.selectedDayTextStyle =
        const TextStyle(color: Colors.black87, fontSize: 16),
    this.headerTodayBackgroundColor = const Color(0xffE0E8D3),
    this.disabledDayBackgroundColor = const Color(0xffEEEEEE),
    this.disabledDayTextStyle =
        const TextStyle(color: Color(0xffA0A0A0), fontSize: 16),
    this.headerTodayCaption = 'امروز',
    this.headerTodayTextStyle = const TextStyle(fontSize: 19),
    this.headerTodayIcon = const Icon(
      Icons.date_range,
      color: Colors.green,
      size: 20,
    ),
    this.selectedDayBorderColor = const Color(0xff9EA8F0),
    this.selectedDaysInnerBorderColor = const Color(0xffE8D5F5),
    this.currentDayBorderColor = Colors.green,
    this.daysBorderColor =
        const Color(0xffEDEDED), //Colors.black.withOpacity(0.02),
    this.daysBorderWidth = 0.5,
    this.weekCaptions = const ['ش', 'ی', 'د', 'س', 'چ', 'پ', 'ج'],
    this.changePageDuration = const Duration(milliseconds: 500),
    this.gregorianDaysTextStyle =
        const TextStyle(fontSize: 11, color: Color(0xFFC5C5C5)),
    this.gregorianDaysLocation = GregorianDaysLocation.bottomLeft,
    this.rangeFirstDaySelectedBackgroundColor = const Color(0xffC9ECF5),
    this.rangeLastDaySelectedBackgroundColor = const Color(0xffC9ECF5),
    this.selectionGradientColor = const Color(0x44333333),
    this.maxDatetime,
    this.minDatetime,
    this.maxSpan,
    this.minSpan,
    this.dayBlockRadius,
  })  : assert(controller != null),
        assert(maxSpan == null ||
            minSpan == null ||
            (maxSpan != null && minSpan != null && maxSpan > minSpan));

  String _detectOutputSeparator(String outputFormat) {
    List<String> validCharacters = ['Y', 'M', 'D'];

    String separator = "/";

    outputFormat.runes.forEach((int rune) {
      var character = String.fromCharCode(rune);
      if (validCharacters.indexOf(character) < 0) {
        separator = character;
      }
    });

    return separator;
  }

  PersianDatePickerWidget init() {
    {
      datetime = englishNumbers(datetime);
      finishDatetime = englishNumbers(finishDatetime);
      gregorianDatetime = englishNumbers(gregorianDatetime);
      gregorianFinishDatetime = englishNumbers(gregorianFinishDatetime);

      String outputSeparator = _detectOutputSeparator(outputFormat);
      if (outputSeparator == rangeSeparator) {
        controller.text = 'جداکننده های محدوده و خروجی مشابه هستند';
        return null;
      }

      if ((datetime != null && finishDatetime != null) ||
          (gregorianDatetime != null && gregorianFinishDatetime != null))
        rangeDatePicker = true;

      String defaultInputFormat = 'YYYY/MM/DD';

      Jalaali jDatetime;
      Jalaali jFinishDatetime;
      Gregorian gregorianDate;
      Gregorian gregorianFinishDate;

      if (gregorianDatetime != null &&
          gregorianDatetime.toString().isNotEmpty) {
        List<String> gArray = gregorianDatetime.split("-");
        gregorianDate = Gregorian(
            int.parse(gArray[0]), int.parse(gArray[1]), int.parse(gArray[2]));

        if (gregorianFinishDatetime != null) {
          List<String> gfArray = gregorianFinishDatetime.split("-");
          gregorianFinishDate = Gregorian(int.parse(gfArray[0]),
              int.parse(gfArray[1]), int.parse(gfArray[2]));
        }

        if (gregorianFinishDate != null) {
          controller.text = translate(
                  outputFormat, gregorianDate.toJalaali(), false) +
              rangeSeparator +
              translate(outputFormat, gregorianFinishDate.toJalaali(), false);
        } else {
          controller.text =
              translate(outputFormat, gregorianDate.toJalaali(), false);
        }
      } else {
//        jDatetime = Jalaali.now();

        if (datetime != null && datetime.toString().isNotEmpty) {
          // default format
          jDatetime = _parseDatetimeInput(datetime, defaultInputFormat, "/");

          if (finishDatetime != null) {
            // default format
            jFinishDatetime =
                _parseDatetimeInput(finishDatetime, defaultInputFormat, "/");
          }

          if (jFinishDatetime != null) {
            controller.text = translate(outputFormat, jDatetime, true) +
                rangeSeparator +
                translate(outputFormat, jFinishDatetime, true);
          } else {
            controller.text = translate(outputFormat, jDatetime, true);
          }
        }
      }
      if (yearSelectionTextStyle.fontFamily == null)
        yearSelectionTextStyle =
            yearSelectionTextStyle.apply(fontFamily: fontFamily);
      if (monthSelectionTextStyle.fontFamily == null)
        monthSelectionTextStyle =
            monthSelectionTextStyle.apply(fontFamily: fontFamily);
      if (weekCaptionsTextStyle.fontFamily == null)
        weekCaptionsTextStyle =
            weekCaptionsTextStyle.apply(fontFamily: fontFamily);
      if (daysTextStyle.fontFamily == null)
        daysTextStyle = daysTextStyle.apply(fontFamily: fontFamily);
      if (currentDayTextStyle.fontFamily == null)
        currentDayTextStyle = currentDayTextStyle.apply(fontFamily: fontFamily);
      if (selectedDayTextStyle.fontFamily == null)
        selectedDayTextStyle =
            selectedDayTextStyle.apply(fontFamily: fontFamily);
      if (disabledDayTextStyle.fontFamily == null)
        disabledDayTextStyle =
            disabledDayTextStyle.apply(fontFamily: fontFamily);
      if (yearSelectionHighlightTextStyle.fontFamily == null)
        yearSelectionHighlightTextStyle =
            yearSelectionHighlightTextStyle.apply(fontFamily: fontFamily);
      if (monthSelectionHighlightTextStyle.fontFamily == null)
        monthSelectionHighlightTextStyle =
            monthSelectionHighlightTextStyle.apply(fontFamily: fontFamily);
      if (headerTodayTextStyle.fontFamily == null)
        headerTodayTextStyle =
            headerTodayTextStyle.apply(fontFamily: fontFamily);
      if (headerTextStyle.fontFamily == null)
        headerTextStyle = headerTextStyle.apply(fontFamily: fontFamily);

      Map<String, dynamic> options = {
        'defaultInputFormat': defaultInputFormat,
        'controller': controller,
        'onChange': onChange,
        'separator': outputSeparator,
        'rangeSeparator': rangeSeparator,
        'outputFormat': outputFormat,
        'rangeDatePicker': rangeDatePicker,
        'showGregorianDays': showGregorianDays,
        'farsiDigits': farsiDigits,
        'datePickerHeight': datePickerHeight,
        'yearSelectionAnimationDuration': yearSelectionAnimationDuration,
        'yearSelectionAnimationCurve': yearSelectionAnimationCurve,
        'yearSelectionHighlightBackgroundColor':
            yearSelectionHighlightBackgroundColor,
        'monthSelectionAnimationDuration': monthSelectionAnimationDuration,
        'monthSelectionAnimationCurve': monthSelectionAnimationCurve,
        'monthSelectionHighlightBackgroundColor':
            monthSelectionHighlightBackgroundColor,
        'yearSelectionBackgroundColor': yearSelectionBackgroundColor,
        'monthSelectionBackgroundColor': monthSelectionBackgroundColor,
        'weekCaptionsBackgroundColor': weekCaptionsBackgroundColor,
        'headerBackgroundColor': headerBackgroundColor,
        'daysBackgroundColor': daysBackgroundColor,
        'currentDayBackgroundColor': currentDayBackgroundColor,
        'selectedDayBackgroundColor': selectedDayBackgroundColor,
        'headerTodayBackgroundColor': headerTodayBackgroundColor,
        'disabledDayBackgroundColor': disabledDayBackgroundColor,
        'headerTodayCaption': headerTodayCaption,
        'headerTodayTextStyle': headerTodayTextStyle,
        'headerTodayIcon': headerTodayIcon,
        'selectedDayBorderColor': selectedDayBorderColor,
        'selectedDaysInnerBorderColor': selectedDaysInnerBorderColor,
        'currentDayBorderColor': currentDayBorderColor,
        'daysBorderColor': daysBorderColor,
        'daysBorderWidth': daysBorderWidth,
        'weekCaptions': weekCaptions,
        'yearSelectionHighlightTextStyle': yearSelectionHighlightTextStyle,
        'monthSelectionHighlightTextStyle': monthSelectionHighlightTextStyle,
        'yearSelectionTextStyle': yearSelectionTextStyle,
        'monthSelectionTextStyle': monthSelectionTextStyle,
        'weekCaptionsTextStyle': weekCaptionsTextStyle,
        'headerTextStyle': headerTextStyle,
        'daysTextStyle': daysTextStyle,
        'currentDayTextStyle': currentDayTextStyle,
        'selectedDayTextStyle': selectedDayTextStyle,
        'disabledDayTextStyle': disabledDayTextStyle,
        'changePageDuration': changePageDuration,
        'gregorianDaysTextStyle': gregorianDaysTextStyle,
        'gregorianDaysLocation': gregorianDaysLocation,
        'rangeFirstDaySelectedBackgroundColor':
            rangeFirstDaySelectedBackgroundColor,
        'rangeLastDaySelectedBackgroundColor':
            rangeLastDaySelectedBackgroundColor,
        'selectionGradientColor': selectionGradientColor,
        'minDatetime': minDatetime,
        'maxDatetime': maxDatetime,
        'maxSpan': maxSpan,
        'minSpan': minSpan,
        'dayBlockRadius': dayBlockRadius,
      };

      return PersianDatePickerWidget(options: options);
    }
  }
}

class PersianDatePickerWidget extends StatefulWidget {
  final Map<String, dynamic> options;

  PersianDatePickerWidget({
    this.options,
  });

  update(
      {Duration minSpan,
      Duration maxSpan,
      String minDatetime,
      String maxDatetime}) {
    if (minSpan != null && maxSpan != null && maxSpan < minSpan)
      throw 'max span must be greater than min span';

    this.options['minSpan'] = minSpan ?? this.options['minSpan'];
    this.options['maxSpan'] = maxSpan ?? this.options['maxSpan'];

    if (minDatetime != null) {
      this.options['minDatetime'] = minDatetime ?? this.options['minDatetime'];
    }
    if (maxDatetime != null) {
      this.options['maxDatetime'] = maxDatetime ?? this.options['maxDatetime'];
    }
  }

  @override
  _PersianDatePickerWidgetState createState() =>
      _PersianDatePickerWidgetState();
}

_parseDatetimeInput(datetime, format, separator) {
  try {
    List<String> inputParts = [];
    for (String item in datetime.split(separator)) {
      inputParts.add(item.trim());
    }

    List<String> formatParts = [];
    for (String item in format.split(separator)) {
      formatParts.add(item.trim());
    }

    List<String> dayFormats = ['DD', 'D'];
    List<String> monthFormats = ['MM', 'M'];
    List<String> yearFormats = ['YYYY', 'YY'];

    int day, month, year;

    for (int i = 0; i < formatParts.length; i++) {
      if (dayFormats.contains(formatParts[i])) {
        day = int.parse(inputParts[i]);
        continue;
      }
      if (monthFormats.contains(formatParts[i])) {
        month = int.parse(inputParts[i]);
        continue;
      }
      if (yearFormats.contains(formatParts[i])) {
        year = int.parse(inputParts[i]);
        continue;
      }
    }

    if (year != null && month != null && day != null) {
      return Jalaali(year, month, day);
    }
  } catch (e) {
    return Jalaali.now();
  }

  return Jalaali.now();
}

class _PersianDatePickerWidgetState extends State<PersianDatePickerWidget>
    with TickerProviderStateMixin {
  final Jalaali currentDate = Jalaali.now();
  final Jalaali startDate =
      Jalaali.fromDateTime(DateTime(1925, 3, 21)); // 1304/1/1
  final List<Map<String, dynamic>> pages = [];
  final List<int> months = [];
  final List<int> years = [];

  Jalaali inputSelectedDate;
  Jalaali rangeStartDate;
  Jalaali rangeFinishDate;

  double datePickerHeight;

  int selectedPageIndex;
  int todayPageIndex;

  int datePickerCurrentMonth = 1;
  int datePickerCurrentYear = 1;

  bool inputSelectedDateByUser;

  ScrollController displayYearsController;
  ScrollController displayMonthsController;
  PageController datePickerController;

  AnimationController yearAnimationController;
  AnimationController monthAnimationController;

  String controllerTextTmp;
  String oldText;

  bool yearMonthVisibility = false;

  DateTime standardMinDatetime;
  DateTime standardMaxDatetime;

  inputStringToJalaali() {
    controllerTextTmp = englishNumbers(widget.options['controller'].text);

    inputSelectedDate = Jalaali.now();
    inputSelectedDateByUser = false;

    Jalaali jalaaliMinDatetime, jalaaliMaxDatetime;
    if (widget.options['minDatetime'] != null) {
      jalaaliMinDatetime = _parseDatetimeInput(widget.options['minDatetime'],
          widget.options['defaultInputFormat'], "/");
      standardMinDatetime = jalaaliMinDatetime.toDateTime();
    }
    if (widget.options['maxDatetime'] != null) {
      jalaaliMaxDatetime = _parseDatetimeInput(widget.options['maxDatetime'],
          widget.options['defaultInputFormat'], "/");
      standardMaxDatetime = jalaaliMaxDatetime.toDateTime();
    }

    if (controllerTextTmp != null && controllerTextTmp.toString().isNotEmpty) {
      inputSelectedDateByUser = true;

      if (widget.options['rangeDatePicker'] == true) {
        List<String> datesList =
            controllerTextTmp.split(widget.options['rangeSeparator']);
        if (datesList.length == 2) {
          rangeStartDate = inputSelectedDate = _parseDatetimeInput(datesList[0],
              widget.options['outputFormat'], widget.options['separator']);
          rangeFinishDate = _parseDatetimeInput(datesList[1],
              widget.options['outputFormat'], widget.options['separator']);

          DateTime standardStartDatetime = rangeStartDate.toDateTime();
          DateTime standardFinishDatetime = rangeFinishDate.toDateTime();

          if (standardMinDatetime != null) {
            if (standardStartDatetime.isBefore(standardMinDatetime)) {
              rangeStartDate = jalaaliMinDatetime;
            }
            if (standardFinishDatetime.isBefore(standardMinDatetime)) {
              rangeFinishDate = jalaaliMinDatetime;
            }
          }
          if (standardMaxDatetime != null) {
            if (standardStartDatetime.isAfter(standardMaxDatetime)) {
              rangeStartDate = jalaaliMaxDatetime;
            }
            if (standardFinishDatetime.isAfter(standardMaxDatetime)) {
              rangeFinishDate = jalaaliMaxDatetime;
            }
          }
          if (standardFinishDatetime.isBefore(standardStartDatetime)) {
            rangeStartDate = jalaaliMinDatetime;
            rangeFinishDate = jalaaliMaxDatetime;
          }
        }
      } else {
        inputSelectedDate = _parseDatetimeInput(controllerTextTmp,
            widget.options['outputFormat'], widget.options['separator']);

        DateTime standardStartDatetime = inputSelectedDate.toDateTime();

        if (standardMinDatetime != null) {
          if (standardStartDatetime.isBefore(standardMinDatetime)) {
            inputSelectedDate = jalaaliMinDatetime;
          }
        }
        if (standardMaxDatetime != null) {
          if (standardStartDatetime.isAfter(standardMaxDatetime)) {
            inputSelectedDate = jalaaliMaxDatetime;
          }
        }
      }
    }
  }

  @override
  void initState() {
    datePickerHeight = widget.options['datePickerHeight'];

    // change TextField input to a jalaali data-type, if there is no input, then current date is used
    inputStringToJalaali();

// set current month and year of the datepicker to selected input string
    datePickerCurrentMonth = inputSelectedDate.month;
    datePickerCurrentYear = inputSelectedDate.year;

    // using this index to determine the position of first day of month in week. for example ( may be 1st day of next month is monday )
    int firstDayOfMonthIndex = 0;

    // this variable is used to jump or animate to pages by using their index
    int pageIndex = 0;

    // to store number of days of previous month ( this can help to understand the firstDayOfMonthIndex )
    // initialize is 0 because we don't have any previous month
    int previousMonthDays = 0;

    // loop through years and months and add them inside pages ==>  List<Map<String, dynamic>>
    for (int year = startDate.year; year <= (currentDate.year + 100); year++) {
      // adding year to years list to have length of years
      years.add(year);

      for (int month = 1; month <= 12; month++) {
        // adding month to months list to have length of months
        months.add(month);

        // check if year and month of loops is equal to user input date. if yes, we store this page index as selected page index
        if (year == inputSelectedDate.year && month == inputSelectedDate.month)
          selectedPageIndex = pageIndex;

        // check if year and month of loops is equal to current datetime. if yes, we store this page index as today page index
        if (year == currentDate.year && month == currentDate.month)
          todayPageIndex = pageIndex;

        // by using jalaali package, calculate the number of days of current month
        int shamsiDaysOfMonth = Jalaali(year, month).monthLength;

        // by adding (shamsiDaysOfMonth + firstDayOfMonthInWeek) and % it to 7 ( number of days in a week )
        // we can find out what is the position of current month's first day inside the week. ( sat, sun, mon, ... )
        // at first, firstDayOfMonthInWeek = 0 so the first day of week is the first day of current month
        // firstDayOfMonthInWeek = 0 is important, because the starting date is 1925, 3, 21 which the first day of month is saturday
        // in farsi calendar, Saturday ( شنبه ) is the first day of week
        int firstDayOfMonthInWeek = firstDayOfMonthIndex % 7;

        // add current page to pages list
        pages.add({
          'Y': year,
          'M': month,
          'DIM': shamsiDaysOfMonth, // Days In Month
          'FDIW': firstDayOfMonthInWeek, // First Day of Month In Week
          'PMDIM': previousMonthDays // Previous Month Days In Month
        });

        pageIndex++;

        // we set current month's days as previousMonthDays for the next loop to store it in the next page
        previousMonthDays = shamsiDaysOfMonth;

        // calculating first day of month for the next loop round
        firstDayOfMonthIndex = (shamsiDaysOfMonth + firstDayOfMonthInWeek) % 7;
      }
    }

    // the whole datepicker is a PageView and so we define a controller for it
    datePickerController = PageController(initialPage: selectedPageIndex);

    // year animation controller
    yearAnimationController = AnimationController(
        vsync: this,
        duration: widget.options['yearSelectionAnimationDuration']);

    // month animation controller
    monthAnimationController = AnimationController(
        vsync: this,
        duration: widget.options['monthSelectionAnimationDuration']);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
// in order to hide year and month little-dialogs when tapping anywhere on datepicker, we wrap our datepicker by a GestureDetector
    // and inside it's onTap reset both year and month animations
    return GestureDetector(
      onTap: () {
        yearAnimationController.reset();
        monthAnimationController.reset();
        setState(() {
          yearMonthVisibility = false;
        });
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          height: datePickerHeight,
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: PageView.builder(
                        onPageChanged: (index) {
                          // if page is changed, swiped, we change datepicker current month and year and chaning datepicker state
                          Map<String, dynamic> pageInfo = pages[index];
                          datePickerCurrentMonth = pageInfo['M'];
                          datePickerCurrentYear = pageInfo['Y'];
                          setState(() {});
                        },
                        controller: datePickerController,

                        // the number of pages
                        itemCount: pages.length,

                        // building pages
                        itemBuilder: (BuildContext context, int index) {
                          // getting page info from pages list by it's index
                          Map<String, dynamic> pageInfo = pages[index];

                          // store the parts of page inside a list of widgets
                          List<Widget> datePicker = [];

                          // in most cases the number of rows of days for each page is 7
                          // but in some cases, if the starting day of current month is ( thu, fri )
                          // the number of rows may be 8. so we check it here
                          int viewPortDays = 35;
                          if ((pageInfo['DIM'] + pageInfo['FDIW']) > 35) {
                            viewPortDays = 42;
                          }

                          // rendering days row by row.
                          // first row starts by 0 index
                          int previousRowDayNumber = 0;
                          for (int row = 1; row <= (viewPortDays / 7); row++) {
                            List<Widget> rowWidgets = [];

                            // if it is first row, then we need to display headers before days rows above current row of days,
                            // and also display previous month days before current month starting day
                            if (row == 1) {
                              datePicker.addAll([
                                _datePickerPageHeader(pageInfo),
                                _datePickerPageWeekCaptions(),
                              ]);

                              // displaying previous month days
                              for (int daysBefore = (pageInfo['PMDIM'] -
                                      pageInfo['FDIW'] +
                                      1);
                                  daysBefore <= pageInfo['PMDIM'];
                                  daysBefore++) {
                                rowWidgets.add(_dayBlock(
                                    day: daysBefore,
                                    otherMonthDay: true,
                                    pageInfo: pageInfo));
                              }

                              // displaying current month days in this row
                              for (int firstRowDays = 1;
                                  firstRowDays <= (7 - pageInfo['FDIW']);
                                  firstRowDays++) {
                                rowWidgets.add(_dayBlock(
                                    day: firstRowDays, pageInfo: pageInfo));
                              }

                              previousRowDayNumber = (7 - pageInfo['FDIW']);

// if this row is the last row
                            } else if (row == (viewPortDays / 7)) {
                              // display days of current row
                              for (int lastRowDays = previousRowDayNumber + 1;
                                  lastRowDays <= pageInfo['DIM'];
                                  lastRowDays++) {
                                rowWidgets.add(_dayBlock(
                                    day: lastRowDays, pageInfo: pageInfo));
                              }

                              // display days of next month right after the last day of current month
                              for (int daysAfter = viewPortDays;
                                  daysAfter >
                                      (pageInfo['DIM'] + pageInfo['FDIW']);
                                  daysAfter--) {
                                rowWidgets.add(_dayBlock(
                                    day: viewPortDays - daysAfter + 1,
                                    otherMonthDay: true,
                                    pageInfo: pageInfo));
                              }

                              // if this row is not first and last...
                            } else {
                              // displaying days of current row
                              for (int dayRow = previousRowDayNumber + 1;
                                  dayRow <= (previousRowDayNumber + 7);
                                  dayRow++) {
                                rowWidgets.add(
                                    _dayBlock(day: dayRow, pageInfo: pageInfo));
                              }

                              previousRowDayNumber += 7;
                            }

                            double rowMargin = 0;
                            if (widget.options['dayBlockRadius'] != null)
                              rowMargin = 1;

                            datePicker.add(Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.only(bottom: rowMargin),
                                child: Row(
                                  children: rowWidgets,
                                ),
                              ),
                            ));
                          }

                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            children: datePicker
                              ..add(Container(
                                margin: EdgeInsets.only(bottom: 3),
                              )),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),

              // years dialog widget
              positionedYMSelection(),
            ],
          ),
        ),
      ),
    );
  }

  // this function displays each day as a block or cell
  Widget _dayBlock({int day, bool otherMonthDay = false, pageInfo}) {
    Color color = widget.options['daysBackgroundColor'];
    TextStyle dayTextStyle = widget.options['daysTextStyle'];
    Jalaali dayBlockDateTime =
        Jalaali(datePickerCurrentYear, datePickerCurrentMonth, day);
    Border dayBorder = Border.all(
        color: widget.options['daysBorderColor'],
        width: widget.options['daysBorderWidth']);

    BorderRadius borderRadius;
    if (widget.options['dayBlockRadius'] != null) {
      borderRadius = BorderRadius.circular(widget.options['dayBlockRadius']);
    }

    DateTime standardDayBlockDatetime = dayBlockDateTime.toDateTime();

    // if datepicker type is range and starting day is selected, then all previous days should be disabled
    bool disabledDay = false;
    if (rangeStartDate != null && rangeFinishDate == null) {
      DateTime standardRangeStartDatetime = rangeStartDate.toDateTime();
      if (standardDayBlockDatetime.isBefore(standardRangeStartDatetime)) {
        disabledDay = true;
      }

      if (!disabledDay && widget.options['maxSpan'] != null) {
        int differenceOfRangeStartDatetimeAndDayBlock = standardDayBlockDatetime
            .difference(standardRangeStartDatetime)
            .inDays;
        if (differenceOfRangeStartDatetimeAndDayBlock >
            widget.options['maxSpan'].inDays) disabledDay = true;
      }
      if (!disabledDay && widget.options['minSpan'] != null) {
        int differenceOfRangeStartDatetimeAndDayBlock = standardDayBlockDatetime
            .difference(standardRangeStartDatetime)
            .inDays;
        if (differenceOfRangeStartDatetimeAndDayBlock <=
            widget.options['minSpan'].inDays) disabledDay = true;
      }

      if (day == rangeStartDate.day &&
          datePickerCurrentMonth == rangeStartDate.month &&
          datePickerCurrentYear == rangeStartDate.year &&
          otherMonthDay == false) {
        BorderSide bs = BorderSide(
            color: widget.options['selectedDayBorderColor'],
            width: widget.options['daysBorderWidth']);

        if (widget.options['dayBlockRadius'] == null) {
          dayBorder = Border(top: bs, right: bs, bottom: bs);
        } else {
          dayBorder = Border.all(
              color: widget.options['selectedDayBorderColor'],
              width: widget.options['daysBorderWidth']);
        }

        color = widget.options['selectedDayBackgroundColor'];
      }
    }

    if (!disabledDay) {
      if (((standardMinDatetime) != null &&
              standardDayBlockDatetime.isBefore(standardMinDatetime)) ||
          ((standardMaxDatetime) != null &&
              standardDayBlockDatetime.isAfter(standardMaxDatetime))) {
        disabledDay = true;
      }
    }

    // if current day is not a day of current month ( it belongs to previous or next month ) then it should be disabled
    if (otherMonthDay == true || disabledDay == true) {
      color = widget.options['disabledDayBackgroundColor'];
      dayTextStyle = widget.options['disabledDayTextStyle'];
    } else {
      // if current day is belongs to current month and equals to current date , then change color and font to current date
      if (currentDate.day == day &&
          currentDate.month == datePickerCurrentMonth &&
          currentDate.year == datePickerCurrentYear) {
        color = widget.options['currentDayBackgroundColor'];
        dayTextStyle = widget.options['currentDayTextStyle'];
        dayBorder = Border.all(
            color: widget.options['currentDayBorderColor'],
            width: widget.options['daysBorderWidth']);
      }

      // if current day is belongs to current month and equals to selected date , then change color and font to selected date
      if (day == inputSelectedDate.day &&
          datePickerCurrentMonth == inputSelectedDate.month &&
          datePickerCurrentYear == inputSelectedDate.year &&
          inputSelectedDateByUser == true) {
        color = widget.options['selectedDayBackgroundColor'];
        dayTextStyle = widget.options['selectedDayTextStyle'];

        dayBorder = Border.all(
            color: widget.options['selectedDayBorderColor'],
            width: widget.options['daysBorderWidth']);
      }

      // if current day is belongs to current month and is inside the selected range , then change color and font to selected date
      if ((rangeStartDate != null && rangeFinishDate != null)) {
        DateTime dayBlockGregorianDateTime = standardDayBlockDatetime;

        if (dayBlockGregorianDateTime.compareTo(rangeStartDate.toDateTime()) >=
                0 &&
            dayBlockGregorianDateTime.compareTo(rangeFinishDate.toDateTime()) <=
                0) {
          color = widget.options['selectedDayBackgroundColor'];
          dayTextStyle = widget.options['selectedDayTextStyle'];
          if (widget.options['dayBlockRadius'] == null) {
            DateTime neighbourDay;
            BorderSide borderTop = BorderSide(
                color: widget.options['selectedDaysInnerBorderColor'],
                width: widget.options['daysBorderWidth']);
            BorderSide borderRight = BorderSide(
                color: widget.options['selectedDaysInnerBorderColor'],
                width: widget.options['daysBorderWidth']);
            BorderSide borderLeft = BorderSide(
                color: widget.options['selectedDaysInnerBorderColor'],
                width: widget.options['daysBorderWidth']);
            BorderSide borderBottom = BorderSide(
                color: widget.options['selectedDaysInnerBorderColor'],
                width: widget.options['daysBorderWidth']);
//          BorderSide borderTop = BorderSide(color: widget.options['daysBorderColor'], width: widget.options['daysBorderWidth']);
//          BorderSide borderTop = BorderSide(color: widget.options['daysBorderColor'], width: widget.options['daysBorderWidth']);

            /*Border Top*/
            neighbourDay =
                dayBlockGregorianDateTime.subtract(Duration(days: 7));
            if (neighbourDay.compareTo(rangeStartDate.toDateTime()) < 0 ||
                neighbourDay.compareTo(rangeFinishDate.toDateTime()) > 0) {
              borderTop = BorderSide(
                  color: widget.options['selectedDayBorderColor'],
                  width: widget.options['daysBorderWidth']);
            }

            /*Border Right*/
            neighbourDay =
                dayBlockGregorianDateTime.subtract(Duration(days: 1));
            if (neighbourDay.compareTo(rangeStartDate.toDateTime()) < 0 ||
                neighbourDay.compareTo(rangeFinishDate.toDateTime()) > 0) {
              borderRight = BorderSide(
                  color: widget.options['selectedDayBorderColor'],
                  width: widget.options['daysBorderWidth']);
              color = widget.options['rangeFirstDaySelectedBackgroundColor'];
            }

            /*Border Left*/
            neighbourDay = dayBlockGregorianDateTime.add(Duration(days: 1));
            if (neighbourDay.compareTo(rangeStartDate.toDateTime()) < 0 ||
                neighbourDay.compareTo(rangeFinishDate.toDateTime()) > 0) {
              borderLeft = BorderSide(
                  color: widget.options['selectedDayBorderColor'],
                  width: widget.options['daysBorderWidth']);
              color = widget.options['rangeLastDaySelectedBackgroundColor'];
            }

            /*Border Bottom*/
            neighbourDay = dayBlockGregorianDateTime.add(Duration(days: 7));
            if (neighbourDay.compareTo(rangeStartDate.toDateTime()) < 0 ||
                neighbourDay.compareTo(rangeFinishDate.toDateTime()) > 0) {
              borderBottom = BorderSide(
                  color: widget.options['selectedDayBorderColor'],
                  width: widget.options['daysBorderWidth']);
            }

            dayBorder = Border(
                top: borderTop,
                right: borderRight,
                left: borderLeft,
                bottom: borderBottom);
          } else {
            DateTime neighbourDay;

            bool rightCornersRounded = false;
            bool leftCornersRounded = false;
            neighbourDay =
                dayBlockGregorianDateTime.subtract(Duration(days: 1));

            if (neighbourDay.compareTo(rangeStartDate.toDateTime()) < 0) {
              borderRadius = BorderRadius.only(
                  topRight: Radius.circular(widget.options['dayBlockRadius']),
                  bottomRight:
                      Radius.circular(widget.options['dayBlockRadius']));
              rightCornersRounded = true;
            }

            neighbourDay = dayBlockGregorianDateTime.add(Duration(days: 1));
            if (neighbourDay.compareTo(rangeFinishDate.toDateTime()) > 0) {
              borderRadius = BorderRadius.only(
                  topLeft: Radius.circular(widget.options['dayBlockRadius']),
                  bottomLeft:
                      Radius.circular(widget.options['dayBlockRadius']));
              leftCornersRounded = true;
            }

            if (!rightCornersRounded && !leftCornersRounded) {
              borderRadius = null;
            }

            dayBorder = Border.all(
                color: widget.options['selectedDayBorderColor'],
                width: widget.options['daysBorderWidth']);
          }
        }
      }
    }

    Widget gregorianDay = Container();
    if (widget.options['showGregorianDays'] == true && otherMonthDay == false) {
      gregorianDay = Container(
        padding: EdgeInsets.all(1),
        child: Text(
          dayBlockDateTime.toDateTime().day.toString(),
          style: widget.options['gregorianDaysTextStyle'],
        ),
      );
    }
    Positioned gregorianDaysPositioned = Positioned(child: gregorianDay);

    if (widget.options['dayBlockRadius'] == null) {
      switch (widget.options['gregorianDaysLocation']) {
        case GregorianDaysLocation.topLeft:
          gregorianDaysPositioned =
              Positioned(left: 2, top: 2, child: gregorianDay);
          break;
        case GregorianDaysLocation.topRight:
          gregorianDaysPositioned =
              Positioned(right: 2, top: 2, child: gregorianDay);
          break;
        case GregorianDaysLocation.bottomLeft:
          gregorianDaysPositioned =
              Positioned(left: 2, bottom: 2, child: gregorianDay);
          break;
        case GregorianDaysLocation.bottomRight:
          gregorianDaysPositioned =
              Positioned(right: 2, bottom: 2, child: gregorianDay);
          break;
      }
    } else {
      gregorianDaysPositioned = Positioned(
          right: 0, left: 0, bottom: 1, child: Center(child: gregorianDay));
    }

    return Expanded(
      child: Material(
        child: InkWell(
          onTap: () {
            if (otherMonthDay == false && disabledDay == false) {
              // by tapping on any day, both year and month dialogs should disappear and their animations should reset
              yearAnimationController.reset();
              monthAnimationController.reset();
              setState(() {
                yearMonthVisibility = false;
              });

              if (widget.options['rangeDatePicker'] == true) {
                // if start date is selected, then waiting for finish date selection and clearing input to display new selection
                if (rangeStartDate == null ||
                    (rangeStartDate != null && rangeFinishDate != null)) {
                  rangeStartDate = Jalaali(pageInfo['Y'], pageInfo['M'], day);
                  rangeFinishDate = null;

                  oldText = widget.options['controller'].text;

                  widget.options['controller'].text = '';
                } else {
                  rangeFinishDate = Jalaali(pageInfo['Y'], pageInfo['M'], day);

                  if (rangeStartDate
                          .toDateTime()
                          .compareTo(rangeFinishDate.toDateTime()) <=
                      0) {
                    widget.options['controller'].text = translate(
                            widget.options['outputFormat'],
                            rangeStartDate,
                            widget.options['farsiDigits']) +
                        widget.options['rangeSeparator'] +
                        translate(widget.options['outputFormat'],
                            rangeFinishDate, widget.options['farsiDigits']);
                  } else {
                    widget.options['controller'].text = '';
                  }

                  // after selecting both start and finish,
                  // we update TextField text and then
                  // we set both start and finish to null so user can select another range
                  rangeStartDate = null;
                  rangeFinishDate = null;
                }
              } else {
                oldText = widget.options['controller'].text;

                Jalaali jd = Jalaali(pageInfo['Y'], pageInfo['M'], day);
                widget.options['controller'].text = translate(
                    widget.options['outputFormat'],
                    jd,
                    widget.options['farsiDigits']);
              }

              // after updating input by selected date, we convert the selected date to jalaali date
              inputStringToJalaali();

              if (widget.options['rangeDatePicker'] == false ||
                  (widget.options['rangeDatePicker'] == true &&
                          rangeStartDate != null &&
                          rangeFinishDate != null) &&
                      widget.options['onChange'] != null) {
                widget.options['onChange'](
                    oldText, widget.options['controller'].text);
              }

              setState(() {});
            }
          },
          child: Stack(children: <Widget>[
            Container(
//            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                  color: color, border: dayBorder, borderRadius: borderRadius),
              child: Center(
                child: Text(
                  widget.options['farsiDigits'] == true
                      ? farsiNumbers(day.toString())
                      : day.toString(),
                  style: dayTextStyle,
                ),
              ),
            ),
            gregorianDaysPositioned,
          ]),
        ),
      ),
    );
  }

  Widget _datePickerPageHeader(pageInfo) {
    Jalaali datetime = Jalaali(pageInfo['Y'], pageInfo['M'], 1);

    return Container(
        color: widget.options['headerBackgroundColor'],
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        yearMonthVisibility = false;
                      });
                      yearAnimationController.reset();
                      if (monthAnimationController.isDismissed) {
                        setState(() {
                          yearMonthVisibility = true;
                        });
                        monthAnimationController.forward();
                      } else
                        monthAnimationController.reverse();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Icon(
                              Icons.expand_more,
                              size: widget.options['headerTextStyle'].fontSize,
                              color: widget.options['headerTextStyle'].color,
                            ),
                          ),
                          SizedBox(width: 4),
                          Container(
                            child: Text(
                              translate('MMM', datetime, false),
                              style: widget.options['headerTextStyle'],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          yearMonthVisibility = false;
                        });
                        monthAnimationController.reset();
                        if (yearAnimationController.isDismissed) {
                          setState(() {
                            yearMonthVisibility = true;
                          });
                          yearAnimationController.forward();
                        } else
                          yearAnimationController.reverse();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Text(
                                  widget.options['farsiDigits'] == true
                                      ? farsiNumbers(datetime.year.toString())
                                      : datetime.year.toString(),
                                  style: widget.options['headerTextStyle']),
                            ),
                            SizedBox(width: 8),
                            Container(
                              margin: EdgeInsets.only(top: 1),
                              child: Icon(
                                Icons.expand_more,
                                size:
                                    widget.options['headerTextStyle'].fontSize,
                                color: widget.options['headerTextStyle'].color,
                              ),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  datePickerController.animateToPage(todayPageIndex,
                      duration: widget.options['changePageDuration'],
                      curve: Curves.easeIn);
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      widget.options['headerTodayIcon'],
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 3),
                          child: Text(widget.options['headerTodayCaption'],
                              style: widget.options['headerTodayTextStyle']))
                    ],
                  ),
                  color: widget.options['headerTodayBackgroundColor'],
                ),
              ),
            )
          ],
        ));
  }

  Widget _datePickerPageWeekCaptions() {
    return Container(
      margin: EdgeInsets.only(bottom: 2),
      child: Row(
        children: <Widget>[
          _weekDayCaption(widget.options['weekCaptions'][0]),
          _weekDayCaption(widget.options['weekCaptions'][1]),
          _weekDayCaption(widget.options['weekCaptions'][2]),
          _weekDayCaption(widget.options['weekCaptions'][3]),
          _weekDayCaption(widget.options['weekCaptions'][4]),
          _weekDayCaption(widget.options['weekCaptions'][5]),
          _weekDayCaption(widget.options['weekCaptions'][6]),
        ],
      ),
    );
  }

  Widget _weekDayCaption(String title) {
    return Expanded(
      child: Container(
          padding: EdgeInsets.all(6),
          color: widget.options['weekCaptionsBackgroundColor'],
          child: Center(
              child: Text(
            title,
            style: widget.options['weekCaptionsTextStyle'],
          ))),
    );
  }

  Widget displayYears() {
    double itemHeight = 50;

    int selectedYearIndex = years.indexOf(datePickerCurrentYear);
    displayYearsController = ScrollController(
        initialScrollOffset: (selectedYearIndex * itemHeight).toDouble());

    return ListView.builder(
        scrollDirection: Axis.vertical,
        controller: displayYearsController,
        itemCount: years.length,
        itemBuilder: (BuildContext context, int index) {
          Jalaali datetime = Jalaali(years[index], datePickerCurrentMonth, 1);

          Color bgColor = widget.options['yearSelectionBackgroundColor'];
          TextStyle textStyle = widget.options['yearSelectionTextStyle'];
          if (years[index] == datePickerCurrentYear) {
            bgColor = widget.options['yearSelectionHighlightBackgroundColor'];
            textStyle = widget.options['yearSelectionHighlightTextStyle'];
          }

          return GestureDetector(
            onTap: () {
              datePickerCurrentYear = years[index];
              yearMonthVisibility = false;

              setState(() {});
              datePickerController.animateToPage(
                  (datePickerCurrentYear - startDate.year) * 12 +
                      datePickerCurrentMonth -
                      1,
                  duration: widget.options['changePageDuration'],
                  curve: Curves.easeOut);
              yearAnimationController.reset();
            },
            child: Container(
              height: itemHeight,
              padding: EdgeInsets.only(top: 2),
              decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.black12)),
                  color: bgColor),
//            margin: EdgeInsets.symmetric(vertical: 2.0),
              child: Stack(
                children: <Widget>[
                  Positioned(
                      top: 8,
                      right: 0,
                      left: 0,
                      child: Center(
                          child: Text(
                        widget.options['farsiDigits'] == true
                            ? farsiNumbers(years[index].toString())
                            : years[index].toString(),
                        style: textStyle,
                      ))),
                  Positioned(
                    bottom: 2,
                    right: 0,
                    left: 0,
                    child: Center(
                        child: Text(
                      datetime.toDateTime().year.toString(),
                      style: TextStyle(color: Colors.black38, fontSize: 10),
                    )),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget displayMonths() {
    double itemHeight = 50;

    int selectedMonthIndex = months.indexOf(datePickerCurrentMonth);
    displayMonthsController = ScrollController(
        initialScrollOffset: (selectedMonthIndex * itemHeight).toDouble());

    return ListView.builder(
        scrollDirection: Axis.vertical,
        controller: displayMonthsController,
        itemCount: 12,
        itemBuilder: (BuildContext context, int index) {
          Jalaali datetime = Jalaali(inputSelectedDate.year, index + 1, 1);

          Color bgColor = widget.options['monthSelectionBackgroundColor'];
          TextStyle textStyle = widget.options['monthSelectionTextStyle'];
          if (index + 1 == datePickerCurrentMonth) {
            bgColor = widget.options['monthSelectionHighlightBackgroundColor'];
            textStyle = widget.options['monthSelectionHighlightTextStyle'];
          }

          return GestureDetector(
            onTap: () {
              datePickerCurrentMonth = index + 1;
              yearMonthVisibility = false;
              setState(() {});
              datePickerController.animateToPage(
                  (datePickerCurrentYear - startDate.year) * 12 + index,
                  duration: widget.options['changePageDuration'],
                  curve: Curves.easeOut);
              monthAnimationController.reset();
            },
            child: Container(
              height: itemHeight,
              padding: EdgeInsets.only(top: 2),
              decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.black12)),
                  color: bgColor),
              child: Stack(
                children: <Widget>[
                  Positioned(
                      top: 8,
                      right: 0,
                      left: 0,
                      child: Center(
                          child: Text(
                        translate('MMM', datetime, false),
                        style: textStyle,
                      ))),
                  Positioned(
                    bottom: 2,
                    right: 0,
                    left: 0,
                    child: Center(
                        child: Text(
                      getGregorianMonthName(datetime.toDateTime().month),
                      style: TextStyle(color: Colors.black38, fontSize: 9),
                    )),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget positionedYMSelection() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      child: Visibility(
        visible: yearMonthVisibility,
        child: Container(
          color: Colors.white30,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: IgnorePointer(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: widget.options['datePickerHeight'] / 2.8,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              widget.options['selectionGradientColor'],
                              Colors.transparent,
                            ],
                            stops: [0, 1],
                          ),
//                                    border: Border(bottom: BorderSide(color: Colors.black12, width: 2)),
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                bottom: 0,
                right: 0,
                child: IgnorePointer(
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              widget.options['selectionGradientColor'],
                              Colors.transparent,
                            ],
                            stops: [0.0, 1.0],
                          ),
//                                    border: Border(top: BorderSide(color: Colors.black12, width: 2)),
                          color: Colors.blue,
                        ),
                        height: widget.options['datePickerHeight'] / 2.8,
                      )
                    ],
                  ),
                ),
              ),
              ScaleTransition(
                scale: CurvedAnimation(
                    parent: yearAnimationController,
                    curve: Interval(0.0, 1.0,
                        curve: widget.options['yearSelectionAnimationCurve'])),
                child: Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 25),
//                        height: 200,
                    width: 100,
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        spreadRadius: 1,
                      )
                    ]),
                    child: displayYears(),
                  ),
                ),
              ),
              ScaleTransition(
                scale: CurvedAnimation(
                    parent: monthAnimationController,
                    curve: Interval(0.0, 1.0,
                        curve: widget.options['monthSelectionAnimationCurve'])),
                child: Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 25),
                    width: 100,
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        spreadRadius: 1,
                      )
                    ]),
                    child: displayMonths(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
