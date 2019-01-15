# Persian Datepicker
A persian ( farsi ) datepicker for flutter.
This package is using [jalaali package](https://pub.dartlang.org/packages/jalaali) as it's dependency

### Installation

Depend on it

```sh
dependencies:
  persian_datepicker: ^0.2.1
```
Install it

```sh
flutter packages get
```

Import it

```sh
import 'package:persian_datepicker/persian_datepicker.dart';
```

### Usage


A simple example with a TextField which turns into a datepicker

**main.dart**

```sh

import 'package:flutter/material.dart';
import 'package:persian_datepicker/persian_datepicker.dart';


void main() {
  runApp(Home());
}

class Home extends StatefulWidget {
  @override
  HomeState createState() {
    return new HomeState();
  }
}

class HomeState extends State<Home> {

  // our text controller
  final TextEditingController textEditingController = TextEditingController();

  PersianDatePickerWidget persianDatePicker;

  @override
  void initState() {


    /*Simple DatePicker*/
    persianDatePicker = PersianDatePicker(
      controller: textEditingController,
      datetime: '1397/06/09',
      outputFormat: 'YYYY/MM/DD',
    ).initialize();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('تقویم ساده'),),
        body: Builder(builder: (BuildContext context) {


          return Container(
            child: TextField(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode()); // to prevent opening default keyboard
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return persianDatePicker;
                    });
              },
              controller: textEditingController,
            ),
          );



        }),
      ),
    );
  }
}

```

### HOW IT LOOKS

**Simple Datepicker**

![](simple.gif)

<br>
<br>
<br>
<br>

**Range Datepicker**

```
/*Range DatePicker*/
persianDatePicker = PersianDatePicker(
  controller: textEditingController,
  datetime: '1397/06/09',
  finishDatetime: '1397/06/15',
  outputFormat: 'YYYY/MM/DD',
).initialize();

```

![](range.gif)

<br>
<br>
<br>
<br>

**Inline Datepicker**

```
/*Inline DatePicker*/
persianDatePicker = PersianDatePicker(
  controller: textEditingController,
  datetime: '1397/06/19',
  outputFormat: 'YYYY/MM/DD',
).initialize();


....


return Column(
  children: <Widget>[
    // Simple Date Picker
    Container(
      child: persianDatePicker, // just pass `persianDatePicker` variable as child with no ( )
    ),
    TextField(
      controller: textEditingController,
    ),
  ],
);
```

![](inline.gif)

<br>
<br>
<br>
<br>

**Customized Datepicker**

You can customize datepicker as you wish, there are a lot of options to set, below code is just a few of them.

```
/*Customized DatePicker*/
persianDatePicker = PersianDatePicker(
    controller: textEditingController,
    outputFormat: 'YYYY/MM/DD',
    datetime: '1397/08/13',
    finishDatetime: '1397/08/17',
    daysBorderWidth: 3,
    weekCaptionsBackgroundColor: Colors.red,
    headerBackgroundColor: Colors.blue.withOpacity(0.5),
    headerTextStyle: TextStyle(color: Colors.blue, fontSize: 17),
    headerTodayText: Text('امروز', style: TextStyle(fontSize: 15),),
    headerTodayIcon: Icon(Icons.access_alarm, size: 15,),
    datePickerHeight: 280
).initialize();
```

![](customized.PNG)


<br>
<br>
<br>



### Options

The controller of the input which you want to connect it to datepicker. This parameter is **required**  
کنترلر تکست فیلدی که میخواهید به دیت پیکر تبدیل کنید
```
TextEditingController controller @required
```
<br>

Persian input datetime   
ورودی دیت پیکر به فرمت تاریخ پارسی 
```
String datetime
```

<br>

Persian input finish datetime, if this option is set, then datepicker changes to range datepicker  
ورودی دیت پیکر برای تاریخ پایان به فرمت پارسی، اگر این ورودی ست شود، دیت پیکر به صورت محدوده ای خواهد بود
```
String finishDatetime
```

<br>

Gregorian input datetime  
ورودی دیت پیکر به فرمت تاریخ میلادی
```
String gregorianDatetime
```

<br>

Gregorian finish datetime, if this option is set, then datepicker changes to range datepicker  
ورودی دیت پیکر برای تاریخ پایان به فرمت گرگورین، اگر این ورودی ست شود، دیت پیکر به صورت محدوده ای خواهد بود
```
String gregorianFinishDatetime
```

<br>

Output format of the datepicker ( display format )
فرمت خروجی نمایش تاریخ  

* YYYY  ( four digits year سال به صورت چهار رقمی )
* YY    ( two digits year سال به صورت دو رقمی )
* MM    ( 0 lead month ماه با صفر در ابتدای عددهای کمتر از 10 )
* M     ( month number ماه بدون صفر در ابتدای عددهای کمتر از 10 )
* DD    ( 0 lead day number روز با صفر در ابتدای اعداد کمتر از 10 )
* D    ( day number روز بدون صفر در ابتدای اعداد کمتر از 10 )
```
String outputFormat
```

<br>


Range output or input is two dates beside to each other with a separator between them which is `rangeSeparator`, default value is ` # `  
فرمت ورودی یا خروجی محدوده به صورت دو تاریخ کنار هم با یک جدا کننده است. این ورودی همان جدا کننده است که مقدار پیش فرض آن `#` میباشد
```
String rangeSeparator
```

<br>

```
double datePickerHeight
```

<br>

```
int yearSelectionAnimationDuration
```

<br>

```
Curve yearSelectionAnimationCurve
```

<br>

```
int monthSelectionAnimationDuration
```

<br>

```
Curve monthSelectionAnimationCurve
```

<br>

```
Color yearSelectionBackgroundColor
```

<br>

```
Color yearSelectionFontColor
```

<br>

```
Color yearSelectionHighlightBackgroundColor
```

<br>

```
Color yearSelectionHighlightFontColor
```

<br>

```
Color monthSelectionBackgroundColor
```

<br>

```
Color monthSelectionFontColor
```

<br>

```
Color monthSelectionHighlightBackgroundColor
```

<br>

```
Color monthSelectionHighlightFontColor
```

<br>

```
Color weekCaptionsBackgroundColor
```

<br>

```
Color weekCaptionsFontColor
```

<br>

```
Color headerBackgroundColor
```

<br>

```
TextStyle headerTextStyle
```

<br>

```
Color daysBackgroundColor
```

<br>

```
Color daysFontColor
```

<br>

```
Color currentDayBackgroundColor
```

<br>

```
Color currentDayFontColor
```

<br>

```
Color selectedDayBackgroundColor
```

<br>

```
Color selectedDayFontColor
```

<br>

```
Color headerTodayBackgroundColor
```

<br>

```
Color disabledDayBackgroundColor
```

<br>

```
Color disabledDayFontColor
```

<br>

```
Text headerTodayText
```

<br>

```
Icon headerTodayIcon
```

<br>

```
Color daysBorderColor
```

<br>

```
Color selectedDayBorderColor
```

<br>

```
Color selectedDaysInnerBorderColor
```

<br>

```
Color todayBorderColor
```

<br>

```
double daysBorderWidth
```

<br>
<br>


### Important Notes نکات مهم
`rangeSeparator` and your custom date separator should not be equal, otherwise datepicker will return null


You can find the full example in the lib folder
