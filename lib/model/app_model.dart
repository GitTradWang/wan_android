import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanandroidflutter/config/app_navigator.dart';

class AppModel extends ChangeNotifier {

  static AppModel get instance {
    return Provider.of<AppModel>(AppNavigator.navigatorKey.currentContext, listen: false);
  }

  Future<void> init() async {

  }
}
