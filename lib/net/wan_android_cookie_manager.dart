import 'dart:async';
import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:wanandroidflutter/net/request_urls.dart';

class WanAndroidCookieManager extends Interceptor {
  final CookieJar cookieJar;

  static const invalidCookieValue = "_invalid_";

  bool needNormalize = false;

  WanAndroidCookieManager(this.cookieJar) {
    try {
      Cookie.fromSetCookieValue("k=;");
    } catch (e) {
      needNormalize = true;
    }
  }

  @override
  FutureOr<dynamic> onRequest(RequestOptions options) {
    var cookies = cookieJar.loadForRequest(options.uri);
    cookies.removeWhere((cookie) => cookie.value == invalidCookieValue && cookie.expires.isBefore(DateTime.now()));
    cookies.addAll(options.cookies);
    String cookie = getCookies(cookies);
    if (cookie.isNotEmpty) options.headers[HttpHeaders.cookieHeader] = cookie;
  }

  @override
  FutureOr<dynamic> onResponse(Response response) => _saveCookies(response);

  @override
  FutureOr<dynamic> onError(DioError err) => _saveCookies(err.response);

  _saveCookies(Response response) {
    if (response != null && response.headers != null) {
      List<String> cookies = response.headers[HttpHeaders.setCookieHeader];
      if (cookies != null) {
        if (needNormalize) {
          var _cookies = normalizeCookies(cookies);
          cookies
            ..clear()
            ..addAll(_cookies);
        }
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

  static List<String> normalizeCookies(List<String> cookies) {
    if (cookies != null) {
      const String expires = " Expires=Thu, 01 Jan 1970 00:00:00 GMT";
      return cookies.map((cookie) {
        var _cookie = cookie.split(";");
        var kv = _cookie.first?.split("=");
        if (kv != null && kv[1].isEmpty) {
          kv[1] = invalidCookieValue;
          _cookie[0] = kv.join('=');
          if (_cookie.length > 1) {
            int i = 1;
            while (i < _cookie.length) {
              if (_cookie[i].trim().toLowerCase().startsWith("expires")) {
                _cookie[i] = expires;
                break;
              }
              ++i;
            }
            if (i == _cookie.length) {
              _cookie.add(expires);
            }
          }
        }
        return _cookie.join(";");
      }).toList();
    }
    return [];
  }

  bool isAuth() {
    var cookies = cookieJar.loadForRequest(Uri.parse(URL_BASE));
    cookies.removeWhere((cookie) => cookie.value == invalidCookieValue && cookie.expires.isBefore(DateTime.now()));
    String cookie = getCookies(cookies);
    if (cookie.contains('token_pass=') || cookie.contains('token_pass_wanandroid_com=')) {
      return true;
    } else {
      return false;
    }
  }
}
