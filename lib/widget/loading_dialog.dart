import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroidflutter/config/app_navigator.dart';

class LoadingDialog {
  ///弹出
  static Future<void> show(BuildContext context, {backDismiss = true}) async {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => WillPopScope(
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            height: 120,
            width: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                CupertinoActivityIndicator(
                  radius: 15,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  '加载中',
                  style: Theme.of(context).textTheme.subhead,
                ),
              ],
            ),
          ),
        ),
        onWillPop: () async => backDismiss,
      ),
    );
  }

  ///取消弹窗
  static bool dismiss(BuildContext context) {
    //防止误杀页面
    if (AppNavigator.appNavigatorManager.currentIsDialog()) {
      return Navigator.of(context).pop();
    }
    return false;
  }
}
