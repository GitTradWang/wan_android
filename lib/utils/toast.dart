import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast({
  @required String message,
  Toast toastLength,
  int timeInSecForIos = 1,
  double fontSize = 16.0,
  ToastGravity gravity,
  Color backgroundColor,
  Color textColor,
}) {
  if (message == null || message.length == 0) {
    return;
  }
  Fluttertoast.showToast(
    msg: message,
    toastLength: toastLength,
    timeInSecForIosWeb: timeInSecForIos,
    fontSize: fontSize,
    gravity: gravity,
    backgroundColor: backgroundColor,
    textColor: textColor,
  );
}
