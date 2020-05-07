import 'package:flutter/material.dart';
import 'package:wanandroidflutter/widget/cache_image.dart';

class HomeProjectPageListItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: CacheImage(
              width: double.infinity,
              url: "https://wanandroid.com/blogimgs/e4109fbf-47d9-461a-a87a-16f20cba974c.png",
              fit: BoxFit.fitWidth,
            ),
          ),
          Text("Hey Flutter: 体验较佳的WanAndroid Flutter客户端")
        ],
      ),
    );
  }
}
