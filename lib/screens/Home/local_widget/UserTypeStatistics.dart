import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class UserTypeStatistics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                LineAwesomeIcons.pie_chart,
                size: 30,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'ABO Talker 현황',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            height: 100,
            child: Placeholder(),
          )
        ],
      ),
    );
  }
}
