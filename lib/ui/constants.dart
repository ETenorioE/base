import 'package:flutter/material.dart';

const kColorBlue = Color.fromARGB(255, 0, 180, 186);
const kColorGreen = Color.fromARGB(255, 144, 202, 13);
const kColorDarkBlue = Color(0xff1b3a5e);
const kColorPink = Color(0xffff748d);

final kHintTextStyle = TextStyle(
  color: kColorBlue,
  fontFamily: 'Uniform',
);

final kLabelStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w200,
  fontFamily: 'Uniform',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Colors.grey[200],
  borderRadius: BorderRadius.circular(45.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);