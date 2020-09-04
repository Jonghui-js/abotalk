import 'package:abotalk/model/Post.dart';
import 'package:abotalk/model/UsersType.dart';
import 'package:abotalk/screens/CreatePost/CreatePollScreen.dart';
import 'package:abotalk/screens/Home/local_widget/HomeAppBar.dart';
import 'package:abotalk/services/network_handler/auth.dart';
import 'package:abotalk/services/network_handler/post.dart';
import 'package:abotalk/share/color.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:abotalk/services/user_preferences.dart';
import 'package:flutter/material.dart';
import 'local_widget/HomeAppBar.dart';
import 'local_widget/PostList.dart';
import 'local_widget/PostListAppBar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController controller = ScrollController();
  CreatePostDialog createPostDialog = CreatePostDialog();
  AuthNetworkHandler authNetworkHandler = AuthNetworkHandler();
  PostNetworkHandler postNetworkHandler = PostNetworkHandler();
  Map<String, double> usersTypeMap = Map();
  List<Post> postsList = [];
  bool pieChartCircular = false;
  String username = UserPreferences().userName;
  String userType = UserPreferences().userType;

  /// Load Users Blood Type
  /// For Pie Chart
  ///

  Future<Null> _loadPieChart() async {
    setState(() {
      pieChartCircular = !pieChartCircular;
    });
    final data = await authNetworkHandler.getUsersType('/main');
    UsersType usersType = new UsersType.fromJson(data);
    setState(() {
      usersTypeMap['ab'] = usersType.ab;
      usersTypeMap['a'] = usersType.a;
      usersTypeMap['b'] = usersType.b;
      usersTypeMap['o'] = usersType.o;
      pieChartCircular = !pieChartCircular;
    });
  }

  /// Load All Posts
  ///

  Future<Null> _loadPosts() async {
    final data = await postNetworkHandler.getPosts('/posts');
    setState(() {
      for (Map post in data) {
        postsList.add(Post.fromJson(post));
      }
    });
  }

  void goToTop() {
    controller.animateTo(0,
        duration: Duration(
          milliseconds: 400,
        ),
        curve: Curves.easeInOut);
  }

  @override
  void initState() {
    super.initState();
    _loadPieChart();
    _loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: HomeAppBar(),
        elevation: 1.0,
      ),
      body: RefreshIndicator(
        displacement: 180.0,
        color: Colors.orange,
        onRefresh: () async {
          await _loadPosts();
        },
        child: CustomScrollView(
          controller: controller,
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
            PostListAppBar(
              createPostDialog: createPostDialog,
              goToTop: goToTop,
            ),
            PostList(
              postsList: postsList,
            )
          ],
        ),
      ),
    );
  }
}
