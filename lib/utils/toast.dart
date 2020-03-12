import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool> showToast({
  @required String message,
  Toast toastLength,
  int timeInSecForIos = 1,
  double fontSize = 16.0,
  ToastGravity gravity,
  Color backgroundColor,
  Color textColor,
}) {
  return Fluttertoast.showToast(
    msg: message,
    toastLength: toastLength,
    timeInSecForIos: timeInSecForIos,
    fontSize: fontSize,
    gravity: gravity,
    backgroundColor: backgroundColor,
    textColor: textColor,
  );
}
