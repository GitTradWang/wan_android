import 'package:flutter/material.dart';

class HomeGroundPage extends StatefulWidget {
  @override
  _HomeGroundPageState createState() => _HomeGroundPageState();
}

class _HomeGroundPageState extends State<HomeGroundPage> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Center(
        child: Text('广场'),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
