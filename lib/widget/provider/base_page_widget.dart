import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanandroidflutter/widget/page_state_widget.dart';

typedef ChildBuilder<T extends BaseProviderModel> = Widget Function(
    BuildContext context, T t);

typedef ErrorBuilder<T extends BaseProviderModel> = Widget Function(
    BuildContext context, T t);

typedef EmptyBuilder<T extends BaseProviderModel> = Widget Function(
    BuildContext context, T t);

typedef LoadingBuilder<T extends BaseProviderModel> = Widget Function(
    BuildContext context, T t);

class BaseProviderWidget<T extends BaseProviderModel> extends StatelessWidget {
  final Widget child;

  final Create<T> create;

  final ErrorBuilder<T> errorBuilder;

  final EmptyBuilder<T> emptyBuilder;

  final LoadingBuilder<T> loadingBuilder;

  BaseProviderWidget({
    @required this.child,
    @required this.create,
    @required this.errorBuilder,
    @required this.emptyBuilder,
    @required this.loadingBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: create,
      child: Consumer<T>(
        builder: (BuildContext context, T value, Widget child) {
          switch (value.widgetState) {
            case ProviderWidgetState.CONTENT:
              return child;
              break;
            case ProviderWidgetState.ERROR:
              return errorBuilder == null
                  ? Container()
                  : errorBuilder(context, value);
              break;
            case ProviderWidgetState.EMPTY:
              return emptyBuilder == null
                  ? Container()
                  : emptyBuilder(context, value);
              break;
            case ProviderWidgetState.LOADING:
              return loadingBuilder == null
                  ? Container()
                  : loadingBuilder(context, value);
              break;
          }
          return child;
        },
        child: child == null ? Container() : child,
      ),
    );
  }
}

class BaseProviderModel extends ChangeNotifier {
  ProviderWidgetState _widgetState;

  BaseProviderModel({ProviderWidgetState state})
      : _widgetState = state == null ? ProviderWidgetState.CONTENT : state;

  ProviderWidgetState get widgetState => _widgetState;

  set widgetState(ProviderWidgetState state) {
    _widgetState = state;
    notifyListeners();
  }
}

enum ProviderWidgetState {
  LOADING,
  CONTENT,
  EMPTY,
  ERROR,
}

class BaseProviderPageModel extends BaseProviderModel {
  String errorMessge = '';
  String emptyMessage = '';
  String loadingMessage = '';

  void Function(BaseProviderPageModel model) errorCallback;

  BaseProviderPageModel({ProviderWidgetState state}) : super(state: state);

  void showLoading({String message}) {
    loadingMessage = message;
    widgetState = ProviderWidgetState.LOADING;
  }

  void showContent() {
    widgetState = ProviderWidgetState.CONTENT;
  }

  void showError(
      {String message, Function(BaseProviderPageModel model) callback}) {
    errorMessge = message;
    errorCallback = callback;
    widgetState = ProviderWidgetState.ERROR;
  }

  void showEmpty({String message}) {
    emptyMessage = message;
    widgetState = ProviderWidgetState.EMPTY;
  }
}

class BaseProviderPageWidget<T extends BaseProviderPageModel>
    extends StatelessWidget {
  final Widget child;

  final Create<T> create;

  final ErrorBuilder<T> errorBuilder;

  final EmptyBuilder<T> emptyBuilder;

  final LoadingBuilder<T> loadingBuilder;


  BaseProviderPageWidget({
    @required this.create,
    this.child,
    this.errorBuilder,
    this.emptyBuilder,
    this.loadingBuilder,
  }) ;

  @override
  Widget build(BuildContext context) {
    return BaseProviderWidget<T>(
      child: child,
      create: create,
      emptyBuilder: emptyBuilder ?? (context, T t) => PageEmptyWidget(text: t.emptyMessage),
      errorBuilder: errorBuilder ?? (context, T t) => PageErrorWidget(text: t.errorMessge, callback: () => t.errorCallback(t)),
      loadingBuilder: loadingBuilder ?? (context, T t) => PageLoadingWidget(text: t.loadingMessage),
    );
  }
}
