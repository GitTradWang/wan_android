import 'package:flutter/material.dart';

class HomeScorePage extends StatefulWidget {
  @override
  _HomeScorePageState createState() => _HomeScorePageState();
}

class _HomeScorePageState extends State<HomeScorePage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: Center(
        child: Text('分数'),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
