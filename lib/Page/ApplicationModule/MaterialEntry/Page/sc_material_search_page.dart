
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/Page/sc_add_material_page.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import '../../../../Constants/sc_default_value.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../Controller/sc_material_search_controller.dart';
import '../Model/sc_material_list_model.dart';
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
        resizeToAvoidBottomInset: false, /// 页面不会随着键盘上移
        actions: [sureItem()],
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
            return SCMaterialSearchView(state: state);
          }),
    );
  }

  Widget sureItem() {
    return CupertinoButton(
        minSize: 48.0,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: const Text(
          '确定',
          style: TextStyle(
              fontSize: SCFonts.f16,
              fontWeight: FontWeight.w500,
              color: SCColors.color_1B1D33),
        ),
        onPressed: () {
          sureAction();
        });
  }

  /// 确定
  sureAction() {
    List<SCMaterialListModel> list = [];
    for (SCMaterialListModel model in controller.materialList) {
      bool isSelect = model.isSelect ?? false;
      if (isSelect) {
        list.add(model);
      }
    }
    if (list.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectMaterialTip);
    } else {
      SCRouterHelper.back({'list': list});
    }
  }
}
