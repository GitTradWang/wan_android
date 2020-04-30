import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'image_state_widget.dart';

class CacheImage extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final BoxFit fit;
  final BorderRadius borderRadius;

  CacheImage({
    @required this.url,
    this.width,
    this.height,
    this.fit,
    this.borderRadius = const BorderRadius.all(Radius.circular(5)),
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: CachedNetworkImage(
        fit: fit,
        imageUrl: url ?? '',
        height: height,
        width: width,
        errorWidget: (context, url, error) => ImageErrorWidget(width: width, height: height),
        placeholder: (context, url) => ImageLoadingWidget(width: width, height: height),
      ),
    );
  }
}
