import 'package:abotalk/model/Post.dart';
import 'package:abotalk/screens/Home/local_widget/PostList.dart';
import 'package:abotalk/services/network_handler/post.dart';
import 'package:abotalk/services/user_preferences.dart';
import 'package:flutter/material.dart';

class MyPostsScreen extends StatefulWidget {
  @override
  _MyPostsScreenState createState() => _MyPostsScreenState();
}

class _MyPostsScreenState extends State<MyPostsScreen> {
  PostNetworkHandler postNetworkHandler = PostNetworkHandler();
  List<Post> postsList = [];
  bool circular = false;
  String username = UserPreferences().userName;

  /// Load My App Posts
  ///
  ///
  Future<Null> _loadMyPosts() async {
    postsList = [];
    circular = !circular;
    final data = await postNetworkHandler.getMyPosts('/posts/myposts/me');
    setState(() {
      for (Map i in data) {
        postsList.add(Post.fromJson(i));
      }
      circular = !circular;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadMyPosts();
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
              slivers: [
                PostList(
                  postsList: postsList,
                )
              ],
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
