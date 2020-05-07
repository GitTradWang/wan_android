import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:screen_ratio_adapter/screen_ratio_adapter.dart';
import 'package:wanandroidflutter/config/app_navigator.dart';
import 'package:wanandroidflutter/config/app_router.dart';
import 'package:wanandroidflutter/config/app_theme.dart';
import 'package:wanandroidflutter/model/app_model.dart';
import 'package:wanandroidflutter/model/user_model.dart';
import 'package:wanandroidflutter/page/splash/splash_page.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main() {
  runFxApp(App(), uiSize: Size(385, 685));
  _init();
}

_init() {
  defineRoutes(AppNavigator.router);
  if (Platform.isAndroid) {
    //透明状态栏
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();

    EasyRefresh.defaultFooter = ClassicalFooter(
      loadedText: '加载完成',
      noMoreText: '没有更多了',
      loadingText: '加载中 . .',
      loadFailedText: '加载失败',
      infoText: '最后更新时间 %T',
      enableInfiniteLoad: true,
      enableHapticFeedback: false,
    );
    EasyRefresh.defaultHeader = ClassicalHeader(
      refreshText: "下拉刷新",
      refreshedText: '刷新成功',
      refreshFailedText: '刷新失败',
      refreshingText: '刷新中 . .',
      refreshReadyText: '释放刷新',
      infoText: '最后更新时间 %T',
      enableHapticFeedback: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<AppModel>(
            create: (BuildContext context) => AppModel()),
        ChangeNotifierProvider<UserModel>(
            create: (BuildContext context) => UserModel()),
      ],
      child: MaterialApp(
        title: '玩安卓',
        theme: AppTheme.theme,
        darkTheme: AppTheme.darkTheme,
        home: SplashPage(),
        themeMode: ThemeMode.system,
        navigatorKey: AppNavigator.navigatorKey,
        onGenerateRoute: (RouteSettings settings) =>
            AppNavigator.router.generator(settings),
        debugShowCheckedModeBanner: false,
        navigatorObservers: [AppNavigator.appNavigatorManager],
      ),
    );
  }
}
