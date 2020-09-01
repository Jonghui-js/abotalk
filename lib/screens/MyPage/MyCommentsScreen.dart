import 'package:abotalk/model/Comment.dart';
import 'package:abotalk/screens/Post/local_widget/CommentList.dart';
import 'package:abotalk/services/network_handler.dart';
import 'package:flutter/material.dart';

class MyCommentsScreen extends StatefulWidget {
  @override
  _MyCommentsScreenState createState() => _MyCommentsScreenState();
}

class _MyCommentsScreenState extends State<MyCommentsScreen> {
  NetworkHandler networkHandler = NetworkHandler();
  List<Comment> commentsList = [];
  bool circular = false;

  Future<Null> _loadMyComments() async {
    commentsList = [];
    circular = !circular;

    final data = await networkHandler.getMyComments('/posts/mycomments/me');

    setState(() {
      for (Map i in data) {
        commentsList.add(Comment.fromJson(i));
      }
      print(commentsList);
      circular = !circular;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadMyComments();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      // displacement: 180.0,
      color: Colors.orange,
      onRefresh: () async {
        await _loadMyComments();
      },
      child: !circular
          ? CustomScrollView(
              slivers: [CommentList(comments: commentsList)],
            )
          : Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
              ),
            ),
    );
  }
}
