# Persian Datepicker
A persian ( farsi ) datepicker for flutter.
This package is using [jalaali package](https://pub.dartlang.org/packages/jalaali) as it's dependency

### Installation

Depend on it

```sh
dependencies:
  persian_datepicker: ^0.1
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


A simple example which has a column and two text fields inside it
first `TextField` is simple datepicker
second `TextField` is range datepicker

I used `GestureDetector` to prevent opening `Keyboard` while tapping on `TextField`s

**main.dart**

```sh

import 'package:persian_datepicker/persian_datepicker.dart';

...


Column(
  mainAxisSize: MainAxisSize.min,
  children: <Widget>[
    GestureDetector(
      onTap: () {},
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
      onTap: () {},
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
)
...
```

### HOW IT LOOKS

Simple Datepicker

![](simple.gif)


Range Datepicker

![](range.gif)

You can find the full example in the lib folder
