import 'package:flutter/material.dart';
import 'package:wanandroidflutter/entity/home_index_article_list_entity.dart';
import 'package:wanandroidflutter/widget/cache_image.dart';

class HomeProjectPageListItemWidget extends StatelessWidget {

  final HomeIndexArticleListData data;

  HomeProjectPageListItemWidget(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: CacheImage(
              width: double.infinity,
              url: data.envelopePic,
              fit: BoxFit.fitWidth,
            ),
          ),
          Text(data.title)
        ],
      ),
    );
  }
}
