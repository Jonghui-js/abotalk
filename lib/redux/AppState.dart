import 'package:abotalk/model/Post.dart';

class AppState {
  // bool isAuth;
  String msg;

  Post currentPost;

  AppState(
      {
      //  @required this.isAuth,
      this.msg,
      this.currentPost});

  AppState.fromAppState(AppState another) {
    //  isAuth = another.isAuth;
    msg = another.msg;
    currentPost = another.currentPost;
  }

  //String get currentContent => currentChallenge;

  //factory AppState.initial() {
  //  return AppState(content: null);
  // }
}
