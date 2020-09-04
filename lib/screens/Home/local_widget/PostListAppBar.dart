import 'package:abotalk/screens/CreatePost/CreatePollScreen.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

// ignore: must_be_immutable
class PostListAppBar extends StatelessWidget {
  CreatePostDialog createPostDialog;
  Function goToTop;
  PostListAppBar({this.createPostDialog, this.goToTop});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: true,
      backgroundColor: Colors.orange,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'ABO talk',
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(LineAwesomeIcons.arrow_up),
                onPressed: () async {
                  goToTop();
                },
              ),
              IconButton(
                icon: const Icon(LineAwesomeIcons.plus),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => createPostDialog,
                      fullscreenDialog: true,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
