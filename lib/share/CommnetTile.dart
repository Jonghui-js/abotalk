import 'package:abotalk/share/UserTag.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CommentTile extends StatelessWidget {
  String id = '';
  String text = '';
  String username = '';
  String usertype = '';

  CommentTile({
    this.id,
    this.text,
    this.username,
    this.usertype,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        margin: const EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    text,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Row(
                  children: [
                    UserTypeTag(
                      userType: usertype,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    UserNameTag(
                      userName: username,
                    )
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
