import 'package:flutter/material.dart';
import 'package:wanandroidflutter/widget/cache_image.dart';

class UISamplePage extends StatelessWidget {

  final String url;

  UISamplePage({this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('UI使用示例'),
      ),

      body: Container(
        child: Center(
          child: Hero(
            tag: url,
            child: CacheImage(
              url: url,
            ),
          ),
        ),
      ),
    );
  }
}
