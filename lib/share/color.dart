import 'package:flutter/material.dart';

Color abColor = Colors.cyan[300];
Color aColor = Colors.green[300];
Color bColor = Colors.purple[100];
Color oColor = Colors.yellow[300];

Color setUserColor(String userType) {
  Color userColor;
  switch (userType) {
    case 'ab':
      {
        userColor = abColor;
      }

      break;
    case 'a':
      {
        userColor = aColor;
      }
      break;
    case 'b':
      {
        userColor = bColor;
      }
      break;
    case 'o':
      {
        userColor = oColor;
      }
      break;
  }
  return userColor;
}

List<Color> colorList = [
  abColor, //ab
  aColor, //a
  bColor, //b
  oColor, //o
];

List<String> bloodTypeList = ['a', 'b', 'ab', 'o'];
