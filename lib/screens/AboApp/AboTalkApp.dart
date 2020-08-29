import 'package:abotalk/screens/Chat/ChatScreen.dart';
import 'package:abotalk/screens/Home/HomeScreen.dart';
import 'package:abotalk/screens/MyPage/MyPageScreen.dart';
import 'package:abotalk/screens/Post/PostScreen.dart';
import 'package:flutter/material.dart';

import 'package:line_awesome_icons/line_awesome_icons.dart';

class AboTalkApp extends StatefulWidget {
  @override
  _AboTalkAppState createState() => _AboTalkAppState();
}

class _AboTalkAppState extends State<AboTalkApp> {
  int _selectedIndex = 0;
  void _onIndexTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static List<Widget> _screenOptions = <Widget>[
    HomeScreen(),
    PostScreen(),
    ChatScreen(),
    MyPageScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screenOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        elevation: 0.0,
        onTap: _onIndexTapped,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.deepOrange,
        items: [
          BottomNavigationBarItem(
            icon: Icon(LineAwesomeIcons.university),
            title: Text('home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(LineAwesomeIcons.comments),
            title: Text('post'),
          ),
          BottomNavigationBarItem(
            icon: Icon(LineAwesomeIcons.user),
            title: Text('my Page'),
          ),
          BottomNavigationBarItem(
            icon: Icon(LineAwesomeIcons.cog),
            title: Text('setting'),
          ),
        ],
      ),
    );
  }
}
