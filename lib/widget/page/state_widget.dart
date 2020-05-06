import 'package:flutter/material.dart';

class StateWidget extends StatefulWidget {
  final StateWidgetControler controler;

  final WidgetBuilder builder;
  final WidgetBuilder emptyBuilder;
  final WidgetBuilder errorBuilder;
  final WidgetBuilder loadingBuilder;

  StateWidget({
    this.controler,
    this.builder,
    this.emptyBuilder,
    this.errorBuilder,
    this.loadingBuilder,
    Key key,
  }) : super(key: key);

  @override
  _StateWidgetState createState() => _StateWidgetState();
}

class _StateWidgetState extends State<StateWidget> {
  _WidgetState _currentState = _WidgetState.CONTENT;

  @override
  void initState() {
    super.initState();
    _currentState = widget?.controler?.value;
    widget?.controler?.addListener(() {
      setState(() {
        _currentState = widget?.controler?.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    switch (_currentState) {
      case _WidgetState.LOADING:
        child = widget.loadingBuilder == null ? Container() : widget.loadingBuilder(context);
        break;
      case _WidgetState.CONTENT:
        child = widget.builder == null ? Container() : widget.builder(context);
        break;
      case _WidgetState.ERROR:
        child = widget.errorBuilder == null ? Container() : widget.errorBuilder(context);
        break;
      case _WidgetState.EMPTY:
        child = widget.emptyBuilder == null ? Container() : widget.emptyBuilder(context);
        break;
      default:
        child =Container();
    }
    return child;
  }
}

class StateWidgetControler extends ValueNotifier<_WidgetState> {
  StateWidgetControler({_WidgetState value}) : super(value ?? _WidgetState.CONTENT);

  void showContent() {
    value = _WidgetState.CONTENT;
  }

  void showLoading() {
    value = _WidgetState.LOADING;
  }

  void showError() {
    value = _WidgetState.ERROR;
  }

  void showEmpty() {
    value = _WidgetState.EMPTY;
  }
}

enum _WidgetState {
  LOADING,
  CONTENT,
  ERROR,
  EMPTY,
}
