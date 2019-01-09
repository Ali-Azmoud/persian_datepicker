import 'package:flutter/material.dart';
import 'package:jalaali/jalaali.dart';
import 'package:jalaali/shamsi.dart';
import 'package:jalaali/translator.dart';
import 'package:jalaali/shared.dart';

class PersianDatePicker extends StatefulWidget {
  final bool rangeSelector;
  final TextEditingController controller;

  final int yearSelectionAnimationDuration;
  final Curve yearSelectionAnimationCurve;
  final int monthSelectionAnimationDuration;
  final Curve monthSelectionAnimationCurve;
  final String headerTodayCaption;
  final Icon headerTodayIcon;
  final Color yearSelectionBackgroundColor;
  final Color yearSelectionFontColor;
  final Color yearSelectionHighlightBackgroundColor;
  final Color yearSelectionHighlightFontColor;
  final Color monthSelectionBackgroundColor;
  final Color monthSelectionFontColor;
  final Color monthSelectionHighlightBackgroundColor;
  final Color monthSelectionHighlightFontColor;
  final Color weekCaptionsBackgroundColor;
  final Color weekCaptionsFontColor;
  final Color headerBackgroundColor;
  final Color headerFontColor;
  final Color daysBackgroundColor;
  final Color daysFontColor;
  final Color currentDayBackgroundColor;
  final Color currentDayFontColor;
  final Color selectedDayBackgroundColor;
  final Color selectedDayFontColor;
  final Color headerTodayBackgroundColor;
  final Color disabledDayBackgroundColor;
  final Color disabledDayFontColor;

  PersianDatePicker({
    this.yearSelectionAnimationDuration,
    this.yearSelectionAnimationCurve,
    this.yearSelectionHighlightBackgroundColor,
    this.yearSelectionHighlightFontColor,
    this.monthSelectionAnimationDuration,
    this.monthSelectionAnimationCurve,
    this.monthSelectionHighlightBackgroundColor,
    this.monthSelectionHighlightFontColor,
    this.yearSelectionBackgroundColor,
    this.yearSelectionFontColor,
    this.monthSelectionBackgroundColor,
    this.monthSelectionFontColor,
    this.weekCaptionsBackgroundColor,
    this.weekCaptionsFontColor,
    this.headerBackgroundColor,
    this.headerFontColor,
    this.daysBackgroundColor,
    this.daysFontColor,
    this.currentDayBackgroundColor,
    this.currentDayFontColor,
    this.selectedDayBackgroundColor,
    this.selectedDayFontColor,
    this.headerTodayBackgroundColor,
    this.disabledDayBackgroundColor,
    this.disabledDayFontColor,
    this.controller,
    this.rangeSelector: false,
    this.headerTodayCaption,
    this.headerTodayIcon
  });

  @override
  _PersianDatePickerState createState() => _PersianDatePickerState();
}

class _PersianDatePickerState extends State<PersianDatePicker>
    with TickerProviderStateMixin {

  int _yearSelectionAnimationDuration;
  Curve _yearSelectionAnimationCurve;
  int _monthSelectionAnimationDuration;
  Curve _monthSelectionAnimationCurve;
  Color _yearSelectionBackgroundColor;
  Color _yearSelectionFontColor;
  Color _yearSelectionHighlightBackgroundColor;
  Color _yearSelectionHighlightFontColor;
  Color _monthSelectionBackgroundColor;
  Color _monthSelectionFontColor;
  Color _monthSelectionHighlightBackgroundColor;
  Color _monthSelectionHighlightFontColor;
  Color _weekCaptionsBackgroundColor;
  Color _weekCaptionsFontColor;
  Color _headerBackgroundColor;
  Color _headerFontColor;
  Color _daysBackgroundColor;
  Color _daysFontColor;
  Color _currentDayBackgroundColor;
  Color _currentDayFontColor;
  Color _selectedDayBackgroundColor;
  Color _selectedDayFontColor;
  Color _headerTodayBackgroundColor;
  Color _disabledDayBackgroundColor;
  Color _disabledDayFontColor;
  String _headerTodayCaption;
  Icon _headerTodayIcon;



  final JalaaliDate currentDate = JalaaliDate.now();
  final JalaaliDate startDate =
  JalaaliDate.fromDateTime(DateTime(1925, 3, 21)); // 1320/1/1
  final List<Map<String, dynamic>> pages = [];
  final List<int> months = [];
  final List<int> years = [];

  JalaaliDate inputSelectedDate;
  JalaaliDate rangeStartDate;
  JalaaliDate rangeFinishDate;

  double bottomSheetHeight = 325;
  int selectedPageIndex;
  int todayPageIndex;

  int datePickerCurrentMonth = 1;
  int datePickerCurrentYear = 1;

  ScrollController displayYearsController;
  ScrollController displayMonthsController;
  PageController datePickerController;

  AnimationController yearAnimationController;
  AnimationController monthAnimationController;

  inputStringToJalaali() {
    if (widget.controller.text != null &&
        widget.controller.text.toString().isNotEmpty) {

      if(widget.rangeSelector == true){
        List<String> datesList = widget.controller.text.toString().split(" - ");
        if(datesList.length == 2) {

          List<String> startDate = datesList[0].split("/");
          rangeStartDate = inputSelectedDate = JalaaliDate(
              int.parse(startDate[0]), int.parse(startDate[1]), int.parse(startDate[2]));

          List<String> finishDate = datesList[1].split("/");
          rangeFinishDate = JalaaliDate(
              int.parse(finishDate[0]), int.parse(finishDate[1]), int.parse(finishDate[2]));
        }
      } else {
        List<String> sdl = widget.controller.text.toString().split("/");
        inputSelectedDate = JalaaliDate(
            int.parse(sdl[0]), int.parse(sdl[1]), int.parse(sdl[2]));
      }
    } else {
      inputSelectedDate = JalaaliDate.now();
    }
  }

  void initializeParams() {
    _yearSelectionAnimationDuration = ( widget.yearSelectionAnimationDuration != null ) ? widget.yearSelectionAnimationDuration : 400;
    _yearSelectionAnimationCurve = ( widget.yearSelectionAnimationCurve != null ) ? widget.yearSelectionAnimationCurve : Curves.elasticOut;
    _monthSelectionAnimationDuration = ( widget.monthSelectionAnimationDuration != null ) ? widget.monthSelectionAnimationDuration : 400;
    _monthSelectionAnimationCurve = ( widget.monthSelectionAnimationCurve != null ) ? widget.monthSelectionAnimationCurve : Curves.elasticOut;
    _yearSelectionBackgroundColor = ( widget.yearSelectionBackgroundColor != null ) ? widget.yearSelectionBackgroundColor : Colors.white;
    _yearSelectionFontColor = ( widget.yearSelectionFontColor != null ) ? widget.yearSelectionFontColor : Colors.black;
    _yearSelectionHighlightBackgroundColor = ( widget.yearSelectionHighlightBackgroundColor != null ) ? widget.yearSelectionHighlightBackgroundColor : Colors.orange[100];
    _yearSelectionHighlightFontColor = ( widget.yearSelectionHighlightFontColor != null ) ? widget.yearSelectionHighlightFontColor : Colors.white;
    _monthSelectionBackgroundColor = ( widget.monthSelectionBackgroundColor != null ) ? widget.monthSelectionBackgroundColor : Colors.blue;
    _monthSelectionFontColor = ( widget.monthSelectionFontColor != null ) ? widget.monthSelectionFontColor : Colors.black;
    _monthSelectionHighlightBackgroundColor = ( widget.monthSelectionHighlightBackgroundColor != null ) ? widget.monthSelectionHighlightBackgroundColor : Colors.orange[100];
    _monthSelectionHighlightFontColor = ( widget.monthSelectionHighlightFontColor != null ) ? widget.monthSelectionHighlightFontColor : Colors.white;
    _weekCaptionsBackgroundColor = ( widget.weekCaptionsBackgroundColor != null ) ? widget.weekCaptionsBackgroundColor : Colors.blue;
    _weekCaptionsFontColor = ( widget.weekCaptionsFontColor != null ) ? widget.weekCaptionsFontColor : Colors.white;
    _headerBackgroundColor = ( widget.headerBackgroundColor != null ) ? widget.headerBackgroundColor : Colors.white;
    _headerFontColor = ( widget.headerFontColor != null ) ? widget.headerFontColor : Colors.black;
    _daysBackgroundColor = ( widget.daysBackgroundColor != null ) ? widget.daysBackgroundColor : Colors.transparent;
    _daysFontColor = ( widget.daysFontColor != null ) ? widget.daysFontColor : Colors.black87;
    _currentDayBackgroundColor = ( widget.currentDayBackgroundColor != null ) ? widget.currentDayBackgroundColor : Colors.lightGreen.withOpacity(0.15);
    _currentDayFontColor = ( widget.currentDayFontColor != null ) ? widget.currentDayFontColor : Colors.black;
    _selectedDayBackgroundColor = ( widget.selectedDayBackgroundColor != null ) ? widget.selectedDayBackgroundColor : Colors.lightBlueAccent.withOpacity(0.15);;
    _selectedDayFontColor = ( widget.selectedDayFontColor != null ) ? widget.selectedDayFontColor : Colors.black87;
    _headerTodayBackgroundColor = ( widget.headerTodayBackgroundColor != null ) ? widget.headerTodayBackgroundColor : Colors.brown.withOpacity(0.1);
    _disabledDayBackgroundColor = ( widget.disabledDayBackgroundColor != null ) ? widget.disabledDayBackgroundColor : Colors.black.withOpacity(.03);
    _disabledDayFontColor = ( widget.disabledDayFontColor != null ) ? widget.disabledDayFontColor : Colors.black.withOpacity(.35);
    _headerTodayIcon = ( widget.headerTodayIcon != null ) ? widget.headerTodayIcon : Icon(Icons.date_range, color: Colors.green,);
    _headerTodayCaption = ( widget.headerTodayCaption != null ) ? widget.headerTodayCaption : 'امروز';
  }



  @override
  void initState() {

    initializeParams();

    inputStringToJalaali();



    datePickerCurrentMonth = inputSelectedDate.month;
    datePickerCurrentYear = inputSelectedDate.year;
//    inputSelectedDate = widget.selectedDate != null ? widget.selectedDate : JalaaliDate.now();

    int firstDayOfMonthIndex = 0;
    int pageIndex = 0;
    int otherMonthDays = 0;

    for (int year = startDate.year; year <= (currentDate.year + 100); year++) {
      years.add(year);

      for (int month = 1; month <= 12; month++) {
        months.add(month);

        if (year == inputSelectedDate.year && month == inputSelectedDate.month)
          selectedPageIndex = pageIndex;

        if (year == currentDate.year && month == currentDate.month)
          todayPageIndex = pageIndex;

        int shamsiDaysOfMonth = shamsiDaysInMonth(month, year);
        int firstDayOfMonthInWeek = firstDayOfMonthIndex % 7;

        pages.add({
          'Y': year,
          'M': month,
          'DIM': shamsiDaysOfMonth, // Days In Month
          'FDIW': firstDayOfMonthInWeek,
          'PMDIM': otherMonthDays // Previous Month Days In Month
        });

        pageIndex++;
        otherMonthDays = shamsiDaysOfMonth;

        firstDayOfMonthIndex = (shamsiDaysOfMonth + firstDayOfMonthInWeek) % 7;
      }
    }

    datePickerController = PageController(initialPage: selectedPageIndex);

    yearAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: _yearSelectionAnimationDuration));
    monthAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: _monthSelectionAnimationDuration));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        yearAnimationController.reset();
        monthAnimationController.reset();
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          height: bottomSheetHeight,
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: PageView.builder(
                        onPageChanged: (index) {
                          Map<String, dynamic> pageInfo = pages[index];
                          datePickerCurrentMonth = pageInfo['M'];
                          datePickerCurrentYear = pageInfo['Y'];
                          setState(() {});
                        },
                        controller: datePickerController,
                        itemCount: pages.length,
                        itemBuilder: (BuildContext context, int index) {
                          Map<String, dynamic> pageInfo = pages[index];

//                        print(pageInfo);
//                        print(index);

                          List<Widget> datePicker = [];

                          int viewPortDays = 35;
                          if ((pageInfo['DIM'] + pageInfo['FDIW']) > 35) {
                            viewPortDays = 42;
                          }

                          int previousRowDayNumber = 0;
                          for (int row = 1; row <= (viewPortDays / 7); row++) {
                            List<Widget> rowWidgets = [];

                            if (row == 1) {
                              datePicker.addAll([
                                _datePickerPageHeader(pageInfo),
                                _datePickerPageWeekCaptions(),
                              ]);

                              for (int daysBefore =
                              (pageInfo['PMDIM'] - pageInfo['FDIW'] + 1);
                              daysBefore <= pageInfo['PMDIM'];
                              daysBefore++) {
                                rowWidgets.add(_dayBlock(
                                    day: daysBefore,
                                    otherMonthDay: true,
                                    pageInfo: pageInfo));
                              }
                              for (int firstRowDays = 1;
                              firstRowDays <= (7 - pageInfo['FDIW']);
                              firstRowDays++) {
                                rowWidgets.add(_dayBlock(
                                    day: firstRowDays, pageInfo: pageInfo));
                              }

                              previousRowDayNumber = (7 - pageInfo['FDIW']);
                            } else if (row == (viewPortDays / 7)) {
                              for (int lastRowDays = previousRowDayNumber + 1;
                              lastRowDays <= pageInfo['DIM'];
                              lastRowDays++) {
                                rowWidgets.add(_dayBlock(
                                    day: lastRowDays, pageInfo: pageInfo));
                              }

                              for (int daysAfter = viewPortDays;
                              daysAfter >
                                  (pageInfo['DIM'] + pageInfo['FDIW']);
                              daysAfter--) {
                                rowWidgets.add(_dayBlock(
                                    day: viewPortDays - daysAfter + 1,
                                    otherMonthDay: true,
                                    pageInfo: pageInfo));
                              }
                            } else {
                              for (int dayRow = previousRowDayNumber + 1;
                              dayRow <= (previousRowDayNumber + 7);
                              dayRow++) {
                                rowWidgets.add(
                                    _dayBlock(day: dayRow, pageInfo: pageInfo));
                              }

                              previousRowDayNumber += 7;
                            }

                            datePicker.add(Row(
                              children: rowWidgets,
                            ));
                          }

                          return Column(
                            children: datePicker,
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: ScaleTransition(
                  scale: CurvedAnimation(
                      parent: yearAnimationController,
                      curve: Interval(0.0, 1.0, curve: _yearSelectionAnimationCurve)),
                  child: Center(
                    child: Container(
                      height: 200,
                      width: 100,
                      decoration: BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 5,
                          spreadRadius: 1,
                        )
                      ]),
                      child: displayYears(),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: ScaleTransition(
                  scale: CurvedAnimation(
                      parent: monthAnimationController,
                      curve: Interval(0.0, 1.0, curve: _monthSelectionAnimationCurve)),
                  child: Center(
                    child: Container(
                      height: 200,
                      width: 100,
                      decoration: BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 5,
                          spreadRadius: 1,
                        )
                      ]),
                      child: displayMonths(),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _dayBlock({int day, bool otherMonthDay = false, pageInfo}) {
    Color color = _daysBackgroundColor;
    Color fontColor = _daysFontColor;
    JalaaliDate dayBlockDateTime = JalaaliDate(datePickerCurrentYear, datePickerCurrentMonth, day);

    bool rangeModeTrueAndDayIsBeforeStart = false;
    if(rangeStartDate != null && rangeFinishDate == null) {
      if(dayBlockDateTime.toDateTime().isBefore(rangeStartDate.toDateTime())) {
        rangeModeTrueAndDayIsBeforeStart = true;
      }
    }


    if (otherMonthDay == true || rangeModeTrueAndDayIsBeforeStart == true) {
      color = _disabledDayBackgroundColor;
      fontColor = _disabledDayFontColor;
    } else {
      if (currentDate.day == day &&
          currentDate.month == datePickerCurrentMonth &&
          currentDate.year == datePickerCurrentYear) {
        color = _currentDayBackgroundColor;
        fontColor = _currentDayFontColor;
      }

      if (day == inputSelectedDate.day &&
          datePickerCurrentMonth == inputSelectedDate.month &&
          datePickerCurrentYear == inputSelectedDate.year) {
        color = _selectedDayBackgroundColor;
        fontColor = _selectedDayFontColor;
      }

      if((rangeStartDate != null && rangeFinishDate != null)) {
        if(
        dayBlockDateTime.toDateTime().compareTo(rangeStartDate.toDateTime()) >= 0
            &&
            dayBlockDateTime.toDateTime().compareTo(rangeFinishDate.toDateTime()) <= 0
        ) {
          color = _selectedDayBackgroundColor;
          fontColor = _selectedDayFontColor;
        }
      }
    }

    return Expanded(
      child: Material(
        child: InkWell(
          onTap: () {
            if (otherMonthDay == false && rangeModeTrueAndDayIsBeforeStart == false) {


              yearAnimationController.reset();
              monthAnimationController.reset();
//              print(currentDate.toDateTime());
//              print(inputSelectedDate.toDateTime());
//              print(currentDate.toDateTime().isBefore(inputSelectedDate.toDateTime()));


              if(widget.rangeSelector == true) {

                if(rangeStartDate == null || (rangeStartDate != null && rangeFinishDate != null)) {


                  rangeStartDate = JalaaliDate(pageInfo['Y'], pageInfo['M'], day);
                  rangeFinishDate = null;
                  widget.controller.text = '';
                } else {

                  rangeFinishDate = JalaaliDate(pageInfo['Y'], pageInfo['M'], day);

                  if(rangeStartDate.toDateTime().compareTo(rangeFinishDate.toDateTime()) <= 0) {
                    widget.controller.text = rangeStartDate.year.toString() +
                        '/' +
                        rangeStartDate.month.toString() +
                        '/' +
                        rangeStartDate.day.toString() +
                        ' - ' +
                        rangeFinishDate.year.toString() +
                        '/' +
                        rangeFinishDate.month.toString() +
                        '/' +
                        rangeFinishDate.day.toString();
                  } else {
                    widget.controller.text = '';
//                      SnackBar(content: Container(
//                        child: Text('تاریخ پایان باید بعد از تاریخ شروع باشد'),
//                      ));
                  }

                  rangeStartDate = null;
                  rangeFinishDate = null;
                }

              } else {
                widget.controller.text = pageInfo['Y'].toString() +
                    '/' +
                    pageInfo['M'].toString() +
                    '/' +
                    day.toString();
              }

              inputStringToJalaali();

              setState(() {});
            }
          },
          child: Container(
            padding: EdgeInsets.all(10),
            color: color,
            child: Center(
              child: Text(
                day.toString(),
                style: TextStyle(color: fontColor, fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _datePickerPageHeader(pageInfo) {
    DateData datetime = DateData(pageInfo['Y'], pageInfo['M'], 1);
    return Container(
        color: _headerBackgroundColor,
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
                      yearAnimationController.reset();
                      if (monthAnimationController.isDismissed)
                        monthAnimationController.forward();
                      else
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
                              size: 18,
                              color: _headerFontColor,
                            ),
                          ),
                          SizedBox(width: 4),
                          Container(
                            child: Text(
                              translate('MMM', datetime, false),
                              style: TextStyle(fontSize: 19, color: _headerFontColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                      onTap: () {
                        monthAnimationController.reset();
                        if (yearAnimationController.isDismissed)
                          yearAnimationController.forward();
                        else
                          yearAnimationController.reverse();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Text(datetime.year.toString(),
                                  style: TextStyle(fontSize: 19, color: _headerFontColor)),
                            ),
                            SizedBox(width: 8),
                            Container(
                              margin: EdgeInsets.only(top: 1),
                              child: Icon(
                                Icons.expand_more,
                                size: 18,
                                color: _headerFontColor,
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
                  datePickerController.animateToPage(
                      todayPageIndex,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeIn
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _headerTodayIcon,
                      SizedBox(width: 5,),
                      Container(padding: EdgeInsets.only(top: 3),child: Text(_headerTodayCaption, style: TextStyle(fontSize: 19),))
                    ],
                  ),
                  color: _headerTodayBackgroundColor,
                ),
              ),
            )

          ],
        ));
  }

  Widget _datePickerPageWeekCaptions() {
    return Row(
      children: <Widget>[
        _weekDayCaption('ش'),
        _weekDayCaption('ی'),
        _weekDayCaption('د'),
        _weekDayCaption('س'),
        _weekDayCaption('چ'),
        _weekDayCaption('پ'),
        _weekDayCaption('ج'),
      ],
    );
  }

  Widget _weekDayCaption(String title) {
    return Expanded(
      child: Container(
          padding: EdgeInsets.all(6),
          color: _weekCaptionsBackgroundColor,
          child: Center(
              child: Text(
                title,
                style: TextStyle(color: _weekCaptionsFontColor, fontSize: 16),
              ))),
    );
  }

  Widget displayYears() {
    double itemHeight = 50;

//    print(inputSelectedDate);

    int selectedYearIndex = years.indexOf(inputSelectedDate.year);
    displayYearsController = ScrollController(
        initialScrollOffset: (selectedYearIndex * itemHeight).toDouble());

//    displayYearsController.animateTo( selectedYearIndex * 10).toDouble(), curve: Curves.bounceIn, duration: Duration(milliseconds: 500) );

    return ListView.builder(
        scrollDirection: Axis.vertical,
        controller: displayYearsController,
        itemCount: years.length,
        itemBuilder: (BuildContext context, int index) {

          Color bgColor = _yearSelectionBackgroundColor;
          Color fontColor = _yearSelectionFontColor;
          if (years[index] == datePickerCurrentYear) {
            bgColor = _yearSelectionHighlightBackgroundColor;
            fontColor = _yearSelectionHighlightFontColor;
          }

          return GestureDetector(
            onTap: () {
              inputSelectedDate.year = years[index];
              setState(() {});
              datePickerController.animateToPage(
                  (inputSelectedDate.year - startDate.year) * 12 +
                      datePickerCurrentMonth -
                      1,
                  duration: Duration(milliseconds: 400),
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
              child: Center(
                  child: Text(
                    years[index].toString(),
                    style: TextStyle(fontSize: 16, color: fontColor),
                  )),
            ),
          );
        });
  }

  Widget displayMonths() {
    double itemHeight = 50;

    displayMonthsController = ScrollController(
        initialScrollOffset: (inputSelectedDate.month * itemHeight).toDouble());

    return ListView.builder(
        scrollDirection: Axis.vertical,
        controller: displayMonthsController,
        itemCount: 12,
        itemBuilder: (BuildContext context, int index) {
          DateData datetime = DateData(inputSelectedDate.year, index + 1, 1);

          Color bgColor = _monthSelectionBackgroundColor;
          Color fontColor = _monthSelectionFontColor;
          if (index + 1 == datePickerCurrentMonth) {
            bgColor = _monthSelectionHighlightBackgroundColor;
            fontColor = _monthSelectionHighlightFontColor;
          }

          return GestureDetector(
            onTap: () {
              datePickerCurrentMonth = index + 1;
              setState(() {});
              datePickerController.animateToPage(
                  (datePickerCurrentYear - startDate.year) * 12 + index,
                  duration: Duration(milliseconds: 400),
                  curve: Curves.easeOut);
              monthAnimationController.reset();
            },
            child: Container(
              height: itemHeight,
              padding: EdgeInsets.only(top: 2),
              decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.black12)),
                  color: bgColor),
//            margin: EdgeInsets.symmetric(vertical: 2.0),
              child: Center(
                  child: Text(
                    translate('MMM', datetime, false),
                    style: TextStyle(fontSize: 16, color: fontColor),
                  )),
            ),
          );
        });
  }
}
