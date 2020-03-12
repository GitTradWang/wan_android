import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ImageErrorWidget extends StatelessWidget {
  final double width;
  final double height;

  ImageErrorWidget({this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Theme.of(context).dividerColor),
      height: height,
      width: width,
      child: Center(),
    );
  }
}

class ImageLoadingWidget extends StatelessWidget {
  final double width;
  final double height;

  ImageLoadingWidget({this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[100],
      highlightColor:Colors.grey[200],
      direction: ShimmerDirection.ttb,
      period: const Duration(milliseconds: 2000),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Theme.of(context).dividerColor),
        height: height,
        width: width,
        child: Center(),
      ),
    );
  }
}
