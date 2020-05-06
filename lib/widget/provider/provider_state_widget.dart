import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanandroidflutter/widget/page_state_widget.dart';

typedef ChildBuilder<T extends ProviderStateModel> = Widget Function(
    BuildContext context, T t);

typedef ErrorBuilder<T extends ProviderStateModel> = Widget Function(
    BuildContext context, T t);

typedef EmptyBuilder<T extends ProviderStateModel> = Widget Function(
    BuildContext context, T t);

typedef LoadingBuilder<T extends ProviderStateModel> = Widget Function(
    BuildContext context, T t);

class ProviderStateWidget<T extends ProviderStateModel> extends StatelessWidget {
  final Widget child;

  final Create<T> create;

  final ErrorBuilder<T> errorBuilder;

  final EmptyBuilder<T> emptyBuilder;

  final LoadingBuilder<T> loadingBuilder;

  ProviderStateWidget({
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

class ProviderStateModel extends ChangeNotifier {
  ProviderWidgetState _widgetState;

  ProviderStateModel({ProviderWidgetState state}) : _widgetState = state == null ? ProviderWidgetState.CONTENT : state;

  ProviderWidgetState get widgetState => _widgetState;

  set widgetState(ProviderWidgetState state) {
    if (state == _widgetState) return;
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

class ProviderStatePageModel extends ProviderStateModel {
  String errorMessge = '';
  String emptyMessage = '';
  String loadingMessage = '';

  void Function(ProviderStatePageModel model) errorCallback;

  ProviderStatePageModel({ProviderWidgetState state}) : super(state: state);

  void showLoading({String message}) {
    loadingMessage = message;
    widgetState = ProviderWidgetState.LOADING;
  }

  void showContent() {
    widgetState = ProviderWidgetState.CONTENT;
  }

  void showError(
      {String message, Function(ProviderStatePageModel model) callback}) {
    errorMessge = message;
    errorCallback = callback;
    widgetState = ProviderWidgetState.ERROR;
  }

  void showEmpty({String message}) {
    emptyMessage = message;
    widgetState = ProviderWidgetState.EMPTY;
  }
}

class ProviderStatePageWidget<T extends ProviderStatePageModel>
    extends StatelessWidget {
  final Widget child;

  final Create<T> create;

  final ErrorBuilder<T> errorBuilder;

  final EmptyBuilder<T> emptyBuilder;

  final LoadingBuilder<T> loadingBuilder;

  ProviderStatePageWidget({
    @required this.create,
    this.child,
    this.errorBuilder,
    this.emptyBuilder,
    this.loadingBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return ProviderStateWidget<T>(
      child: child,
      create: create,
      emptyBuilder: emptyBuilder ?? (context, T t) => PageEmptyWidget(text: t.emptyMessage),
      errorBuilder: errorBuilder ?? (context, T t) => PageErrorWidget(text: t.errorMessge, callback: () => t.errorCallback(t)),
      loadingBuilder: loadingBuilder ?? (context, T t) => PageLoadingWidget(text: t.loadingMessage),
    );
  }
}
