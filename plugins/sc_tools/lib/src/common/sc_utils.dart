import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 工具类

class SCUtils {
  /*获取状态栏高度*/
  double getStatusBarHeight() {
    return MediaQueryData.fromWindow(window).padding.top;
  }

  /*获取屏幕宽度*/
  double getScreenWidth() {
    return MediaQueryData.fromWindow(window).size.width;
  }

  /*获取屏幕高度*/
  double getScreenHeight() {
    return MediaQueryData.fromWindow(window).size.height;
  }

  /*获取屏幕底部安全距离*/
  double getBottomSafeArea() {
    return MediaQueryData.fromWindow(window).padding.bottom;
  }

  /*获取屏幕顶部安全距离*/
  double getTopSafeArea() {
    return MediaQueryData.fromWindow(window).padding.top;
  }

  /*关闭键盘*/
  hideKeyboard({required BuildContext context}) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  /*计算文字宽宽高*/
  static Size boundingTextSize(
      BuildContext context, String text, TextStyle style,
      {int maxLines = 2 ^ 31, double maxWidth = double.infinity}) {
    if (text.isEmpty) {
      return Size.zero;
    }
    final TextPainter textPainter = TextPainter(
        textDirection: TextDirection.ltr,
        locale: Localizations.localeOf(context),
        text: TextSpan(text: text, style: style),
        maxLines: maxLines)
      ..layout(maxWidth: maxWidth);
    return textPainter.size;
  }

  /*修改状态栏颜色*/
  changeStatusBarStyle({required SystemUiOverlayStyle style}) {
    SystemChrome.setSystemUIOverlayStyle(style);
  }

  /*获取性别num*/
  static int getGenderNumber({required String genderString}) {
    if (genderString == '男') {
      return 1;
    } else {
      return 2;
    }
  }

  /*获取性别string*/
  static String getGenderString({required int gender}) {
    if (gender == 1) {
      return '男';
    } else {
      return '女';
    }
  }

  /*获取当前context*/
  static getCurrentContext(
      {required GlobalKey<NavigatorState> navigatorKey ,Function(BuildContext context)? completionHandler}) {
    Future.delayed(const Duration(seconds: 0), () async {
      BuildContext context = navigatorKey.currentState!.overlay!.context;
      completionHandler?.call(context);
    });
  }
}
