import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:abotalk/network_handler.dart';

class MyPageScreen extends StatefulWidget {
  @override
  _MyPageScreenState createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        actions: [
          IconButton(
              icon: Icon(LineAwesomeIcons.sign_out),
              onPressed: () {
                //로그아웃 기능
                // prefer 바꾸기
              })
        ],
      ),
      body: Container(
        child: Text('mypage'),
      ),
    );
  }
}
