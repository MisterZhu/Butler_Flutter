/// 预警中心page

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/PropertyMaintenance/View/PropertyRecord/sc_property_record_view.dart';
import '../../../../Constants/sc_key.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../Controller/sc_warningcenter_controller.dart';
import '../View/WarningCenter/sc_warningcenter_view.dart';

/// 资产维保记录page

class SCWarningCenterPage extends StatefulWidget {
  @override
  SCWarningCenterPageState createState() => SCWarningCenterPageState();
}

class SCWarningCenterPageState extends State<SCWarningCenterPage> with AutomaticKeepAliveClientMixin{

  /// SCWarningCenterController
  late SCWarningCenterController controller;

  /// SCWarningCenterController - tag
  String controllerTag = '';

  /// notify
  late StreamSubscription subscription;

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance
        .getXControllerTag((SCWarningCenterPage).toString());
    controller = Get.put(SCWarningCenterController(), tag: controllerTag);
    controller.loadData(isMore: false);
    addNotification();
  }

  @override
  dispose() {
    subscription.cancel();
    SCScaffoldManager.instance.deleteGetXControllerTag(pageName(), controllerTag);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "预警中心", centerTitle: true, elevation: 0, body: body());
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: GetBuilder<SCWarningCenterController>(
          tag: controllerTag,
          init: controller,
          builder: (state) {
            return SCWarningCenterView(state: state,);
          }),
    );
  }

  /// pageName
  String pageName() {
    return (SCWarningCenterPage).toString();
  }

  /// 通知
  addNotification() {
    subscription = SCScaffoldManager.instance.eventBus.on().listen((event) {
      String key = event['key'];
      if (key == SCKey.kRefreshPropertyMaintenancePage) {
        // controller.loadData(isMore: false);
      }
    });
  }

  @override
  bool get wantKeepAlive => true;

}
