import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroidflutter/entity/home_index_article_list_entity.dart';

class HomeIndexArticleItemWidget extends StatelessWidget {
  final int index;

  final HomeIndexArticleListData data;

  HomeIndexArticleItemWidget({this.index, this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: index == 0
          ? EdgeInsets.only(top: 10, bottom: 5, left: 5, right: 5)
          : EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      height: 100,
      color: Colors.grey[50],
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: getFirviteStateIcon(context),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(data.title,style: Theme.of(context).textTheme.subtitle.copyWith(color: Theme.of(context).primaryColor),maxLines: 1,overflow: TextOverflow.ellipsis),
                  SizedBox(height: 8),
                  Text(data.desc,style: Theme.of(context).textTheme.body1.copyWith(color: Theme.of(context).accentColor),maxLines: 1,overflow: TextOverflow.ellipsis),
                 Padding(
                   padding: const EdgeInsets.only(top: 8.0),
                   child: Row(
                     children: <Widget>[
                     ]..addAll(getAuth(context)),
                   ),
                 )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Icon getFirviteStateIcon(BuildContext context) {
    return data.collect == true
        ? Icon(Icons.sentiment_very_satisfied, color: Theme.of(context).primaryColor)
        : Icon(Icons.sentiment_dissatisfied);
  }

  List<Widget> getAuth(BuildContext context){

    List<Widget> widgets =[];

    if(data.author?.isNotEmpty==true){
      widgets.add(Container(width :200,child: Text('作者：${data.author}',overflow: TextOverflow.ellipsis,)));
    }

    if(data.shareUser?.isNotEmpty==true){
      widgets.add(Container(width :200,child: Text('分享人：${data.shareUser}',overflow: TextOverflow.ellipsis,)));
    }

    if(data.niceDate?.isNotEmpty==true){
      widgets.add(Expanded(child: SizedBox(),));
      widgets.add(Text('${data.niceDate}'));
    }

    return widgets;
  }
}

class HomeIndexArticleItemPlaceHolderWidget extends StatelessWidget {
  final int index;

  HomeIndexArticleItemPlaceHolderWidget({this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: index == 0
          ? EdgeInsets.only(top: 10, bottom: 5, left: 5, right: 5)
          : EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      color: Colors.grey,
    );
  }
}
