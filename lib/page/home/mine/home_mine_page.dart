import 'package:flutter/material.dart';

class HomeMinePage extends StatefulWidget {
  @override
  _HomeMinePageState createState() => _HomeMinePageState();
}

class _HomeMinePageState extends State<HomeMinePage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Center(
        child: Text('我的'),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
