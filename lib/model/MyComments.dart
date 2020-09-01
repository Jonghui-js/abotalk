import 'package:abotalk/model/Comment.dart';

class MyComment {
  String id;
  List<Comment> comments;

  MyComment({this.id, this.comments});

  factory MyComment.fromJson(dynamic json) {
    if (json['comments'] != null) {
      var commentsObjsJson = json['comments'] as List;
      List commentsList =
          commentsObjsJson.map((tagJson) => Comment.fromJson(tagJson)).toList();

      return MyComment(id: json['id'] as String, comments: commentsList);
    } else {
      return MyComment(
        id: json['id'] as String,
      );
    }
  }
}
