import 'package:wanandroidflutter/model/app_model.dart';
import 'package:wanandroidflutter/model/user_model.dart';
import 'package:wanandroidflutter/net/wan_android_api.dart';

class Application {
  static Future<void> init() async {
    await WanAndroidApi.init();
    await AppModel.instance.init();
    await UserModel.instance.init();
  }
}
