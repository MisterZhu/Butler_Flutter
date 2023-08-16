
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../../../../Utils/sc_utils.dart';
import '../Controller/sc_add_outbound_controller.dart';
import '../Controller/sc_select_department_controller.dart';
import '../View/AddOutbound/sc_add_outbound_view.dart';

/// 新增出库page

class SCAddOutboundPage extends StatefulWidget {
  @override
  SCAddOutboundPageState createState() => SCAddOutboundPageState();
}

class SCAddOutboundPageState extends State<SCAddOutboundPage> {

  /// SCAddOutboundController
  late SCAddOutboundController controller;

  /// SCSelectDepartmentController
  late SCSelectDepartmentController selectDepartmentController;

  /// SCAddOutboundController - tag
  String controllerTag = '';

  /// SCSelectDepartmentController - tag
  String selectDepartmentControllerTag = '';

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance.getXControllerTag((SCAddOutboundPage).toString());
    controller = Get.put(SCAddOutboundController(), tag: controllerTag);
    selectDepartmentControllerTag = SCScaffoldManager.instance
        .getXControllerTag((SCAddOutboundPage).toString());
    selectDepartmentController = Get.put(SCSelectDepartmentController(), tag: selectDepartmentControllerTag);
    selectDepartmentController.tag = selectDepartmentControllerTag;
    initEditData();
  }

  /// 页面传递过来编辑的数据
  initEditData() {
    var arguments = Get.arguments;
    if (arguments is Map) {
      Map<String, dynamic> params = Get.arguments;
      if (params.isNotEmpty) {
        var selectedList = params['data'];
        if (params.containsKey('isEdit')) {
          controller.isEdit = params['isEdit'];
          if (controller.isEdit) {
            controller.editParams = params;
            if (selectedList != null) {
              controller.selectedList = selectedList;
            }
          }
        } else {
          if (params.containsKey('isLL')) {
            controller.isLL = true;
            controller.llMap = params['llData'];
            controller.type = '领料出库';
            controller.typeID = 1;
            controller.fetchOrgId =
                SCScaffoldManager.instance.user.orgIds?.first.toString() ?? '';
            controller.fetchOrgName =
                SCScaffoldManager.instance.user.orgNames?.first.toString() ?? '';
            controller.fetchUserId = SCScaffoldManager.instance.user.id ?? '';
            controller.fetchUserName = SCScaffoldManager.instance.user.userName ?? '';
          }
        }
      }
    }
  }

  @override
  dispose() {
    SCScaffoldManager.instance.deleteGetXControllerTag((SCAddOutboundPage).toString(), controllerTag);
    SCScaffoldManager.instance.deleteGetXControllerTag((SCAddOutboundPage).toString(), selectDepartmentControllerTag);
    controller.dispose();
    selectDepartmentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: controller.isEdit ? "编辑" : "新增出库",
        centerTitle: true,
        elevation: 0,
        resizeToAvoidBottomInset: true,
        body: body());
  }

  Widget body() {
    return GestureDetector(
      onTap: () {
        SCUtils().hideKeyboard(context: context);
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: SCColors.color_F2F3F5,
        child: GetBuilder<SCAddOutboundController>(
            tag: controllerTag,
            init: controller,
            builder: (state) {
              return SCAddOutboundView(state: state, selectDepartmentController: selectDepartmentController,);
            }),
      ),
    );
  }

}



