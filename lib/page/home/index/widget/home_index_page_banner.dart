import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wanandroidflutter/entity/base_entity.dart';
import 'package:wanandroidflutter/entity/home_index_banner_entity.dart';
import 'package:wanandroidflutter/net/wan_android_api.dart';
import 'package:wanandroidflutter/utils/debug_log.dart';
import 'package:wanandroidflutter/utils/toast.dart';
import 'package:wanandroidflutter/widget/cache_image.dart';

class HomeIndexPageBanner extends StatefulWidget {
  final HomeIndexPageBannerControler controler;

  HomeIndexPageBanner({this.controler});

  @override
  _HomeIndexPageBannerState createState() => _HomeIndexPageBannerState();
}

class _HomeIndexPageBannerState extends State<HomeIndexPageBanner> {
  List<HomeIndexBannerEntity> banners = [];

  @override
  void initState() {
    super.initState();
    WanAndroidApi.get<List<HomeIndexBannerEntity>>('banner/json').then((data) {
      setState(() {
        banners = data.data;
      });
    }).catchError((error) {
      showToast(message: error.message);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.controler != null) {
      widget.controler._bindState(this);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: banners.length == 0
          ? Container(
              height: 200,
              color: Colors.grey[200],
            )
          : Swiper.list(
              list: banners,
              autoplay: true,
              onTap: (int inedex) => log(banners[inedex].title),
              builder: (BuildContext context, dynamic data, int index) =>
                  _BannerItemWidget(bannerEntity: data),
              pagination: new SwiperPagination(
                  alignment: Alignment.bottomRight,
                  builder: SwiperPagination.dots),
            ),
    );
  }

  Future<void> refresh(bool fromNet) async {
    BaseEntity<List<HomeIndexBannerEntity>> baseEntity =
        await WanAndroidApi.get<List<HomeIndexBannerEntity>>('banner/json');
    setState(() {
      banners = baseEntity.data;
    });
    return;
  }
}

class _BannerItemWidget extends StatelessWidget {
  final HomeIndexBannerEntity bannerEntity;

  _BannerItemWidget({this.bannerEntity});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: CacheImage(
            height: 200,
            width: double.infinity,
            url: bannerEntity.imagePath,
            borderRadius: BorderRadius.zero,
            fit: BoxFit.cover,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            color: Color(0x33F5F5F5),
            child: Text(bannerEntity.title),
          ),
        )
      ],
    );
  }
}

class HomeIndexPageBannerControler {
  _HomeIndexPageBannerState _bannerState;

  Future<void> refresh({bool fromNet = true}) {
    return _bannerState.refresh(fromNet);
  }

  void _bindState(_HomeIndexPageBannerState _homeIndexPageBannerState) {
    this._bannerState = _homeIndexPageBannerState;
  }

  void dispose() {
    _bannerState = null;
  }
}
