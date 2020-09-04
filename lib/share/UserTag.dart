import 'package:abotalk/share/color.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserTypeTag extends StatelessWidget {
  String userType;

  UserTypeTag({this.userType});
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: setUserColor(userType),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 7),
        child: Text(
          userType.toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class UserNameTag extends StatelessWidget {
  double fontSize;
  Color fontColor;
  String userName;

  UserNameTag({this.fontSize, this.fontColor, this.userName});
  @override
  Widget build(BuildContext context) {
    return Text(
      userName,
      style: TextStyle(
        color: fontColor,
        fontSize: fontSize,
      ),
    );
  }
}
