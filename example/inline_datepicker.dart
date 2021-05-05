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

  PersianDatePickerWidget? persianDatePicker;

  @override
  void initState() {


    /*Inline DatePicker*/
    persianDatePicker = PersianDatePicker(
      controller: textEditingController,
      datetime: '1397/06/19',
      outputFormat: 'YYYY/MM/DD',
    ).init();



    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('تقویم - نمایش روی صفحه'),),
        body: Builder(builder: (BuildContext context) {


          return Column(
            children: <Widget>[


              // Simple Date Picker

              Container(
                child: persianDatePicker,
              ),
              TextField(
                controller: textEditingController,
              ),




            ],
          );



        }),
      ),
    );
  }
}
