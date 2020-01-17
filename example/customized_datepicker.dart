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
        headerTodayIcon: Icon(Icons.access_alarm, size: 15,),
        datePickerHeight: 280
    ).init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('تقویم شخصی سازی شده'),),
        body: Builder(builder: (BuildContext context) {


          return Column(
            children: <Widget>[

              SizedBox(height: 55,),



              // Simple Date Picker
              Container(
                width: 280,
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
