import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_key.dart';
import 'package:smartcommunity/Page/Mine/Home/GetXController/sc_mine_controller.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Utils/Router/sc_router_helper.dart';
import '../../../../Utils/Router/sc_router_path.dart';
import '../../../../utils/sc_utils.dart';
import '../View/sc_mine_listview.dart';

/// 我的page
class SCMinePage extends StatefulWidget {
  @override
  SCMinePageState createState() => SCMinePageState();
}

class SCMinePageState extends State<SCMinePage> {
  /// 通知
  late StreamSubscription subscription;

  SCMineController mineController = Get.put(SCMineController());

  @override
  Widget build(BuildContext context) {
    return body();
  }

  @override
  initState() {
    super.initState();
    SCUtils().changeStatusBarStyle(style: SystemUiOverlayStyle.light);
    addNotification();
  }

  /// body
  Widget body() {
    return Scaffold(
      body: Container(
        color: SCColors.color_F2F3F5,
        width: double.infinity,
        height: double.infinity,
        child: GetBuilder<SCMineController>(builder: (value) {
          return SCMineListView(
            qrCodeTapAction: () {
              SCRouterHelper.pathPage(SCRouterPath.scanPath, null);
            },
            settingTapAction: () {
              SCRouterHelper.pathPage(SCRouterPath.settingPath, null);
            },
            avatarTapAction: () {
              SCRouterHelper.pathPage(SCRouterPath.personalInfoPath, null);
            },
            switchTapAction: () {
              SCRouterHelper.pathPage(SCRouterPath.switchIdentityPath, null);
            },
            userInfoTapAction: () {
              SCRouterHelper.pathPage(SCRouterPath.personalInfoPath, null);
            },
          );
        }),
      ),
    );
  }

  /// 通知
  addNotification() {
    subscription = SCScaffoldManager.instance.eventBus.on().listen((event) {
      String key = event['key'];
      if (key == SCKey.kSwitchEnterprise) {
        mineController.update();
      }
    });
  }
}
