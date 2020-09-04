import 'package:abotalk/model/Post.dart';

class AppState {
  String msg;
  Post currentPost;

  AppState({this.msg, this.currentPost});

  AppState.fromAppState(AppState another) {
    msg = another.msg;
    currentPost = another.currentPost;
  }
}
