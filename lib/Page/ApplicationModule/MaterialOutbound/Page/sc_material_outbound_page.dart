import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Constants/sc_key.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../Controller/sc_material_outbound_controller.dart';
import '../View/MaterialOutbound/sc_material_outbound_view.dart';

/// 物资出库page

class SCMaterialOutboundPage extends StatefulWidget {
  @override
  SCMaterialOutboundPageState createState() => SCMaterialOutboundPageState();
}

class SCMaterialOutboundPageState extends State<SCMaterialOutboundPage> {

  /// SCMaterialOutboundController
  late SCMaterialOutboundController controller;

  /// SCMaterialOutboundController - tag
  String controllerTag = '';

  /// notify
  late StreamSubscription subscription;

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance
        .getXControllerTag((SCMaterialOutboundPage).toString());
    controller = Get.put(SCMaterialOutboundController(), tag: controllerTag);
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
        title: "物资出库", centerTitle: true, elevation: 0, body: body());
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: GetBuilder<SCMaterialOutboundController>(
          tag: controllerTag,
          init: controller,
          builder: (state) {
            return SCMaterialOutboundView(state: state,);
          }),
    );
  }

  /// pageName
  String pageName() {
    return (SCMaterialOutboundPage).toString();
  }

  /// 通知
  addNotification() {
    subscription = SCScaffoldManager.instance.eventBus.on().listen((event) {
      String key = event['key'];
      if (key == SCKey.kRefreshMaterialOutboundPage) {
        controller.loadData(isMore: false);
      }
    });
  }

}
