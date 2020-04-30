import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
      primaryColor: Colors.pink[400],
      accentColor: Colors.cyanAccent[700],
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      buttonTheme: ButtonThemeData(
        textTheme: ButtonTextTheme.normal,
        buttonColor: Colors.pink[500],
        height: 45,
        minWidth: 100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(23),
        ),
      ),
      textTheme: TextTheme(
        button: TextStyle(color: Colors.white),
      ),
      pageTransitionsTheme: PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
      appBarTheme: AppBarTheme());
  static ThemeData darkTheme = ThemeData(
    primaryColor: Colors.cyan[400],
    accentColor: Colors.pinkAccent[200],
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black12,
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.normal,
      buttonColor: Colors.cyan[500],
      height: 45,
      minWidth: 100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(23),
      ),
    ),
    textTheme: TextTheme(
      button: TextStyle(color: Colors.white),
    ),
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}
