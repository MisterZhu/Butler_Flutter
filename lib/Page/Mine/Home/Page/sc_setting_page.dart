import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Constants/sc_enum.dart';
import '../../../../Network/sc_config.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../../../../Utils/Router/sc_router_helper.dart';
import '../../../../Utils/Router/sc_router_path.dart';
import '../GetXController/sc_setting_controller.dart';
import '../View/sc_setting_listview.dart';

/// 设置page

class SCSettingPage extends StatefulWidget {
  @override
  SCSettingState createState() => SCSettingState();
}

class SCSettingState extends State<SCSettingPage> {

  SCSettingController state = Get.put(SCSettingController());

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "设置",
        centerTitle: true,
        navBackgroundColor: SCColors.color_F2F3F5,
        elevation: 0,
        actions: [proxyItem()],
        body: body());
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: SCSettingListView(),
    );
  }

  /// 抓包
  Widget proxyItem() {
    if (SCConfig.env != SCEnvironment.production || SCConfig.isSupportProxyForProduction) {
      return CupertinoButton(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          minSize: 60.0,
          child: const Text(
            '抓包',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: SCFonts.f16,
              fontWeight: FontWeight.w500,
              color: SCColors.color_4285F4,
            ),
          ),
          onPressed: () {
            SCRouterHelper.pathPage(SCRouterPath.proxyPage, null);
          });
    } else {
      return const SizedBox();
    }
  }
}

