import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import 'package:smartcommunity/Skin/View/sc_custom_scaffold.dart';

import '../Controller/sc_warning_search_controller.dart';
import '../View/Search/sc_warning_search_view.dart';

/// 搜索预警page

class SCSearchWarningPage extends StatefulWidget {
  @override
  SCSearchWarningPageState createState() => SCSearchWarningPageState();
}

class SCSearchWarningPageState extends State<SCSearchWarningPage> with AutomaticKeepAliveClientMixin{

  /// SCSearchWarningController
  late SCSearchWarningController controller;

  /// SCSearchWarningController - tag
  String controllerTag = '';

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance.getXControllerTag((SCSearchWarningPage).toString());
    controller = Get.put(SCSearchWarningController(), tag: controllerTag);
    initPageData();
  }

  /// 页面传递过来的数据
  initPageData() {
    var params = Get.arguments;
    if (params != null) {

    }
  }

  @override
  dispose() {
    SCScaffoldManager.instance.deleteGetXControllerTag((SCSearchWarningPage).toString(), controllerTag);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "搜索",
        centerTitle: true,
        elevation: 0,
        resizeToAvoidBottomInset: false,
        body: body());
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: GetBuilder<SCSearchWarningController>(
          tag: controllerTag,
          init: controller,
          builder: (state) {
            return SCSearchWarningView(state: state);
          }),
    );
  }

}