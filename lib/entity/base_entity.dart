import 'package:wanandroidflutter/generated/json/base/json_convert_content.dart';

class BaseEntity<T> {
  int errorCode;
  String errorMsg;
  T data;
  BaseEntity.fromJson(Map<String, dynamic> map)
      : errorCode = map['errorCode'],
        errorMsg = map['errorMsg'],
        data = JsonConvert.fromJsonAsT<T>(map['data']);
}
