import 'dart:async';

import 'package:dio/dio.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

///页面路由跳转
class AppNavigator {
  static final Router _router = Router.appRouter;
  static final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  static final _AppNavigatorObserverManager _navigatorObserver = _AppNavigatorObserverManager();

  static Router get router => _router;
  static GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
  static _AppNavigatorObserverManager get appNavigatorManager => _navigatorObserver;

  ///跳转页面 [routerName] 路由名 [arguments] 参数 [replace] 是否替换当前页面 [clearStack] 是否清除路由栈 [transition] 页面切换样式 [transitionDuration] 时间 [transitionBuilder] 自定义切换样式
  ///默认使用主题中自带的切换样式
  static Future<dynamic> navigateTo(
    BuildContext context,
    String routerName, {
    Map<String, dynamic> arguments,
    bool replace = false,
    bool clearStack = false,
    TransitionType transition = TransitionType.native,
    Duration transitionDuration = const Duration(milliseconds: 250),
    RouteTransitionsBuilder transitionBuilder,
  }) {
    String path = suffixArguments(routerName, arguments: arguments); //拼接参数
    return router.navigateTo(
      context,
      path,
      replace: replace,
      clearStack: clearStack,
      transition: transition,
      transitionDuration: transitionDuration,
      transitionBuilder: transitionBuilder,
    );
  }

  ///不使用context跳转页面（这种跳转因为使用Navigator的context，所以在RouteHandler中的context不是跳转的context）
  ///谨慎使用，非特殊原因不建议使用此方法
  static Future<dynamic> navigateToWithoutContext(
    String routerName, {
    Map<String, dynamic> arguments,
    bool replace = false,
    bool clearStack = false,
    TransitionType transition = TransitionType.native,
    Duration transitionDuration = const Duration(milliseconds: 250),
    RouteTransitionsBuilder transitionBuilder,
  }) {
    String path = suffixArguments(routerName, arguments: arguments); //拼接参数
    RouteMatch routeMatch = router.matchRoute(
      navigatorKey.currentContext,
      path,
      transitionType: transition,
      transitionsBuilder: transitionBuilder,
      transitionDuration: transitionDuration,
    );
    Route<dynamic> route = routeMatch.route;
    Completer completer = Completer();
    Future future = completer.future;
    if (routeMatch.matchType == RouteMatchType.nonVisual) {
      completer.complete("Non visual route type.");
    } else {
      if (route == null && router.notFoundHandler != null) {
        route = _notFoundRoute(null, path);
      }
      if (route != null) {
        if (clearStack) {
          future = navigatorKey.currentState.pushAndRemoveUntil(route, (check) => false);
        } else {
          future = replace ? navigatorKey.currentState.pushReplacement(route) : _navigatorKey.currentState.push(route);
        }
        completer.complete();
      } else {
        String error = "No registered route was found to handle '$path'.";
        print(error);
        completer.completeError(RouteNotFoundException(error, path));
      }
    }
    return future;
  }

  /// 拼接参数符合fluro命名规则 [routerName] 路由名称 [arguments] 参数
  /// 最终会拼接成 routerName?aaa=111&bbb=222 形式
  static suffixArguments(String routerName, {Map<String, dynamic> arguments = const {}}) {
    String paramStr = Transformer.urlEncodeMap(arguments);
    return routerName.endsWith('?') ? '$routerName$paramStr' : '$routerName?$paramStr';
  }

  static Route<Null> _notFoundRoute(BuildContext context, String path) {
    RouteCreator<Null> creator = (RouteSettings routeSettings, Map<String, List<String>> parameters) {
      return MaterialPageRoute<Null>(
          settings: routeSettings,
          builder: (BuildContext context) {
            return router.notFoundHandler.handlerFunc(context, parameters);
          });
    };
    return creator(RouteSettings(name: path), null);
  }
}

class _AppNavigatorObserverManager extends NavigatorObserver {
  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPush(route, previousRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didStopUserGesture() {
    super.didStopUserGesture();
  }

  @override
  void didStartUserGesture(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didStartUserGesture(route, previousRoute);
  }
}
