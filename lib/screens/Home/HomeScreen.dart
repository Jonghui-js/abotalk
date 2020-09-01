import 'package:abotalk/model/Post.dart';
import 'package:abotalk/model/UsersType.dart';
import 'package:abotalk/services/network_handler.dart';
import 'package:abotalk/screens/CreatePost/CreatePollScreen.dart';
import 'package:abotalk/share/color.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:abotalk/services/user_preferences.dart';
import 'package:flutter/material.dart';
import 'local_widget/HomeAppBAr.dart';
import 'local_widget/PostList.dart';
import 'local_widget/PostListAppBar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FullScreenDialog _myDialog = new FullScreenDialog();
  NetworkHandler networkHandler = NetworkHandler();
  Map<String, double> usersTypeMap = Map();
  List<Post> postsList = [];
  bool pieChartCircular = true;
  bool postsCircular = true;
  String username = '';
  String userType = '';

  Future<Null> _loadPieChart() async {
    final data = await networkHandler.getUsersType('/main');
    UsersType usersType = new UsersType.fromJson(data);
    setState(() {
      usersTypeMap['AB'] = double.parse(usersType.ab);
      usersTypeMap['A'] = double.parse(usersType.a);
      usersTypeMap['B'] = double.parse(usersType.b);
      usersTypeMap['O'] = double.parse(usersType.o);
      pieChartCircular = false;
    });
  }

  Future<Null> _loadPosts() async {
    postsList = [];
    final data = await networkHandler.getPosts('/posts');
    setState(() {
      for (Map i in data) {
        postsList.add(Post.fromJson(i));
      }
      postsCircular = false;
    });
  }

  @override
  void initState() {
    super.initState();
    username = UserPreferences().userName;
    userType = UserPreferences().userType;
    _loadPieChart();
    _loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: HomeAppBar(userType: userType, username: username),
        elevation: 1.0,
      ),
      body: RefreshIndicator(
        displacement: 180.0,
        color: Colors.orange,
        onRefresh: () async {
          await _loadPosts();
        },
        child: CustomScrollView(
          slivers: [
            //파이차트 구현하기
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: 180,
              collapsedHeight: 120,
              backgroundColor: Colors.grey[100],
              flexibleSpace: Container(
                height: 180,
                alignment: Alignment.bottomCenter,
                child: pieChartCircular
                    ? Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.orange),
                        ),
                      )
                    : Center(
                        child: PieChart(
                          colorList: colorList,
                          dataMap: usersTypeMap,
                          animationDuration: Duration(milliseconds: 800),
                          chartLegendSpacing: 32.0,
                          chartRadius: MediaQuery.of(context).size.width / 2.7,
                        ),
                      ),
              ),
              floating: false,
            ),
            PostListAppBar(myDialog: _myDialog),
            PostList(postsList: postsList)
          ],
        ),
      ),
    );
  }
}
