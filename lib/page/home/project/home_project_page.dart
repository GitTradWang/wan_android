import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:provider/provider.dart';
import 'package:wanandroidflutter/page/home/project/HomeProjectPageModel.dart';
import 'package:wanandroidflutter/page/home/project/widget/home_project_page_list_item_widget.dart';
import 'package:wanandroidflutter/page/home/project/widget/home_project_page_list_state_widget.dart';
import 'package:wanandroidflutter/widget/provider/provider_state_widget.dart';

class HomeProjectPage extends StatefulWidget {
  HomeProjectPage({Key key}) : super(key: key);

  @override
  _HomeProjectPageState createState() => _HomeProjectPageState();
}

class _HomeProjectPageState extends State<HomeProjectPage> with AutomaticKeepAliveClientMixin {
  HomeProjectPageModel _homeProjectPageModel = HomeProjectPageModel();

  @override
  void initState() {
    super.initState();
    _homeProjectPageModel.loadProjectList(first: true);
  }

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
            loadingBuilder: (BuildContext context, HomeProjectPageModel model) => HomeProjectPageListLoadingWidget(),
            child: SliverPadding(
              sliver: Consumer<HomeProjectPageModel>(
                builder: (BuildContext context, HomeProjectPageModel value, Widget child) => SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.6,
                    crossAxisSpacing: 10,
                  ),
                  delegate: SliverChildBuilderDelegate((BuildContext context, int index) => HomeProjectPageListItemWidget(_homeProjectPageModel.list[index]),
                      childCount: _homeProjectPageModel.list.length),
                ),
              ),
              padding: EdgeInsets.all(10),
            ),
          ),
        ],
        topBouncing: true,
        bottomBouncing: false,
        onLoad: () => _homeProjectPageModel.loadMore(),
        onRefresh: () => _homeProjectPageModel.refresh(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
