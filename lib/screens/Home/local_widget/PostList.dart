import 'package:abotalk/model/Post.dart';
import 'package:abotalk/screens/Home/local_widget/PostTile.dart';
import 'package:flutter/material.dart';

class PostList extends StatelessWidget {
  const PostList({
    Key key,
    @required this.postsList,
  }) : super(key: key);

  final List<Post> postsList;

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
              usertype: data.usertype);
        },
        childCount: postsList.length,
      ),
    );
  }
}
