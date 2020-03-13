import 'package:dio/dio.dart';
import 'package:wanandroidflutter/entity/base_entity.dart';
import 'package:wanandroidflutter/net/request_urls.dart';
import 'package:wanandroidflutter/utils/net_request.dart';

class WanAndroidApi {
  static Future<void> init() async {
    return await Net.instance.init(baseUrl: URL_BASE);
  }

  static Future<T> get<T>(
    String path, {
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onReceiveProgress,
  }) async {
    Map<String, dynamic> response = await Net.instance.get(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
    return _tran2Entity<T>(response);
  }

  static Future<T> post<T>(
    String path, {
    Map<String, dynamic> params,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
  }) async {
    Map<String, dynamic> response = await Net.instance.post(
      path,
      params: params,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    return _tran2Entity<T>(response);
  }

  static Future<T> postFrom<T>(
    String path, {
    FormData data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
  }) async {
    Map<String, dynamic> response = await Net.instance.postForm(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
    return _tran2Entity<T>(response);
  }

  static T _tran2Entity<T>(Map<String, dynamic> response) {
    var errorMsg = response['errorMsg'];
    var errorCode = response['errorCode'];

    if (errorCode.toInt() != 0) {
      throw Exception(errorMsg);
    }
    return BaseEntity<T>.fromJson(response).data;
  }
}
