import 'package:abotalk/screens/Sign/SingInScreen.dart';
import 'package:flutter/material.dart';
import 'screens/Chat/ChatScreen.dart';
import 'screens/Home/HomeScreen.dart';
import 'screens/MyPage/MyPageScreen.dart';
import 'screens/Post/PostScreen.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
    bool isAuth = false;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SongMyung',
        primaryColor: Colors.white,
      ),
      home: isAuth
          ? Scaffold(
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
            )
          : SignInScreen(),
    );
  }
}
