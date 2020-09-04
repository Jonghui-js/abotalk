import 'package:abotalk/model/Post.dart';
import 'package:abotalk/share/PostTile.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PostList extends StatelessWidget {
  List<Post> postsList;

  PostList({
    this.postsList,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          var data = postsList[index];
          return PostTile(
            id: data.id,
            title: data.title,
            content: data.content,
            username: data.username,
            usertype: data.usertype,
            comments: data.comments,
          );
        },
        childCount: postsList.length,
      ),
    );
  }
}
