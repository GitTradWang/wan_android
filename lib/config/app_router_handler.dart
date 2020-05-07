import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:wanandroidflutter/page/home/home_page.dart';
import 'package:wanandroidflutter/page/login/login_page.dart';
import 'package:wanandroidflutter/page/login/register_page.dart';
import 'package:wanandroidflutter/page/not_found_page.dart';
import 'package:wanandroidflutter/page/splash/splash_page.dart';
import 'package:wanandroidflutter/page/ui_sample_page.dart';

Handler notFoundHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return NotFoundPage();
});

Handler indexPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return SplashPage();
});

Handler homePageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return HomePage();
});
Handler uiSamplePageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return UISamplePage(url: parameters['url']?.first);
});
Handler loginPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return LoginPage();
});
Handler registerPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return RegisterPage();
});
