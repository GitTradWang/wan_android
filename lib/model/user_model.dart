import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wanandroidflutter/config/app_navigator.dart';
import 'package:wanandroidflutter/constants/cache_constants_key.dart';
import 'package:wanandroidflutter/entity/user_info_entity.dart';
import 'package:wanandroidflutter/utils/cache_manager.dart';
import 'package:provider/provider.dart';

class UserModel extends ChangeNotifier {
  ///用户信息
  UserInfoEntity _userInfoEntity;

  UserInfoEntity get userInfo => _userInfoEntity;

  static UserModel get instance {
    return Provider.of<UserModel>(AppNavigator.navigatorKey.currentContext, listen: false);
  }

  Future<void> init() async {
    String userInfoStr = await CacheManager.instance.getCache(CacheKey.USER_INFO)??'{}';
    _userInfoEntity = UserInfoEntity().fromJson(jsonDecode(userInfoStr));
  }

  Future<void> updateUserInfoFormNet() async {
    notifyListeners();
  }

  Future<bool> updateUserInfo(UserInfoEntity userInfoEntity) async {
    await CacheManager.instance.setCache(CacheKey.USER_INFO, jsonEncode(userInfoEntity.toJson()), forever: true);
    this._userInfoEntity = userInfoEntity;
    notifyListeners();
    return true;
  }

  Future<bool> clearUserInfo() async {
    await CacheManager.instance.delete(CacheKey.USER_INFO);
    _userInfoEntity = null;
    notifyListeners();
    return true;
  }
}
