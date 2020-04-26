import 'package:flutter/material.dart';
import 'package:wanandroidflutter/config/app_navigator.dart';
import 'package:wanandroidflutter/config/app_router.dart';
import 'package:wanandroidflutter/model/user_model.dart';
import 'package:wanandroidflutter/widget/loading_dialog.dart';

class HomeIndexPage extends StatefulWidget {
  @override
  _HomeIndexPageState createState() => _HomeIndexPageState();
}

class _HomeIndexPageState extends State<HomeIndexPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('首页'),
      ),
      body: Column(
        children: <Widget>[
          MaterialButton(
            color: Theme
                .of(context)
                .primaryColor,
            onPressed: () {
              if (!UserModel.instance.isAuth) {
                AppNavigator.navigateTo(context, RouterName.loginPage);
              } else {
                UserModel.instance.logout();
              }
            },
            child: Text(UserModel.instance.isAuth ? '退出登录' : '跳转到登录'),
          ),
          SizedBox(
            height: 20,
          ),
          MaterialButton(
            color: Theme
                .of(context)
                .primaryColor,
            onPressed: () => LoadingDialog.show(context),
            child: Text('显示加载中'),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
