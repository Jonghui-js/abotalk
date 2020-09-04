import 'package:abotalk/screens/Home/HomeScreen.dart';
import 'package:abotalk/services/network_handler/post.dart';
import 'package:flutter/material.dart';

class CreatePostDialog extends StatefulWidget {
  @override
  _CreatePostDialogState createState() => new _CreatePostDialogState();
}

class _CreatePostDialogState extends State<CreatePostDialog> {
  final _globalKey = GlobalKey<FormState>();
  PostNetworkHandler postNetworkHandler = PostNetworkHandler();
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _contentController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("글 작성"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _globalKey,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) return '제목을 입력해주세요';
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: '제목을 입력하세요',
                    hintStyle: TextStyle(letterSpacing: 2),
                    contentPadding: EdgeInsets.all(20),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange, width: 3)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  maxLines: 2,
                  maxLength: 50,
                  controller: _titleController,
                ),
                SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) return '내용을 입력해주세요';
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: '내용을 입력하세요',
                    hintStyle: TextStyle(letterSpacing: 2),
                    contentPadding: EdgeInsets.all(20),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange, width: 3)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  maxLines: 20,
                  maxLength: 1000,
                  controller: _contentController,
                ),
                SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: RaisedButton(
                      color: Colors.orange,
                      onPressed: () async {
                        if (_globalKey.currentState.validate()) {
                          Map<String, String> data = {
                            "title": _titleController.text,
                            "content": _contentController.text
                          };
                          var res = await postNetworkHandler.createPost(
                              '/posts', data);
                          print(res);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return HomeScreen();
                              },
                            ),
                          );
                        }
                      },
                      child: Text("작성 완료"),
                    ))
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
