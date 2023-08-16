
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../Controller/sc_check_material_detail_controller.dart';
import '../View/CheckDetail/sc_check_material_detail_view.dart';

/// 盘点-物资详情page

class SCCheckMaterialDetailPage extends StatefulWidget {
  @override
  SCCheckMaterialDetailPageState createState() => SCCheckMaterialDetailPageState();
}

class SCCheckMaterialDetailPageState extends State<SCCheckMaterialDetailPage> with AutomaticKeepAliveClientMixin{

  /// SCCheckMaterialDetailController
  late SCCheckMaterialDetailController controller;

  /// SCCheckMaterialDetailController - tag
  String controllerTag = '';


  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance
        .getXControllerTag((SCCheckMaterialDetailPage).toString());
    controller = Get.put(SCCheckMaterialDetailController(), tag: controllerTag);
    Map<String, dynamic> params = Get.arguments;
    if (params.isNotEmpty) {
      var model = params['model'];
      if (model != null) {
        controller.materialModel = model;
      }
    }
  }

  @override
  dispose() {
    SCScaffoldManager.instance.deleteGetXControllerTag((SCCheckMaterialDetailPage).toString(), controllerTag);
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
      child: GetBuilder<SCCheckMaterialDetailController>(
          tag: controllerTag,
          init: controller,
          builder: (state) {
            return SCCheckMaterialDetailView(state: state,);
          }),
    );
  }



  @override
  bool get wantKeepAlive => true;
}
