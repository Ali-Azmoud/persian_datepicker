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


    /*Range DatePicker*/
    persianDatePicker = PersianDatePicker(
      controller: textEditingController,
      datetime: '1397/06/09',
      finishDatetime: '1397/06/15',
      outputFormat: 'YYYY/MM/DD',
    ).initialize();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('تقویم - انتخاب محدوده تاریخ'),),
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
