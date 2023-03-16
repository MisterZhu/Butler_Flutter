import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../Controller/sc_fixedcheck_material_detail_controller.dart';
import '../View/Detail/sc_fixedcheck_material_detail_view.dart';

/// 固定资产盘点-物资详情page

class SCFixedCheckMaterialDetailPage extends StatefulWidget {
  @override
  SCFixedCheckMaterialDetailPageState createState() => SCFixedCheckMaterialDetailPageState();
}

class SCFixedCheckMaterialDetailPageState extends State<SCFixedCheckMaterialDetailPage>
    with AutomaticKeepAliveClientMixin {
  /// SCFixedCheckMaterialDetailController
  late SCFixedCheckMaterialDetailController controller;

  /// SCFixedCheckController - tag
  String controllerTag = '';

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance
        .getXControllerTag((SCFixedCheckMaterialDetailPage).toString());
    controller = Get.put(SCFixedCheckMaterialDetailController(), tag: controllerTag);
    initData();
  }

  /// 初始化数据
  initData() {
    var params = Get.arguments;
    if (params != null) {
      if (params.containsKey('model')) {
        controller.detailModel = params['model'];
        controller.initData();
      }
    }
  }

  @override
  dispose() {
    SCScaffoldManager.instance.deleteGetXControllerTag(
        (SCFixedCheckMaterialDetailPage).toString(), controllerTag);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "物资详情", centerTitle: true, elevation: 0, body: body());
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: GetBuilder<SCFixedCheckMaterialDetailController>(
          tag: controllerTag,
          init: controller,
          builder: (state) {
            return SCFixedCheckMaterialDetailView(
              state: controller,
            );
          }),
    );
  }


  @override
  bool get wantKeepAlive => true;
}
