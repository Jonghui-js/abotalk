import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class PostScreen extends StatelessWidget {
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
    );
  }
}
