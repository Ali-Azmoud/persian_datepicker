import 'package:flutter/material.dart';
import 'persian_datepicker.dart';

void main() {
  runApp(Home());
}

class Home extends StatelessWidget {

  final TextEditingController textEditingController = TextEditingController(text: '1397/08/15');
  final TextEditingController rangeTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('تقویم'),),
        body: Builder(builder: (BuildContext context) {
          return SingleChildScrollView(

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  onTap: () {

                  },
                  child: Container(
                    child: TextField(
                      onTap: () { FocusScope.of(context).requestFocus(new FocusNode());
                      showModalBottomSheet(context: context, builder: (BuildContext context) {
                        return PersianDatePicker(controller: textEditingController,);
                      });


                      },
                      controller: textEditingController,
                    ),
                  ),
                ),



                GestureDetector(
                  onTap: () {

                  },
                  child: Container(
                    child: TextField(
                      onTap: () { FocusScope.of(context).requestFocus(new FocusNode());
                      showModalBottomSheet(context: context, builder: (BuildContext context) {
                        return PersianDatePicker(controller: rangeTextEditingController, rangeSelector: true,);
                      });


                      },
                      controller: rangeTextEditingController,
                    ),
                  ),
                )

              ],
            ),
          );
        }),
      ),
    );
  }
}
