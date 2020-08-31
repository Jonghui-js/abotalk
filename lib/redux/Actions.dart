import 'package:abotalk/model/Post.dart';

class CheckAuth {
  final bool payload;
  CheckAuth(this.payload);
}

class CheckMsg {
  final String msg;
  CheckMsg(this.msg);
}

class SetCurrentPost {
  final Post currentPost;
  SetCurrentPost(this.currentPost);
}
