import 'package:abotalk/screens/MyPage/MyCommentsScreen.dart';
import 'package:abotalk/screens/MyPage/MyPostsScreen.dart';
import 'package:abotalk/screens/MyPage/MySettingsScreen.dart';
import 'package:abotalk/services/network_handler/auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

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
  AuthNetworkHandler authNetworkHandler = AuthNetworkHandler();

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
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 1.0,
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
