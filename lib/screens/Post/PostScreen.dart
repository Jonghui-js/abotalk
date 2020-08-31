import 'package:abotalk/redux/AppState.dart';
import 'package:abotalk/screens/Home/HomeScreen.dart';
import 'package:abotalk/services/network_handler.dart';
import 'package:abotalk/services/user_preferences.dart';
import 'package:abotalk/share/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:status_alert/status_alert.dart';

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final _globalKey = GlobalKey<FormState>();
  NetworkHandler networkHandler = NetworkHandler();
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _contentController = new TextEditingController();
  bool editing = false;
  bool circular = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          _contentController.text = state.currentPost.content;
          _titleController.text = state.currentPost.title;

          void _showDialog() {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                // return object of type Dialog
                return AlertDialog(
                  title: new Text("정말 삭제하시겠습니까?"),
                  actions: <Widget>[
                    FlatButton(
                      color: Colors.blue,
                      child: Text(
                        "아니요",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    FlatButton(
                      color: Colors.red,
                      child: Text(
                        "삭제",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        var res = await networkHandler.deletePost(
                          '/posts/${state.currentPost.id}',
                        );
                        print(res);

                        StatusAlert.show(
                          context,
                          duration: Duration(seconds: 2),
                          title: '삭제 완료',
                          subtitle: 'Subtitle',
                          configuration: IconConfiguration(icon: Icons.done),
                        );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return HomeScreen();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            );
          }

          return circular
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                  ),
                )
              : Scaffold(
                  appBar: AppBar(
                    elevation: 1.0,
                    actions:
                        UserPreferences().userName == state.currentPost.username
                            ? [
                                IconButton(
                                  icon: Icon(
                                    LineAwesomeIcons.edit,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      editing = !editing;
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    LineAwesomeIcons.trash,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    _showDialog();
                                  },
                                )
                              ]
                            : null,
                    title: Row(
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                              color: setUserColor(state.currentPost.usertype),
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            padding: EdgeInsets.all(4),
                            child: Text(
                              state.currentPost.usertype.toUpperCase(),
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
                          state.currentPost.username,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _globalKey,
                      child: ListView(
                        children: <Widget>[
                          Container(
                            constraints: BoxConstraints(maxHeight: 70),
                            child: SingleChildScrollView(
                              child: TextFormField(
                                enabled: editing,
                                validator: (value) {
                                  if (value.isEmpty) return '제목을 입력해주세요';
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: '제목을 입력하세요',
                                  hintStyle: TextStyle(letterSpacing: 2),
                                  contentPadding: EdgeInsets.all(20),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.orange, width: 3)),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                ),
                                maxLines: 1,
                                maxLength: null,
                                controller: _titleController,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            constraints:
                                BoxConstraints(maxHeight: 120, minHeight: 120),
                            child: SingleChildScrollView(
                              child: TextFormField(
                                enabled: editing,
                                validator: (value) {
                                  if (value.isEmpty) return '내용을 입력해주세요';
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: '내용을 입력하세요',
                                  hintStyle: TextStyle(letterSpacing: 2),
                                  contentPadding: EdgeInsets.all(20),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.orange, width: 3)),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                ),
                                maxLines: 50,
                                maxLength: null,
                                controller: _contentController,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            child: editing
                                ? Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: RaisedButton(
                                            color: Colors.orange,
                                            onPressed: () async {
                                              //   setState(() {
                                              //   circular = !circular;
                                              // });

                                              if (_globalKey.currentState
                                                  .validate()) {
                                                Map<String, String> data = {
                                                  "title":
                                                      _titleController.text,
                                                  "content":
                                                      _contentController.text
                                                };
                                                var res = await networkHandler
                                                    .updatePost(
                                                        '/posts/${state.currentPost.id}',
                                                        data);
                                                StatusAlert.show(
                                                  context,
                                                  duration:
                                                      Duration(seconds: 2),
                                                  title: '수정 완료',
                                                  subtitle: 'Subtitle',
                                                  configuration:
                                                      IconConfiguration(
                                                          icon: Icons.done),
                                                );

                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder:
                                                        (BuildContext context) {
                                                      return HomeScreen();
                                                    },
                                                  ),
                                                );
                                              }
                                            },
                                            child: Text("수정 완료")),
                                      )
                                    ],
                                  )
                                : null,
                          )
                        ],
                      ),
                    ),
                  ),
                );
        });
  }
}
