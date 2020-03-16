import 'package:flutter/material.dart';
import 'package:wanandroidflutter/widget/page_state_widget.dart';

class NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PageEmptyWidget(
        text: '页面找不到了',
      ),
    );
  }
}
