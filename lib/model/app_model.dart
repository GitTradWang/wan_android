import 'package:flutter/material.dart';
import 'package:flutterprojectsample/config/app_navigator.dart';
import 'package:flutterprojectsample/constants/cache_constants_key.dart';
import 'package:flutterprojectsample/model/user_model.dart';
import 'package:flutterprojectsample/utils/preference_manager.dart';
import 'package:provider/provider.dart';

class AppModel extends ChangeNotifier {
  ///TOKEN令牌
  String _token;

  static AppModel get instance {
    return Provider.of<AppModel>(AppNavigator.navigatorKey.currentContext, listen: false);
  }

  Future init() async {
    String token = await PreferenceManager.getString(CacheKey.TOKEN);
    _token = token;
  }

  void setToken(String token) {
    this._token = token;
    UserModel.instance?.updateUserInfoFormNet();
    notifyListeners();
  }

  String get token => _token;

  void cleanToken() {
    this._token = null;
    UserModel.instance?.clearUserInfo();
    notifyListeners();
  }

  bool isAuth() {
    return _token != null;
  }
}
