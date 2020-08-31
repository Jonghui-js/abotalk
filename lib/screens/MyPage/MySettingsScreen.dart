import 'package:abotalk/model/Post.dart';
import 'package:abotalk/screens/Home/local_widget/PostList.dart';
import 'package:abotalk/services/network_handler.dart';
import 'package:flutter/material.dart';

class MySettingsScreen extends StatefulWidget {
  @override
  _MySettingsScreenState createState() => _MySettingsScreenState();
}

class _MySettingsScreenState extends State<MySettingsScreen> {
  NetworkHandler networkHandler = NetworkHandler();
  List<Post> postsList = [];
  bool circular = false;

  Future<Null> _loadMyPosts() async {
    setState(() {
      postsList = [];
      circular = !circular;
    });

    final data = await networkHandler.getMyPosts('/posts/me');

    setState(() {
      for (Map i in data) {
        postsList.add(Post.fromJson(i));
      }
      circular = !circular;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      // displacement: 180.0,
      color: Colors.orange,
      onRefresh: () async {
        await _loadMyPosts();
      },
      child: !circular
          ? CustomScrollView(
              slivers: [PostList(postsList: postsList)],
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
