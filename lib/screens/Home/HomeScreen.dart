import 'package:abotalk/screens/Home/local_widget/PollsList.dart';
import 'package:abotalk/screens/Home/local_widget/UserTypeStatistics.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        actions: [
          IconButton(
            icon: Icon(LineAwesomeIcons.plus),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            UserTypeStatistics(),
            SizedBox(height: 15),
            PollsList(),
          ],
        ),
      ),
    );
  }
}
