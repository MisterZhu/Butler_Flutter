import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartcommunity/Constants/sc_default_value.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Constants/sc_asset.dart';
import '../sc_app.dart';
import 'package:sc_uikit/sc_uikit.dart';
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

  /*验证手机号*/
  bool checkPhone({required String phone}) {
    return RegExp(SCDefaultValue.phoneReg).hasMatch(phone);
  }

  /*验证姓名*/
  bool checkName({required String name, bool? isShowTip}) {
    bool showTip = isShowTip ?? false;
    if (name.isEmpty) {
      if (showTip) {
        SCToast.showTip(SCDefaultValue.inputNameTip);
      }
      return false;
    }
    if (name.trim().length < 2) {
      if (showTip) {
        SCToast.showTip(SCDefaultValue.inputNameErrorTip);
      }
      return false;
    }
    return true;
  }

  /*验证身份证*/
  checkIDCard({required String idNumber, bool? isShowTip}) {
    bool showTip = isShowTip ?? false;
    if (idNumber.isEmpty) {
      if (showTip) {
        SCToast.showTip(SCDefaultValue.inputIDCardTip);
      }
      return false;
    }

    RegExp cardReg = RegExp(SCDefaultValue.idCardReg);
    if (!cardReg.hasMatch(idNumber)) {
      if (showTip) {
        SCToast.showTip(SCDefaultValue.inputIDCardErrorTip);
      }
      return false;
    }
    return true;
  }

  /*计算文字宽宽高*/
  static Size boundingTextSize(
      BuildContext context, String text, TextStyle style,
      {int maxLines = 2 ^ 31, double maxWidth = double.infinity}) {
    if (text == null || text.isEmpty) {
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

  /*获取当前context*/
  static getCurrentContext(
      {Function(BuildContext context)? completionHandler}) {
    Future.delayed(const Duration(seconds: 0), () async {
      BuildContext context = navigatorKey.currentState!.overlay!.context;
      completionHandler?.call(context);
    });
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

  /*flutter调用h5*/
  String flutterCallH5({required String h5Name, required var params}) {
    var jsonParams = jsonEncode(params);
    return "$h5Name('$jsonParams')";
  }

  /*本地图片转base64字符串*/
  Future<String> localImageToBase64(String path) async{
    ByteData bytes = await rootBundle.load(path);
    var buffer = bytes.buffer;
    String base64 = jsonEncode(Uint8List.view(buffer));
    return base64;
  }

  /// 根据status获取工单按钮text
  static String getWorkOrderButtonText(int status) {
    switch (status) {
      case 1:
        return "立即接单";
      case 2:
        return "开始处理";
      case 3:
        return "立即接单";
      case 4:
        return "开始处理";
      case 5:
        return "完成处理";
      case 6:
        return "进行回访";
      case 7:
        return "进行回访";
      case 8:
        return "完成";
      case 9:
        return "完成处理";
      default:
        return "完成";
    }
  }

  /*打电话*/
  static call(String phone) async{
    String phonePath = 'tel:$phone';
    Uri uri = Uri.parse(phonePath);
    bool success = await launchUrl(uri);
    if (success == false) {
      SCToast.showTip(SCDefaultValue.callFailedTip);
    }
  }
}
