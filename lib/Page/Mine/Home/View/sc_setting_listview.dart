
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/Mine/Home/View/sc_setting_cell.dart';
import '../../../../Constants/sc_agreement.dart';
import '../../../../Constants/sc_default_value.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Utils/Router/sc_router_helper.dart';
import '../../../../Utils/Router/sc_router_path.dart';
import '../GetXController/sc_setting_controller.dart';

/// 设置listview

class SCSettingListView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return getCell(index, context);
        },
        separatorBuilder: (BuildContext context, int index) {
          bool isLine = true;
          if (index == 2 || index == 3) {
            isLine = false;
          }
          return getLine(isLine);
        },
        itemCount: 5);
  }
  
  Widget getCell(int index, BuildContext context) {
    if (index == 0) {
      return SCSettingCell(title: '关于', onTap: (){
        var params = {'title' : '关于${SCDefaultValue.appName}', 'url' : SCAgreement.userAgreementUrl, 'removeLoginCheck' : true};
        SCRouterHelper.pathPage(SCRouterPath.webViewPath, params);
      },);
    } else if (index == 1) {
      return SCSettingCell(title: '用户协议', onTap: (){
        var params = {'title' : '用户协议', 'url' : SCAgreement.userAgreementUrl, 'removeLoginCheck' : true};
        SCRouterHelper.pathPage(SCRouterPath.webViewPath, params);
      },);
    } else if (index == 2) {
      return SCSettingCell(title: '隐私政策', onTap: (){
        var params = {'title' : '隐私政策', 'url' : SCAgreement.privacyProtocolUrl, 'removeLoginCheck' : true};
        SCRouterHelper.pathPage(SCRouterPath.webViewPath, params);
      },);
    } else if (index == 3) {
      return logOffCell(context);
    } else if (index == 4) {
      return logoutCell();
    } else {
      return const SizedBox(height: 100.0,);
    }
  }

  /// 注销cell
  Widget logOffCell(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60.0,
      child: CupertinoButton(
          padding: EdgeInsets.zero,
          color: SCColors.color_FFFFFF,
          borderRadius: BorderRadius.circular(0.0),
          child: const Text(
            "注销",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: SCFonts.f16,
                fontWeight: FontWeight.w500,
                color: SCColors.color_4285F4),
          ),
          onPressed: () {
            logOff(context);
          }),
    );
  }

  /// 注销
  logOff(BuildContext context) {
    SCDialogUtils.instance.showMiddleDialog(
      context: context,
      content: SCDefaultValue.logOffTip,
      customWidgetButtons: [
        defaultCustomButton(context,
            text: '取消',
            textColor: SCColors.color_1B1C33,
            fontWeight: FontWeight.w400),
        defaultCustomButton(context,
            text: '确定',
            textColor: SCColors.color_1B1C33,
            fontWeight: FontWeight.w400, onTap: () {
              SCSettingController controller = SCSettingController();
              controller.logOff();
            }),
      ],
    );
  }

  /// 退出登录
  Widget logoutCell() {
    return SizedBox(
      width: double.infinity,
      height: 60.0,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        color: SCColors.color_FFFFFF,
        borderRadius: BorderRadius.circular(0.0),
        child: const Text(
          "退出登录",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: SCFonts.f16,
            fontWeight: FontWeight.w500,
            color: SCColors.color_1B1C33),
        ),
        onPressed: () {
          SCScaffoldManager.instance.logout();
        }),
    );
  }

  /// 分隔线
  Widget getLine(bool isLine) {
    if (isLine) {
      return line();
    } else {
      return line10();
    }
  }

  /// line
  Widget line() {
    return Container(
      color: SCColors.color_FFFFFF,
      padding: const EdgeInsets.only(left: 12.0),
      child: Container(
        height: 0.5,
        width: double.infinity,
        color: SCColors.color_EDEDF0,
      ),

    );
  }
  
  Widget line10() {
    return Container(
      height: 10.0,
      width: double.infinity,
      color: SCColors.color_F2F3F5,
    );
  }
}
