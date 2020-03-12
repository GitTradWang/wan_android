import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojectsample/page/home/home_page.dart';
import 'package:flutterprojectsample/page/splash_page.dart';
import 'package:flutterprojectsample/page/ui_sample_page.dart';

Handler notFoundHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return ErrorWidget.withDetails(
    message: 'ROUTE WAS NOT FOUND !!!',
  );
});

Handler indexPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return SplashPage();
});

Handler homePageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return HomePage();
});
Handler uiSamplePageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return UISamplePage();
});
