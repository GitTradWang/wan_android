import 'package:fluro/fluro.dart';

import 'app_router_handler.dart';

class RouterName {
  static const indexPage = '/';
  static const homePage = '/homePage';
  static const loginPage = '/loginPage';
  static const uiSamplePage = '/uiSamplePage';
}

void defineRoutes(Router router) {
  router.notFoundHandler = notFoundHandler;
  router.define(RouterName.indexPage, handler: indexPageHandler);
  router.define(RouterName.homePage, handler: homePageHandler);
  router.define(RouterName.uiSamplePage, handler: uiSamplePageHandler);
  router.define(RouterName.loginPage, handler: loginPageHandler);
}
