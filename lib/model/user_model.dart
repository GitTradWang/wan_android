import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanandroidflutter/config/app_navigator.dart';
import 'package:wanandroidflutter/constants/cache_constants_key.dart';
import 'package:wanandroidflutter/entity/user_info_entity.dart';
import 'package:wanandroidflutter/net/request_urls.dart';
import 'package:wanandroidflutter/net/wan_android_api.dart';
import 'package:wanandroidflutter/utils/cache_manager.dart';

class UserModel extends ChangeNotifier {
  ///用户信息
  UserInfoEntity _userInfoEntity;

  UserInfoEntity get userInfo => _userInfoEntity;

  bool get isAuth => WanAndroidApi.isAuth();

  static UserModel get instance {
    return Provider.of<UserModel>(AppNavigator.navigatorKey.currentContext, listen: false);
  }

  Future<void> init() async {
    _userInfoEntity = UserInfoEntity().fromJson(jsonDecode(await CacheManager.instance.getCache(CacheKey.USER_INFO) ?? '{}'));
  }

  Future<bool> updateUserInfo(UserInfoEntity userInfoEntity) async {
    await CacheManager.instance.setCache(CacheKey.USER_INFO, jsonEncode(userInfoEntity.toJson()), forever: true);
    this._userInfoEntity = userInfoEntity;
    notifyListeners();
    return true;
  }

  Future<bool> logout({CancelToken cancelToken}) async {
    await WanAndroidApi.get(URL_LOGOUT);
    await CacheManager.instance.delete(CacheKey.USER_INFO);
    _userInfoEntity = null;
    notifyListeners();
    return true;
  }

  Future<UserInfoEntity> login(String username, String password,{CancelToken cancelToken}) async {
    var entity = await WanAndroidApi.postFrom<UserInfoEntity>(
      URL_LOGIN,
      data: FormData.fromMap({
        'username': username,
        'password': password,
      }),
      cancelToken: cancelToken
    );
    await updateUserInfo(entity.data);
    return entity.data;
  }

  Future<UserInfoEntity> register(String username, String password,{CancelToken cancelToken}) async {
    var entity = await WanAndroidApi.postFrom<UserInfoEntity>(
      URL_REGISTER,
      data: FormData.fromMap({
        'username': username,
        'password': password,
        'repassword': password,
      }),
      cancelToken: cancelToken
    );

    await updateUserInfo(entity.data);
    return entity.data;
  }
}
