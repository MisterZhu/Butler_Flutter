import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartcommunity/Constants/sc_default_value.dart';
import 'package:smartcommunity/Constants/sc_key.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
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
    if (phone.isEmpty) {
      SCToast.showTip(SCDefaultValue.callFailedTip);
      return;
    }
    String phonePath = 'tel:$phone';
    Uri uri = Uri.parse(phonePath);
    bool success = await launchUrl(uri);
    if (success == false) {
      SCToast.showTip(SCDefaultValue.callFailedTip);
    }
  }

  /*获取webView的url*/
  static String getWebViewUrl({required String url, required bool needJointParams}) {
    String token = SCScaffoldManager.instance.user.token ?? "";
    String client = SCDefaultValue.client;
    String defOrgId = SCScaffoldManager.instance.user.tenantId ?? '';
    String phoneNum = SCScaffoldManager.instance.user.mobileNum ?? '';
    String defOrgName =
    Uri.encodeComponent(SCScaffoldManager.instance.user.tenantName ?? '');
    String userId = SCScaffoldManager.instance.user.id ?? '';
    String spaceIds = SCScaffoldManager.instance.spaceIds ?? '';
    String userName =
    Uri.encodeComponent(SCScaffoldManager.instance.user.userName ?? '');

    /// 拼接符号
    String jointSymbol = "";

    /// 经度
    double latitude = SCScaffoldManager.instance.latitude;

    /// 纬度
    double longitude = SCScaffoldManager.instance.longitude;

    /// h5渠道-key
    String h5ChannelKey = SCKey.kH5Channel;

    /// h5渠道-value
    int h5ChannelValue = SCDefaultValue.h5Channel;

    if (spaceIds.isEmpty) {
      spaceIds = SCScaffoldManager.instance.user.tenantId ?? '';
    }
    if (url.contains('?')) {
      jointSymbol = "&";
    } else {
      jointSymbol = "?";
    }
    if (Platform.isAndroid) {
      String newUrl =
          "$url${jointSymbol}Authorization=$token&client=$client&defOrgId=$defOrgId&defOrgName=$defOrgName&tenantId=$defOrgId&phoneNum=$phoneNum&spaceIds=$spaceIds&userId=$userId&userName=$userName&fromQw=1&latitude=$latitude&longitude=$longitude";
      return newUrl;
    } else {
      String newUrl =
          "$url${jointSymbol}Authorization=$token&client=$client&defOrgId=$defOrgId&defOrgName=$defOrgName&tenantId=$defOrgId&phoneNum=$phoneNum&spaceIds=$spaceIds&userId=$userId&userName=$userName&fromQw=1&latitude=$latitude&longitude=$longitude";
      return newUrl;
    }
  }

  /*隐藏顶部状态栏*/
  hideTopStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: [SystemUiOverlay.bottom]);
  }

  /*是否是正数*/
  bool isPositiveNumber(String value) {
    return RegExp(SCDefaultValue.positiveNumberReg).hasMatch(value);
  }

  /// 根据status获取入库单据状态text
  static String getEntryStatusText(int status) {
    switch (status) {
      case 0:
        return "待提交";
      case 1:
        return "待审批";
      case 2:
        return "审批中";
      case 3:
        return "已拒绝";
      case 4:
        return "已驳回";
      case 5:
        return "已撤回";
      case 6:
        return "已通过";
      default:
        return " ";
    }
  }

  /// 根据status获取出库单据状态text
  static String getOutboundStatusText(int status) {
    switch (status) {
      case 0:
        return "待提交";
      case 1:
        return "待审批";
      case 2:
        return "审批中";
      case 3:
        return "已拒绝";
      case 4:
        return "已驳回";
      case 5:
        return "已撤回";
      case 6:
        return "已通过";
      case 7:
        return "已审批";
      default:
        return " ";
    }
  }

  /// 根据status获取出入库单据处理按钮text
  static String getEntryStatusButtonText(int status) {
    switch (status) {
      case 0:
        return "提交";
      case 1:
        return "撤回";
      case 2:
        return "撤回";
      case 3:
        return "编辑";
      case 4:
        return "编辑";
      case 5:
        return "编辑";
      default:
        return " ";
    }
  }

  /// 根据status获取出入库单据状态文本颜色text
  static Color getEntryStatusTextColor(int status) {
    switch (status) {
      case 0:
        return SCColors.color_FF7F09;
      case 1:
        return SCColors.color_FF7F09;
      case 2:
        return SCColors.color_0849B5;
      case 3:
        return SCColors.color_FF4040;
      case 4:
        return SCColors.color_FF4040;
      case 5:
        return SCColors.color_B0B1B8;
      case 6:
        return SCColors.color_B0B1B8;
      case 7:
        return SCColors.color_B0B1B8;
      default:
        return SCColors.color_B0B1B8;
    }
  }

  /// 复制粘贴板
  static pasteData(String data) {
    if (data.isNotEmpty && data != '') {
      Clipboard.setData(ClipboardData(text: data)).then((value) {
        SCToast.showTip(SCDefaultValue.pasteBoardSuccessTip);
      });
    }
  }
}
