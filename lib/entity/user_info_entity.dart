import 'package:flutterprojectsample/generated/json/base/json_convert_content.dart';

class UserInfoEntity with JsonConvert<UserInfoEntity> {
  String userName;
  String userNick;
  String id;
}
