import 'package:abotalk/screens/CreatePost/CreatePollScreen.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

// ignore: must_be_immutable
class PostListAppBar extends StatelessWidget {
  FullScreenDialog myDialog;

  PostListAppBar({this.myDialog});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: true,
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'ABO vs ABO',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(LineAwesomeIcons.plus),
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (BuildContext context) => myDialog,
                        fullscreenDialog: true,
                      ));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
