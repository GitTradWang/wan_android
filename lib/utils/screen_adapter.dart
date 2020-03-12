import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///适配高度[width]设计稿元素的宽度（同屏显示不下，scrollView竖向滑动的建议使用宽度来适配）
num aWidth(num width) {
  return ScreenUtil().setWidth(width);
}

///适配高度[height]设计稿元素的高度（屏幕显示的下，不会滚动显示建议使用高度适配）
num aHeight(num height) {
  return ScreenUtil().setHeight(height);
}

///适配字体[fontSize]设计稿文字的大小 [allowFontScaling] 是否跟随系统缩放
num aSp(num fontSize, [allowFontScaling = false]) {
  return ScreenUtil().setSp(fontSize, allowFontScalingSelf: allowFontScaling);
}

class Screen {
  ///初始化屏幕适配工具 750*1334的设计稿大小 不允许字体缩放
  static void initScreenAdapter(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
  }

  ///设备宽度
  static num get screenWidth => ScreenUtil.screenWidth;

  ///设备高度
  static num get screenHeight => ScreenUtil.screenHeight;

  ///底部安全区距离，适用于全面屏下面有按键的
  static num get bottomBarHeight => ScreenUtil.bottomBarHeight;

  ///状态栏高度 刘海屏会更高  单位px
  static num get statusBarHeight => ScreenUtil.statusBarHeight;

  ///系统字体缩放比例
  static num get textScaleFactor => ScreenUtil.textScaleFactor;
}
