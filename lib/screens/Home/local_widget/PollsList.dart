import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class PollsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    LineAwesomeIcons.check_square,
                    size: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Fun Polls',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              IconButton(
                icon: Icon(LineAwesomeIcons.filter),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Placeholder(),
          Placeholder(),
        ],
      ),
    ));
  }
}
