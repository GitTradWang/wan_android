import 'package:flutter/material.dart';

class HomeFriendsPage extends StatefulWidget {
  @override
  _HomeFriendsPageState createState() => _HomeFriendsPageState();
}

class _HomeFriendsPageState extends State<HomeFriendsPage> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Center(
        child: Text('好友'),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
