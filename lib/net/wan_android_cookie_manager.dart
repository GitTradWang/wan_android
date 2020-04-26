import 'dart:async';
import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:wanandroidflutter/net/request_urls.dart';

class WanAndroidCookieManager extends Interceptor {
  final CookieJar cookieJar;

  WanAndroidCookieManager(this.cookieJar);

  @override
  Future onRequest(RequestOptions options) async {
    var cookies = cookieJar.loadForRequest(options.uri);
    cookies.removeWhere((cookie) {
      if (cookie.expires != null) {
        return cookie.expires.isBefore(DateTime.now());
      }
      return false;
    });
    String cookie = getCookies(cookies);
    if (cookie.isNotEmpty) options.headers[HttpHeaders.cookieHeader] = cookie;
  }

  @override
  Future onResponse(Response response) async => _saveCookies(response);

  @override
  Future onError(DioError err) async => _saveCookies(err.response);

  _saveCookies(Response response) {
    if (response != null && response.headers != null) {
      List<String> cookies = response.headers[HttpHeaders.setCookieHeader];
      if (cookies != null) {
        cookieJar.saveFromResponse(
          response.request.uri,
          cookies.map((str) => Cookie.fromSetCookieValue(str)).toList(),
        );
      }
    }
  }

  static String getCookies(List<Cookie> cookies) {
    return cookies.map((cookie) => "${cookie.name}=${cookie.value}").join('; ');
  }

  bool isAuth() {
    var cookies = cookieJar.loadForRequest(Uri.parse(URL_BASE));
    cookies.removeWhere((cookie) => cookie?.expires?.isBefore(DateTime.now()));
    String cookie = getCookies(cookies);
    if (cookie.contains('token_pass=') || cookie.contains('token_pass_wanandroid_com=')) {
      return true;
    } else {
      return false;
    }
  }
}
