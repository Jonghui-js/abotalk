import 'package:abotalk/screens/MyPage/MyPageScreen.dart';
import 'package:abotalk/share/color.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    Key key,
    @required this.userType,
    @required this.username,
  }) : super(key: key);

  final String userType;
  final String username;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                  color: setUserColor(userType),
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                padding: EdgeInsets.all(4),
                child: Text(
                  userType.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              username,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              icon: Icon(LineAwesomeIcons.user),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return MyPageScreen();
                    },
                  ),
                );
              },
            )
          ],
        )
      ],
    );
  }
}
