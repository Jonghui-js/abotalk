import 'package:abotalk/screens/MyPage/MyCommentsScreen.dart';
import 'package:abotalk/screens/MyPage/MyPostsScreen.dart';
import 'package:abotalk/screens/MyPage/MySettingsScreen.dart';
import 'package:abotalk/screens/Sign/SingInScreen.dart';
import 'package:abotalk/services/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:abotalk/services/network_handler.dart';

class MyPageScreen extends StatefulWidget {
  @override
  _MyPageScreenState createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    MyPostsScreen(),
    MyCommentsScreen(),
    MySettingsScreen()
  ];
  NetworkHandler networkHandler = NetworkHandler();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        actions: [
          IconButton(
              icon: Icon(LineAwesomeIcons.sign_out),
              onPressed: () async {
                //로그아웃 기능
                // prefer 바꾸기
                var res = await networkHandler.logout('/auth/logout');
                if (res['success']) {
                  UserPreferences().checkAuth = false;
                  UserPreferences().checkToken = '';
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return SignInScreen();
                      },
                    ),
                  );
                }
              })
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        showSelectedLabels: true,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.orange[700],
        items: [
          BottomNavigationBarItem(
              icon: Icon(LineAwesomeIcons.align_justify),
              title: Text('내 글'),
              activeIcon: Icon(
                LineAwesomeIcons.align_justify,
              )),
          BottomNavigationBarItem(
            icon: Icon(LineAwesomeIcons.comment),
            title: Text('내 댓글'),
          ),
          BottomNavigationBarItem(
            icon: Icon(LineAwesomeIcons.cogs),
            title: Text('설정'),
          ),
        ],
      ),
    );
  }
}
