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


You can find the full example in the lib folder
