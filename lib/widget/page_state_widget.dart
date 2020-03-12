import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroidflutter/r.dart';
import 'package:shimmer/shimmer.dart';

class PageLoadingWidget extends StatelessWidget {
  final String text;
  final Color backgroundColor;

  PageLoadingWidget({this.text = '加载中', this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        var maxHeight = constraints.maxHeight;
        var maxWidth = constraints.maxWidth;

        var min = math.min(maxWidth, maxHeight);

        var imageHeight = min / 5;
        var textOffset = imageHeight / 2 / 3;
        var textSize = imageHeight / 2 / 2.5;

        return Container(
          color: backgroundColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.bottomCenter,
                  height: imageHeight,
                  child: CupertinoActivityIndicator(
                    radius: imageHeight / 6,
                  ),
                ),
                SizedBox(
                  height: textOffset,
                ),
                Text(
                  text,
                  style: TextStyle(fontSize: textSize),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

/// List列表加载中动画
class PageLoadingListWidget extends StatelessWidget {
  ///padding
  final EdgeInsetsGeometry padding;

  ///列表个数
  final int length;

  ///每个条目加载中的样式
  final IndexedWidgetBuilder builder;

  PageLoadingListWidget({
    @required this.builder,
    this.length: 7,
    this.padding = const EdgeInsets.all(7),
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[100],
        highlightColor:Colors.grey[200],
        period: const Duration(milliseconds: 2000),
        direction: ShimmerDirection.ttb,
        child: Padding(
          padding: padding,
          child: Column(
            children: List.generate(length, (index) => builder(context, index)),
          ),
        ),
      ),
    );
  }
}

class PageEmptyWidget extends StatelessWidget {
  final String text;
  final String imageAssert;
  final Color backgroundColor;

  PageEmptyWidget({this.text = '暂无数据', this.backgroundColor, this.imageAssert = Img.ICON_EMPTY_DATA_BG});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        var maxHeight = constraints.maxHeight;
        var maxWidth = constraints.maxWidth;
        var min = math.min(maxWidth, maxHeight);

        var imageHeight = min / 5;
        var textOffset = imageHeight / 2 / 3;
        var textSize = imageHeight / 2 / 2.5;

        return Container(
          color: backgroundColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  imageAssert,
                  height: imageHeight,
                ),
                SizedBox(
                  height: textOffset,
                ),
                Text(
                  text,
                  style: TextStyle(fontSize: textSize),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class PageErrorWidget extends StatelessWidget {
  final String text;
  final String imageAssert;
  final Color backgroundColor;

  final VoidCallback callback;

  PageErrorWidget({this.callback, this.text = '加载失败', this.backgroundColor, this.imageAssert = Img.ICON_EMPTY_DATA_BG});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          var maxHeight = constraints.maxHeight;
          var maxWidth = constraints.maxWidth;

          var min = math.min(maxWidth, maxHeight);

          var imageHeight = min / 5;
          var textOffset = imageHeight / 2 / 3;
          var textSize = imageHeight / 2 / 2.5;

          return Container(
            color: backgroundColor,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    imageAssert,
                    height: imageHeight,
                  ),
                  SizedBox(
                    height: textOffset,
                  ),
                  Text(
                    text,
                    style: TextStyle(fontSize: textSize),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
