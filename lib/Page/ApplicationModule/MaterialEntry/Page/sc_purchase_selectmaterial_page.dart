import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/Model/sc_material_list_model.dart';

import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../Controller/sc_add_material_controller.dart';
import '../Controller/sc_purchase_selectmaterial_controller.dart';
import '../View/AddMaterial/sc_add_material_empty_view.dart';
import '../View/Purchase/sc_purchase_selectmaterial_view.dart';

/// 采购单-选择物资page

class SCPurchaseSelectMaterialPage extends StatefulWidget {
  @override
  SCPurchaseSelectMaterialPageState createState() => SCPurchaseSelectMaterialPageState();
}

class SCPurchaseSelectMaterialPageState extends State<SCPurchaseSelectMaterialPage> with AutomaticKeepAliveClientMixin{
  @override

  /// SCPurchaseSelectMaterialController
  late SCPurchaseSelectMaterialController controller;

  /// SCAddMaterialController - tag
  String controllerTag = '';

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance.getXControllerTag((SCPurchaseSelectMaterialPage).toString());
    controller = Get.put(SCPurchaseSelectMaterialController(), tag: controllerTag);
    initPageData();
  }

  @override
  dispose() {
    SCScaffoldManager.instance.deleteGetXControllerTag((SCPurchaseSelectMaterialPage).toString(), controllerTag);
    controller.dispose();
    super.dispose();
  }

  /// 页面传递过来的数据
  initPageData() {
    var params = Get.arguments;
    if (params != null) {
      print("数据源===${Get.arguments}");
      controller.allMaterialList = params['allMaterialList'].cast<SCMaterialListModel> ();
      controller.selectMaterialList = params['selectMaterialList'].cast<SCMaterialListModel> ();
      controller.initData();
    }
  }

  @override
  Widget build(BuildContext context) {
    String title = "选择物资";
    return SCCustomScaffold(
        title: title,
        centerTitle: true,
        elevation: 0,
        resizeToAvoidBottomInset: false,
        body: body());
  }

  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: GetBuilder<SCPurchaseSelectMaterialController>(
          tag: controllerTag,
          init: controller,
          builder: (state) {
            if (controller.allMaterialList.isEmpty) {
              return SCAddMaterialEmptyView();
            } else {
              return SCPurchaseSelectMaterialView(
                state: controller,
              );
            }
          }),
    );
  }

  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}