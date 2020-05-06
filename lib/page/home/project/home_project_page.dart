import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:wanandroidflutter/page/home/project/HomeProjectPageModel.dart';
import 'package:wanandroidflutter/page/home/project/widget/home_project_page_list_item_widget.dart';
import 'package:wanandroidflutter/page/home/project/widget/home_project_page_list_state_widget.dart';
import 'package:wanandroidflutter/widget/provider/provider_state_widget.dart';

class HomeProjectPage extends StatefulWidget {
  HomeProjectPage({Key key}) : super(key: key);

  @override
  _HomeProjectPageState createState() => _HomeProjectPageState();
}

class _HomeProjectPageState extends State<HomeProjectPage>
    with AutomaticKeepAliveClientMixin {
  HomeProjectPageModel _homeProjectPageModel = HomeProjectPageModel();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('项目'),
        centerTitle: true,
      ),
      body: EasyRefresh.custom(
        slivers: [
          ProviderStatePageWidget<HomeProjectPageModel>(
            create: (BuildContext context) => _homeProjectPageModel,
            loadingBuilder:
                (BuildContext context, HomeProjectPageModel model) =>
                    SliverToBoxAdapter(
              child: HomeProjectPageListLoadingWidget(),
            ),
            child: SliverList(
              delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) =>
                      HomeProjectPageListItemWidget(),
                  childCount: 15),
            ),
          ),
        ],
        topBouncing: true,
        bottomBouncing: false,
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 5));
          _homeProjectPageModel.showContent();
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
