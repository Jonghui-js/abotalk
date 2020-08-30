import 'package:abotalk/model/UsersType.dart';
import 'package:abotalk/network_handler.dart';
import 'package:abotalk/share/color.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:abotalk/screens/MyPage/MyPageScreen.dart';
import 'package:abotalk/services/user_preferences.dart';
import 'package:flutter/material.dart';

import 'package:line_awesome_icons/line_awesome_icons.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool circular = true;
  NetworkHandler networkHandler = NetworkHandler();
  String username = '';
  String userType = '';
  String userImgPath = '';
  Map<String, double> dataMap = new Map();
  List<Color> colorList = [
    abColor, //ab
    aColor, //a
    bColor, //b
    oColor, //o
  ];

  _loadMainContent() async {
    var res = await networkHandler.getUsersType('/main');
    return res;
  }

  @override
  void initState() {
    super.initState();
    username = UserPreferences().userName;
    userType = UserPreferences().userType;
    userImgPath = UserPreferences().userImgPath;
    _loadMainContent().then((result) {
      UsersType usersType = new UsersType.fromJson(result);

      setState(() {
        dataMap['AB'] = double.parse(usersType.ab);
        dataMap['A'] = double.parse(usersType.a);
        dataMap['B'] = double.parse(usersType.b);
        dataMap['O'] = double.parse(usersType.o);
        circular = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                      color: setUserColor(userType),
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    padding: EdgeInsets.all(4),
                    child: Text(
                      userType.toUpperCase(),
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
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(LineAwesomeIcons.user),
                  onPressed: () {},
                )
              ],
            )
          ],
        ),
        elevation: 1.0,
      ),
      body: CustomScrollView(
        slivers: [
          //파이차트 구현하기
          SliverAppBar(
            expandedHeight: 180,
            collapsedHeight: 120,
            backgroundColor: Colors.grey[100],
            flexibleSpace: Container(
              height: 180,
              alignment: Alignment.bottomCenter,
              child: circular
                  ? CircularProgressIndicator()
                  : Center(
                      child: PieChart(
                        colorList: colorList,
                        dataMap: dataMap,
                        animationDuration: Duration(milliseconds: 800),
                        chartLegendSpacing: 32.0,
                        chartRadius: MediaQuery.of(context).size.width / 2.7,
                      ),
                    ),
            ),
            floating: false,
          ),

          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ABO vs ABO',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(LineAwesomeIcons.plus),
                      onPressed: () {
                        UserPreferences().checkAuth = false;
                        UserPreferences().checkToken = '';
                      },
                    ),
                    IconButton(
                      icon: Icon(LineAwesomeIcons.filter),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
          SliverAnimatedList(
            itemBuilder: (_, index, ___) {
              return ListTile(
                title: Text(index.toString()),
              );
            },
            initialItemCount: 20,
          )
        ],
      ),
    );
  }
}
