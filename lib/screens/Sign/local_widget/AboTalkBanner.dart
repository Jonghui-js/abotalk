import 'package:flutter/material.dart';

class AboTalkBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, bottom: 20),
      alignment: Alignment.bottomLeft,
      height: 250,
      child: Text(
        'ABO+\nTALK',
        style: TextStyle(fontSize: 50, fontFamily: 'BlackHanSans'),
      ),
      decoration: BoxDecoration(color: Colors.orange),
    );
  }
}
