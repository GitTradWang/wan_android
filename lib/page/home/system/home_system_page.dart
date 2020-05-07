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
      padding:  EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      color: Theme.of(context).primaryColor,
      child: AnimatedList(itemBuilder: (BuildContext context, int index, Animation animation) {
        print('$animation');
          return Container(
          height: 80,
          color: Colors.green,
          margin: EdgeInsets.all(10),
        );
      },
        initialItemCount: 10,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
