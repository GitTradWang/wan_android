import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:provider/provider.dart';
import 'package:wanandroidflutter/page/home/index/widget/home_index_article_item.dart';
import 'package:wanandroidflutter/page/home/index/widget/home_index_page_banner.dart';
import 'package:wanandroidflutter/page/home/index/home_index_page_model.dart';
import 'package:wanandroidflutter/widget/page_state_widget.dart';
import 'package:wanandroidflutter/widget/provider/base_page_widget.dart';

class HomeIndexPage extends StatefulWidget {
  @override
  _HomeIndexPageState createState() => _HomeIndexPageState();
}

class _HomeIndexPageState extends State<HomeIndexPage>
    with AutomaticKeepAliveClientMixin {
  HomeIndexPageListModel _homeIndexPageListModel = HomeIndexPageListModel();
  HomeIndexPageBannerControler _bannerControler = HomeIndexPageBannerControler();

  @override
  void initState() {
    super.initState();
    _homeIndexPageListModel.getArticleListData(first: true);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(

      appBar: AppBar(
        title: Text('首页'),
        centerTitle: true,
      ),

      body: EasyRefresh.custom(
        topBouncing: true,
        bottomBouncing: false,
        onRefresh: () async {
          await _bannerControler.refresh();
          await _homeIndexPageListModel.refresh();
        },
        onLoad: () async => await _homeIndexPageListModel.loadMore(),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: HomeIndexPageBanner(controler: _bannerControler),
          ),
          BaseProviderPageWidget<HomeIndexPageListModel>(
            create: (BuildContext context) => _homeIndexPageListModel,
            errorBuilder: (context, model) => SliverToBoxAdapter(child: PageErrorWidget()),
            emptyBuilder: (context, model) => SliverToBoxAdapter(child: PageEmptyWidget()),
            loadingBuilder: (context, model) => SliverToBoxAdapter(
              child: PageLoadingListWidget(
                length: 20,
                builder: (BuildContext context, int index) => HomeIndexArticleItemPlaceHolderWidget(index: index),
              ),
            ),
            child: Consumer<HomeIndexPageListModel>(
              builder: (BuildContext context, HomeIndexPageListModel value,
                  Widget child) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) => HomeIndexArticleItemWidget(index: index, data: value.datas[index]),
                    childCount: _homeIndexPageListModel.datas.length,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
    _bannerControler.dispose();
    _homeIndexPageListModel.dispose();
  }
}
