import 'package:flutter/material.dart';

class HomeSystemPage extends StatefulWidget {
  @override
  _HomeSystemPageState createState() => _HomeSystemPageState();
}

class _HomeSystemPageState extends State<HomeSystemPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: Center(
        child: Text('体系'),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
