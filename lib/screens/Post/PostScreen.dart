import 'package:abotalk/model/Post.dart';
import 'package:abotalk/redux/Actions.dart';
import 'package:abotalk/redux/AppState.dart';
import 'package:abotalk/screens/Home/HomeScreen.dart';
import 'package:abotalk/screens/Post/local_widget/CommentList.dart';
import 'package:abotalk/services/network_handler/post.dart';
import 'package:abotalk/services/user_preferences.dart';
import 'package:abotalk/share/UserTag.dart';
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
  PostNetworkHandler postNetworkHandler = PostNetworkHandler();
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _contentController = new TextEditingController();
  TextEditingController _commentController = new TextEditingController();
  bool editing = false;
  bool circular = false;
  String title = '';
  String postId = '';
  String content = '';
  Post post = Post();
  List<Post> postList = [];
  String usertype = '';
  String username = '';

  void _showPostRemoveDialog() {
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
                var res = await postNetworkHandler.deletePost(
                  '/posts/$postId',
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

  void _showCreateCommentDialog() async {
    await showDialog<String>(
      context: context,
      child: AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: new Row(
          children: <Widget>[
            Expanded(
              child: Container(
                constraints: BoxConstraints(maxHeight: 200, minHeight: 200),
                child: SingleChildScrollView(
                  child: TextFormField(
                    // enabled: editing,
                    validator: (value) {
                      if (value.isEmpty) return '내용을 입력해주세요';
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: '내용을 입력하세요',
                      hintStyle: TextStyle(letterSpacing: 2),
                      contentPadding: EdgeInsets.all(20),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.orange, width: 3)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    maxLines: 8,
                    maxLength: 100,
                    controller: _commentController,
                  ),
                ),
              ),
            )
          ],
        ),
        actions: <Widget>[
          FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              }),
          FlatButton(
              child: const Text('완료'),
              onPressed: () async {
                Map<String, String> data = {"text": _commentController.text};

                var res = await postNetworkHandler.createComment(
                    '/posts/comments/$postId', data);
                print(res);
                print('gg');
                _loadPost();
                Navigator.pop(context);

                /*    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return ;
                                        },
                                      ),
                                    ); */
              })
        ],
      ),
    );
  }

  Future<Null> _loadPost() async {
    setState(() {
      circular = true;
      postList = [];
    });
    var data = await postNetworkHandler.getPost('/posts/$postId');
    print(data);

    setState(() {
      data = Post.fromJson(data);
      StoreProvider.of<AppState>(context).dispatch(SetCurrentPost(data));
    });

    circular = false;
  }

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
          postId = state.currentPost.id;
          return Scaffold(
            backgroundColor: Colors.grey.shade100,
            appBar: AppBar(
              elevation: 1.0,
              actions: UserPreferences().userName == state.currentPost.username
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
                          _showPostRemoveDialog();
                        },
                      )
                    ]
                  : null,
              title: Row(
                children: [
                  UserTypeTag(
                    userType: state.currentPost.usertype,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  UserNameTag(userName: state.currentPost.username)
                ],
              ),
            ),
            body: circular
                ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                    ),
                  )
                : CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        expandedHeight: 320,
                        collapsedHeight: 200,
                        flexibleSpace: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: _globalKey,
                            child: ListView(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        constraints: BoxConstraints(
                                            maxHeight: 50, minHeight: 50),
                                        child: SingleChildScrollView(
                                          child: TextFormField(
                                            keyboardType:
                                                TextInputType.multiline,
                                            enabled: editing,
                                            validator: (value) {
                                              if (value.isEmpty)
                                                return '제목을 입력해주세요';
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.all(10),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.orange,
                                                      width: 3)),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black),
                                              ),
                                            ),
                                            maxLines: 3,
                                            maxLength: null,
                                            controller: _titleController,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Colors.black12,
                                  thickness: 3,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        constraints: BoxConstraints(
                                            maxHeight: 150, minHeight: 150),
                                        child: SingleChildScrollView(
                                          child: TextFormField(
                                            enabled: editing,
                                            validator: (value) {
                                              if (value.isEmpty)
                                                return '내용을 입력해주세요';
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              hintText: '내용을 입력하세요',
                                              hintStyle:
                                                  TextStyle(letterSpacing: 2),
                                              contentPadding:
                                                  EdgeInsets.all(20),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.orange,
                                                      width: 3)),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black),
                                              ),
                                            ),
                                            maxLines: 50,
                                            maxLength: null,
                                            controller: _contentController,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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
                                                      Map<String, String> data =
                                                          {
                                                        "title":
                                                            _titleController
                                                                .text,
                                                        "content":
                                                            _contentController
                                                                .text
                                                      };

                                                      await postNetworkHandler
                                                          .updatePost(
                                                              '/posts/${post.id}',
                                                              data);
                                                      StatusAlert.show(
                                                        context,
                                                        duration: Duration(
                                                            seconds: 2),
                                                        title: '수정 완료',
                                                        subtitle: 'Subtitle',
                                                        configuration:
                                                            IconConfiguration(
                                                                icon:
                                                                    Icons.done),
                                                      );

                                                      Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (BuildContext
                                                              context) {
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
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        pinned: true,
                        backgroundColor: Colors.orange,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(LineAwesomeIcons.plus),
                                  onPressed: () {
                                    _showCreateCommentDialog();
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      CommentList(
                        comments: state.currentPost.comments,
                      )
                    ],
                  ),
          );
        });
  }
}
