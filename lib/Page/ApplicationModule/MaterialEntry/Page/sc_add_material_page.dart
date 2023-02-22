
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/Controller/sc_categoryalert_controlller.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import '../../../../Constants/sc_enum.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../Controller/sc_add_material_controller.dart';
import '../Model/sc_material_list_model.dart';
import '../View/AddMaterial/sc_add_material_view.dart';

/// 添加物资page

class SCAddMaterialPage extends StatefulWidget {

  @override
  SCAddMaterialPageState createState() => SCAddMaterialPageState();
}

class SCAddMaterialPageState extends State<SCAddMaterialPage> with AutomaticKeepAliveClientMixin{

  /// SCAddMaterialController
  late SCAddMaterialController controller;

  /// SCCategoryAlertController
  late SCCategoryAlertController categoryAlertController;

  /// RefreshController
  RefreshController refreshController = RefreshController(initialRefresh: false);

  /// SCAddMaterialController - tag
  String controllerTag = '';

  /// SCCategoryAlertController - tag
  String categoryAlertControllerTag = '';

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance.getXControllerTag((SCAddMaterialPage).toString());
    controller = Get.put(SCAddMaterialController(), tag: controllerTag);
    categoryAlertControllerTag = SCScaffoldManager.instance
        .getXControllerTag((SCAddMaterialPage).toString());
    categoryAlertController = Get.put(SCCategoryAlertController(), tag: categoryAlertControllerTag);
    categoryAlertController.tag = categoryAlertControllerTag;
    initPageData();
    controller.loadMaterialListData();
  }

  @override
  dispose() {
    SCScaffoldManager.instance.deleteGetXControllerTag((SCAddMaterialPage).toString(), controllerTag);
    SCScaffoldManager.instance.deleteGetXControllerTag((SCAddMaterialPage).toString(), categoryAlertControllerTag);
    controller.dispose();
    refreshController.dispose();
    super.dispose();
  }

  /// 页面传递过来的数据
  initPageData() {
    var params = Get.arguments;
    if (params != null) {
      var originalSelectList = params['data'];
      if (originalSelectList != null) {
        controller.originalList = originalSelectList;
      }
      var wareHouseId = params['wareHouseId'];
      if (wareHouseId != null) {
        controller.wareHouseId = wareHouseId;
      }
      if (params.containsKey('isEdit')) {
        controller.isEdit = params['isEdit'];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "新增物资",
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
      child: GetBuilder<SCAddMaterialController>(
          tag: controllerTag,
          init: controller,
          builder: (state) {
            return SCAddMaterialView(
              state: state,
              categoryAlertController: categoryAlertController,
              refreshController: refreshController,
              sureAction: (List<SCMaterialListModel> list){
              SCRouterHelper.back(list);
            },);
          }),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}



