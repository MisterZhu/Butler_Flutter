import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
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
    return SCCustomScaffold(title: "设置", centerTitle: true, navBackgroundColor: SCColors.color_F2F3F5, elevation: 0, body: body());
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

}