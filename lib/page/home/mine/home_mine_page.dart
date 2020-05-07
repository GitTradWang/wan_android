import 'package:flutter/material.dart';
import 'package:wanandroidflutter/config/app_navigator.dart';
import 'package:wanandroidflutter/config/app_router.dart';
import 'package:wanandroidflutter/widget/cache_image.dart';

class HomeMinePage extends StatefulWidget {
  @override
  _HomeMinePageState createState() => _HomeMinePageState();
}

class _HomeMinePageState extends State<HomeMinePage> with AutomaticKeepAliveClientMixin {

  static const url ='https://img1.3s78.com/codercto/9aab5ea830a82bb8eef7422954fff16f';

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text('我的'),),
      body: InkWell(
        onTap: ()=>AppNavigator.navigateTo(context, RouterName.uiSamplePage,arguments: {'url':url}),
        child: Hero(
          tag: url,
          child: CacheImage(
            height: 50,
            width: 100,
            fit: BoxFit.cover,
            url: url,
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
