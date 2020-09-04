import 'package:abotalk/model/Comment.dart';
import 'package:abotalk/model/Post.dart';
import 'package:abotalk/redux/Actions.dart';
import 'package:abotalk/redux/AppState.dart';
import 'package:abotalk/screens/Post/PostScreen.dart';
import 'package:abotalk/share/UserTag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

// ignore: must_be_immutable
class PostTile extends StatelessWidget {
  String id;
  String title;
  String content;
  String username;
  String usertype;
  List<Comment> comments;

  PostTile(
      {this.id,
      this.title,
      this.content,
      this.username,
      this.usertype,
      this.comments});
  @override
  Widget build(BuildContext context) {
    Post currentPost = Post(
        id: id,
        title: title,
        username: username,
        content: content,
        usertype: usertype,
        comments: comments);

    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              StoreProvider.of<AppState>(context)
                  .dispatch(SetCurrentPost(currentPost));
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return PostScreen();
                  },
                ),
              );
            },
            child: Container(
                color: Colors.white,
                margin: const EdgeInsets.only(
                    top: 10, bottom: 5, left: 10, right: 10),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            title,
                            style: TextStyle(fontSize: 20),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Row(
                          children: [
                            UserTypeTag(
                              userType: usertype,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            UserNameTag(
                              userName: username,
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      content,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '댓글 ${comments.length}',
                        ),
                      ],
                    )
                  ],
                )),
          );
        });
  }
}
