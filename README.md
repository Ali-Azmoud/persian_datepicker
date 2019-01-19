
# Persian Datepicker
A persian ( farsi ) datepicker for flutter.

### Installation

Depend on it

```sh
dependencies:
  persian_datepicker: ^1.1.3
```
Install it

```sh
flutter packages get
```

Import it

```sh
import 'package:persian_datepicker/persian_datepicker.dart';
```

# Persian DatePicker
A persian ( farsi ) datepicker for flutter.


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
//      datetime: '1397/06/09',
    ).initialize();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('دیت پیکر ساده'),),
        body: Builder(builder: (BuildContext context) {


          return Container(
            child: TextField(
              enableInteractiveSelection: false, // *** this is important to prevent user interactive selection ***
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

**Simple DatePicker**

![](simple.gif)

<br>
<br>
<br>
<br>

**Range DatePicker**

```
/*Range DatePicker*/
persianDatePicker = PersianDatePicker(
  controller: textEditingController,
  rangeDatePicker: true,
  // datetime: '1397/06/09',
  // finishDatetime: '1397/06/15',
).initialize();

```

![](range.gif)

<br>
<br>
<br>
<br>

**Inline DatePicker**

```
/*Inline DatePicker*/
persianDatePicker = PersianDatePicker(
  controller: textEditingController,
  datetime: '1397/06/19',
).initialize();


....


return Column(
  children: <Widget>[
    // Simple Date Picker
    Container(
      child: persianDatePicker, // just pass `persianDatePicker` variable as child with no ( )
    ),
    TextField(
      enabled: false,
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

**Customized DatePicker**

You can customize datepicker as you wish, there are a lot of options to set, below code is just a few of them.

```
/*Customized DatePicker*/
persianDatePicker = PersianDatePicker(
    controller: textEditingController,
    outputFormat: 'YYYY/MM/DD',
    datetime: '1397/08/29',
    finishDatetime: '1397/08/30',
    daysBorderWidth: 3,
    weekCaptionsBackgroundColor: Colors.red,
    headerBackgroundColor: Colors.blue.withOpacity(0.5),
    headerTextStyle: TextStyle(color: Colors.blue, fontSize: 17),
    headerTodayIcon: Icon(Icons.access_alarm, size: 15,),
    datePickerHeight: 280
).initialize();
```

![](customized.PNG)


<br>
<br>
<br>

```
/*Customized Font Family ( Farsi Digits )*/
persianDatePicker = PersianDatePicker(
    controller: textEditingController,
    farsiDigits: true
).initialize();
```

Or if you have a font which supports farsi digits then you can simply pass the font name and everything would be ok
اگر فونتی در برنامه استفاده کرده اید که قابلیت نمایش اعداد فارسی را دارد تنها لازم است اسم فونت را به دیت پیکر بدهید

```
/*Customized Font Family ( Farsi Digits )*/
persianDatePicker = PersianDatePicker(
    controller: textEditingController,
    fontFamily: 'Vazir' // here I used Vazir font
).initialize();
```

![](font-family-vazir.PNG)


<br>
<br>
<br>


### Options

To see the all options and their default value, [please visit the api page](https://pub.dartlang.org/documentation/persian_datepicker/latest/persian_datepicker/PersianDatePicker/PersianDatePicker.html)


### Important Notes نکات مهم

up to this version all output dates are in persian.
تا این نسخه تمام تاریخ های خروجی پارسی(جلالی) هستند


`rangeSeparator` and your custom date separator should not be equal, otherwise datepicker will return null  
مقدار ورودی 
`rangeSeparator`
و جداکننده ای که برای فرمت خروجی انتخاب کرده اید نباید یکی باشند در این صورت دیت پیکر خروجی `جداکننده های محدوده و خروجی مشابه هستند` برمیگرداند

<br>

Persian **input** dates must respect `YYYY/MM/DD` format. output format is up to you
Gregorian **input** dates must respect `YYYY-MM-DD` format. output format is persian and up to you
فرمت تاریخ های ورودی که پارسی (جلالی) هستند **باید** بصورت 
`YYYY/MM/DD`
باشد. فرمت خروجی به دلخواه شماست
فرمت تاریخ های ورودی که میلادی هستند **باید** بصورت
`YYYY-MM-DD`
باشد. فرمت تاریخ خروجی، پارسی و به دلخواه شما خواهد بود

<br>

### Examples
You can find the full example in the Git Repository, example directory
