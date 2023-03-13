
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/Page/sc_add_material_page.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../Controller/sc_material_search_controller.dart';
import '../View/Search/sc_material_search_view.dart';

/// 物资搜索page

class SCMaterialSearchPage extends StatefulWidget {
  @override
  SCMaterialSearchPageState createState() => SCMaterialSearchPageState();
}

class SCMaterialSearchPageState extends State<SCMaterialSearchPage> {

  /// SCMaterialSearchController
  late SCMaterialSearchController controller;

  /// SCMaterialSearchController - tag
  String controllerTag = '';

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance.getXControllerTag((SCMaterialSearchPage).toString());
    controller = Get.put(SCMaterialSearchController(), tag: controllerTag);
    initPageData();
  }

  /// 页面传递过来的数据
  initPageData() {
    var params = Get.arguments;
    if (params != null) {
      var wareHouseId = params['wareHouseId'];
      if (wareHouseId != null) {
        controller.wareHouseId = wareHouseId;
      }

      var type = params['type'];
      if (wareHouseId != null) {
        controller.type = type;
      }

      if (params.containsKey('hideNumTextField')) {
        controller.hideNumTextField = params['hideNumTextField'];
      }
      if (params.containsKey('isProperty')) {
        controller.isProperty = params['isProperty'];
      }
      if (params.containsKey('orgId')) {
        controller.orgId = params['orgId'];
      }
    }
  }

  @override
  dispose() {
    SCScaffoldManager.instance.deleteGetXControllerTag((SCAddMaterialPageState).toString(), controllerTag);
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
      child: GetBuilder<SCMaterialSearchController>(
          tag: controllerTag,
          init: controller,
          builder: (state) {
            return SCMaterialSearchView(state: state, isProperty: controller.isProperty,);
          }),
    );
  }
}
