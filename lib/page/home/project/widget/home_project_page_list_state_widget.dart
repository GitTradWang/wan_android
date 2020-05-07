import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomeProjectPageListLoadingWidget extends StatelessWidget {

  static const double ITEM_HEIGHT =10;

  @override
  Widget build(BuildContext context) {
    return SliverLayoutBuilder(
      builder: (BuildContext context, SliverConstraints constraints) {
        return SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.all(10),
            height: constraints.viewportMainAxisExtent,
            child: GridView.count(
              crossAxisCount: 2,
              physics: NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              childAspectRatio:0.7,
              mainAxisSpacing: 10,
              children: <Widget>[
                Container(
                  color: Colors.green,
                ),
                Container(
                  color: Colors.red,
                ),
                Container(
                  color: Colors.blueAccent,
                ),
                Container(
                  color: Colors.green,
                ),
                Container(
                  color: Colors.red,
                ),
                Container(
                  color: Colors.blue,
                ),
                Container(
                  color: Colors.green,
                ),
                Container(
                  color: Colors.red,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class HomeProjectPageListEmptWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return null;
  }
}
