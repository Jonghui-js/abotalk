import 'package:abotalk/model/Comment.dart';

class Post {
  String id;
  String username;
  String title;
  String content;
  String usertype;
  List<Comment> comments;

  Post({
    this.id,
    this.username,
    this.title,
    this.content,
    this.usertype,
    this.comments,
  });

  factory Post.fromJson(dynamic json) {
    if (json['comments'] != null) {
      var commentsObjsJson = json['comments'] as List;
      List commentsList =
          commentsObjsJson.map((tagJson) => Comment.fromJson(tagJson)).toList();

      return Post(
          id: json['id'] as String,
          username: json['username'] as String,
          usertype: json['usertype'] as String,
          title: json['title'] as String,
          content: json['content'] as String,
          comments: commentsList);
    } else {
      return Post(
        id: json['id'] as String,
        username: json['username'] as String,
        usertype: json['usertype'] as String,
        title: json['title'] as String,
        content: json['content'] as String,
      );
    }
  }
}
