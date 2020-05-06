import 'package:flutter/material.dart';
import 'package:wanandroidflutter/page/home/ground/home_ground_page.dart';
import 'package:wanandroidflutter/page/home/index/home_index_page.dart';
import 'package:wanandroidflutter/page/home/mine/home_mine_page.dart';
import 'package:wanandroidflutter/page/home/project/home_project_page.dart';
import 'package:wanandroidflutter/page/home/question/home_question_page.dart';
import 'package:wanandroidflutter/page/home/system/home_system_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

const _bottomNavigationItem = const [
  BottomNavigationBarItem(title: Text('首页'), icon: Icon(Icons.home)),
  BottomNavigationBarItem(title: Text('体系'), icon: Icon(Icons.settings_system_daydream)),
  BottomNavigationBarItem(title: Text('广场'), icon: Icon(Icons.supervisor_account)),
  BottomNavigationBarItem(title: Text('问答'), icon: Icon(Icons.restore_page)),
  BottomNavigationBarItem(title: Text('项目'), icon: Icon(Icons.pages)),
  BottomNavigationBarItem(title: Text('我的'), icon: Icon(Icons.format_align_left)),
];

class _HomePageState extends State<HomePage> {
  PageController _pageController;

  int _currentIndex = 0;

  List<Widget> _pageViews = [
    HomeIndexPage(),
    HomeSystemPage(),
    HomeGroundPage(),
    HomeQuestionPage(),
    HomeProjectPage(),
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
