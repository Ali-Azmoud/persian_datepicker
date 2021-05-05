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


    /*Simple DatePicker*/
    persianDatePicker = PersianDatePicker(
      controller: textEditingController,
      datetime: '1397/06/09',
      outputFormat: 'YYYY/MM/DD',
    ).init();

    super.initState();
  }
//  git clone git@github.com:Ali-Azmoud/persian_datepicker.git .
//  https://github.com/Ali-Azmoud/persian_datepicker.git
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
                      return persianDatePicker!;
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
