import 'package:abotalk/model/Post.dart';
import 'package:abotalk/redux/Actions.dart';
import 'package:abotalk/redux/AppState.dart';
import 'package:abotalk/screens/Post/PostScreen.dart';
import 'package:abotalk/share/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

// ignore: must_be_immutable
class PostTile extends StatelessWidget {
  String id;
  String title;
  String content;
  String username;
  String usertype;

  PostTile({this.id, this.title, this.content, this.username, this.usertype});
  @override
  Widget build(BuildContext context) {
    Post currentPost = Post(
        id: id,
        title: title,
        username: username,
        content: content,
        usertype: usertype);
    /*  void _showBottomSheet() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return SingleChildScrollView(
              child: Container(
                height: 700,
                child: Column(
                  children: [
                    Container(
                      child: Text('pie chart'),
                    ),
                    Container(
                      child: Text('pie chart'),
                    )
                  ],
                ),
              ),
            );
          });
    } */

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
                margin: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 15.0),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade100,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.075),
                      offset: Offset(10, 10),
                      blurRadius: 10,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-10, -10),
                      blurRadius: 10,
                    ),
                  ],
                ),
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
                            DecoratedBox(
                              decoration: BoxDecoration(
                                  color: setUserColor(usertype),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Container(
                                padding: EdgeInsets.all(4),
                                child: Text(
                                  usertype.toUpperCase(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              username,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      content,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    )
                  ],
                )),
          );
        });
  }
}
