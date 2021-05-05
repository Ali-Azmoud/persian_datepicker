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
  final TextEditingController rangeTextEditingController = TextEditingController();

  PersianDatePickerWidget? persianDatePicker;
  PersianDatePickerWidget? rangePersianDatePicker;

  @override
  void initState() {


    /*Custom Format DatePicker*/
    persianDatePicker = PersianDatePicker(
      controller: textEditingController,
      datetime: '1397/06/19',
      outputFormat: 'MM - YYYY - DD',
    ).init();



    /*Range DatePicker*/
    rangePersianDatePicker = PersianDatePicker(
      controller: rangeTextEditingController,
      datetime: '1397/06/19',
      finishDatetime: '1397/06/22',
      outputFormat: 'MM - YYYY - DD',
    ).init();



    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('تقویم - فرمت خروجی'),),
        body: Builder(builder: (BuildContext context) {


          return Column(
            children: <Widget>[




              // Simple Date Picker
              TextField(
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode()); // to prevent opening default keyboard
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
                  FocusScope.of(context).requestFocus(new FocusNode()); // to prevent opening default keyboard
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
