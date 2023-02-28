import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/Controller/sc_material_entry_controller.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Constants/sc_key.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../Controller/sc_material_requisition_controller.dart';
import '../View/sc_material_requisition_view.dart';

/// 物资出入库page

class SCMaterialRequisitionPage extends StatefulWidget {
  @override
  SCMaterialRequisitionPageState createState() => SCMaterialRequisitionPageState();
}

class SCMaterialRequisitionPageState extends State<SCMaterialRequisitionPage> with AutomaticKeepAliveClientMixin{
  /// SCMaterialRequisitionController
  late SCMaterialRequisitionController controller;

  /// SCMaterialEntryController - tag
  String controllerTag = '';

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance
        .getXControllerTag((SCMaterialRequisitionPage).toString());
    controller = Get.put(SCMaterialRequisitionController(), tag: controllerTag);
    controller.loadOutboundData(isMore: false);
    initPageParams();
  }

  initPageParams() {
    var params = Get.arguments;
    if (params != null && params is Map) {
      if (params.containsKey('orderId')) {
        controller.orderId = params['orderId'];
      }
    }
  }

  @override
  dispose() {
    SCScaffoldManager.instance
        .deleteGetXControllerTag(pageName(), controllerTag);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "物资出入库", centerTitle: true, elevation: 0, body: body());
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: GetBuilder<SCMaterialRequisitionController>(
          tag: controllerTag,
          init: controller,
          builder: (state) {
            return SCMaterialRequisitionView(
              state: state,
            );
          }),
    );
  }

  /// pageName
  String pageName() {
    return (SCMaterialRequisitionPage).toString();
  }

  @override
  bool get wantKeepAlive => true;
}
