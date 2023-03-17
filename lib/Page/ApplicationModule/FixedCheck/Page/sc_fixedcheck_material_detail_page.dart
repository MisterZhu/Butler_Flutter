import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../../MaterialEntry/Model/sc_material_assets_details_model.dart';
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
    log('bbb===$params');
    if (params != null) {
      if (params.containsKey('checkId')) {
        controller.checkId = params['checkId'];
      }
      if (params.containsKey('name')) {
        controller.name = params['name'];
      }
      if (params.containsKey('unit')) {
        controller.unit = params['unit'];
      }
      if (params.containsKey('norms')) {
        controller.norms = params['norms'];
      }
      if (params.containsKey('model')) {
        var json = params['model'].toJson();
        controller.detailModel = SCMaterialAssetsDetailsModel.fromJson(json);
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
