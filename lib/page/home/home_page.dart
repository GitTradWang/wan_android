import 'package:flutter/material.dart';
import 'package:flutterprojectsample/model/app_model.dart';
import 'package:flutterprojectsample/page/home/friends/home_friends_page.dart';
import 'package:flutterprojectsample/page/home/index/home_index_page.dart';
import 'package:flutterprojectsample/page/home/mine/home_mine_page.dart';
import 'package:flutterprojectsample/page/home/score/home_score_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

const _bottomNavigationItem = const [
  BottomNavigationBarItem(title: Text('首页'), icon: Icon(Icons.home)),
  BottomNavigationBarItem(title: Text('分数'), icon: Icon(Icons.score)),
  BottomNavigationBarItem(title: Text('好友'), icon: Icon(Icons.supervisor_account)),
  BottomNavigationBarItem(title: Text('我的'), icon: Icon(Icons.assignment_ind)),
];

class _HomePageState extends State<HomePage> {
  bool loading = true;

  PageController _pageController;

  int _currentIndex = 0;

  List<Widget> _pageViews = [
    HomeIndexPage(),
    HomeScorePage(),
    HomeFriendsPage(),
    HomeMinePage(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex, keepPage: true);


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _pageViews,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (int index) => this.changeIndex(index),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavigationItem,
        onTap: (int index) => this.changeIndex(index),
        currentIndex: _currentIndex,
        elevation: 1.0,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  void changeIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.jumpToPage(_currentIndex);
  }
}
