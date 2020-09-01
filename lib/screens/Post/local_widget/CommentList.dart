import 'package:abotalk/model/Comment.dart';
import 'package:abotalk/screens/Post/local_widget/CommnetTile.dart';
import 'package:flutter/material.dart';

class CommentList extends StatelessWidget {
  const CommentList({
    Key key,
    @required this.comments,
  }) : super(key: key);

  final List<Comment> comments;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          var data = comments[index];
          return CommentTile(
            id: data.id,
            text: data.text,
            username: data.username,
            usertype: data.usertype,
          );
        },
        childCount: comments.length,
      ),
    );
  }
}
