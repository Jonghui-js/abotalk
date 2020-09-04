import 'package:abotalk/model/Post.dart';
import 'package:abotalk/screens/Sign/SingInScreen.dart';
import 'package:abotalk/services/network_handler/auth.dart';
import 'package:abotalk/services/user_preferences.dart';
import 'package:abotalk/share/UserTag.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class MySettingsScreen extends StatefulWidget {
  @override
  _MySettingsScreenState createState() => _MySettingsScreenState();
}

class _MySettingsScreenState extends State<MySettingsScreen> {
  AuthNetworkHandler authNetworkHandler = AuthNetworkHandler();
  TextEditingController _userNameController = new TextEditingController();
  List<Post> postsList = [];
  bool circular = false;

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("로그아웃 하시겠습니까?"),
          actions: <Widget>[
            FlatButton(
              color: Colors.blue,
              child: Text(
                "취소",
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
                "로그아웃",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () async {
                var res = await authNetworkHandler.logout('/auth/logout');
                if (res['success']) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return SignInScreen();
                      },
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showUpdateUserDialog() async {
    await showDialog<String>(
      context: context,
      child: AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: new Row(
          children: <Widget>[
            Expanded(
              child: Container(
                constraints: BoxConstraints(maxHeight: 80, minHeight: 80),
                child: SingleChildScrollView(
                  child: TextFormField(
                    // enabled: editing,
                    validator: (value) {
                      if (value.isEmpty) return '내용을 입력해주세요';
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: '10자 이내로 입력하세요',
                      hintStyle: TextStyle(letterSpacing: 2),
                      contentPadding: EdgeInsets.all(20),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.orange, width: 3)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    maxLines: 1,
                    maxLength: 10,
                    controller: _userNameController,
                  ),
                ),
              ),
            )
          ],
        ),
        actions: <Widget>[
          FlatButton(
              child: const Text(
                '취소',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          FlatButton(
              child: const Text('완료'),
              onPressed: () async {
                Map<String, String> data = {
                  "username": _userNameController.text
                };
                var res = await authNetworkHandler.updateUser(
                    '/auth/updateuser', data);
                UserPreferences().userName = _userNameController.text;
                Navigator.pop(context);
              })
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    //_loadSetting();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Column(
              children: [
                ListTile(
                  leading: IconButton(
                    icon: Icon(LineAwesomeIcons.check_circle),
                    onPressed: () {},
                  ),
                  title: Row(
                    children: [
                      Text(
                        'User Name',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      UserNameTag(
                        userName: UserPreferences().userName,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      IconButton(
                          icon: Icon(LineAwesomeIcons.edit),
                          onPressed: () {
                            _showUpdateUserDialog();
                          }),
                    ],
                  ),
                ),
                ListTile(
                  leading: IconButton(
                    icon: Icon(LineAwesomeIcons.check_circle),
                    onPressed: () {},
                  ),
                  title: Row(
                    children: [
                      Text(
                        'Blood Type',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      UserTypeTag(
                        userType: UserPreferences().userType,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Card(
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Column(
              children: [
                ListTile(
                  leading: IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () {},
                  ),
                  title: Text('버전1.0.0'),
                ),
                ListTile(
                  onTap: () {
                    _showLogoutDialog();
                  },
                  leading: IconButton(
                    icon: Icon(LineAwesomeIcons.sign_out),
                    onPressed: () {},
                  ),
                  title: Text('로그아웃'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
