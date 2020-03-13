import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class Net {
  static Net _instance;

  Dio _dio;

  String _cookieCachePath;

  Net._();

  static Net get instance => _instance ?? (_instance = Net._());

  Future<void> init({String baseUrl}) async {
    _cookieCachePath = '${(await getApplicationDocumentsDirectory()).path}/cookie/';
    BaseOptions _options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 3000,
      receiveTimeout: 3000,
      responseType: ResponseType.json,
      contentType: ContentType.json,
    );
    _dio = Dio(_options);
    _dio.interceptors.add(CookieManager(PersistCookieJar(dir: _cookieCachePath)));
    _dio.interceptors.add(LogInterceptor());
  }

  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onReceiveProgress,
  }) async {
    try {
      return _parseResponse(await _dio.get<Map<String, dynamic>>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      ));
    } on DioError catch (e) {
      throw Exception(_formatError(e));
    } on Exception {
      throw Exception('网络错误，请稍后再试');
    }
  }

  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic> params,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
  }) async {
    try {
      return _parseResponse(await _dio.post<Map<String, dynamic>>(
        path,
        data: params,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      ));
    } on DioError catch (e) {
      throw Exception(_formatError(e));
    } on Exception {
      throw Exception('网络错误，请稍后再试');
    }
  }

  Future<Map<String, dynamic>> postForm(
    String path, {
    FormData data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
  }) async {
    try {
      return _parseResponse(await _dio.post<Map<String, dynamic>>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      ));
    } on DioError catch (e) {
      throw Exception(_formatError(e));
    } on Exception {
      throw Exception('网络错误，请稍后再试');
    }
  }

  Map<String, dynamic> _parseResponse(Response<Map<String, dynamic>> response) {
    if (_isSuccess(response)) {
      return response.data;
    } else {
      throw Exception(_parseNetStatusCode(response));
    }
  }

  String _formatError(DioError e) {
    switch (e.type) {
      case DioErrorType.CONNECT_TIMEOUT:
        return "网络连接超时";
        break;
      case DioErrorType.SEND_TIMEOUT:
        return "网络请求超时";
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        return "服务器响应超时";
        break;
      case DioErrorType.RESPONSE:
        return "服务器响应异常";
        break;
      case DioErrorType.CANCEL:
        return "取消网络请求";
        break;
      case DioErrorType.DEFAULT:
      default:
        return "未知网络错误";
        break;
    }
  }

  String _parseNetStatusCode(Response response) {
    String statusMessage = '';

    //200
    if (response.statusCode >= 200 && response.statusCode < 300) {
      statusMessage = '请求成功';
    }
    //300
    if (response.statusCode >= 300 && response.statusCode < 400) {
      statusMessage = '请求被重定向，请稍后再试';
    }
    //400
    if (response.statusCode >= 400 && response.statusCode < 500) {
      statusMessage = '请求错误,请检查网络再试';
    }
    //500
    if (response.statusCode >= 500) {
      statusMessage = '服务器错误,请稍后再试';
    }
    return statusMessage;
  }

  bool _isSuccess(Response response) {
    return response.statusCode >= 200 && response.statusCode < 300;
  }
}
