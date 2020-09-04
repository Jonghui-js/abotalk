import 'package:abotalk/screens/MyPage/MyPageScreen.dart';
import 'package:abotalk/services/user_preferences.dart';
import 'package:abotalk/share/UserTag.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class HomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            UserTypeTag(
              userType: UserPreferences().userType,
            ),
            SizedBox(
              width: 10,
            ),
            UserNameTag(
              userName: UserPreferences().userName,
              fontSize: 20,
            )
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
