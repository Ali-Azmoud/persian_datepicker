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
  // our text controllers
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController rangeTextEditingController =
      TextEditingController();

  PersianDatePickerWidget? persianDatePicker;
  PersianDatePickerWidget? rangePersianDatePicker;

  @override
  void initState() {
    /*Gregorian DatePicker*/
    persianDatePicker = PersianDatePicker(
      controller: textEditingController,
      gregorianDatetime: '2018-09-08',
      outputFormat: 'YYYY/MM/DD',
    ).init();

    /*Range DatePicker*/
    rangePersianDatePicker = PersianDatePicker(
      controller: rangeTextEditingController,
      gregorianDatetime: '2018-09-08',
      gregorianFinishDatetime: '2018-09-15',
      outputFormat: 'YYYY/MM/DD',
    ).init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('تقویم - فرمت خروجی'),
        ),
        body: Builder(builder: (BuildContext context) {
          return Column(
            children: <Widget>[
              // Simple Date Picker
              TextField(
                onTap: () {
                  FocusScope.of(context).requestFocus(
                      new FocusNode()); // to prevent opening default keyboard
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return persianDatePicker!;
                      });
                },
                controller: textEditingController,
              ),

              // Range Date Picker
              TextField(
                onTap: () {
                  FocusScope.of(context).requestFocus(
                      new FocusNode()); // to prevent opening default keyboard
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return rangePersianDatePicker!;
                      });
                },
                controller: rangeTextEditingController,
              ),
            ],
          );
        }),
      ),
    );
  }
}
