
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/PropertyMaintenance/View/Add/sc_add_propertyrecord_view.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../../../../Utils/sc_utils.dart';
import '../../MaterialOutbound/Controller/sc_select_department_controller.dart';
import '../Controller/sc_add_propertymaintenance_controller.dart';

/// 新增资产维保page

class SCAddPropertyMaintenancePage extends StatefulWidget {
  @override
  SCAddPropertyMaintenancePageState createState() => SCAddPropertyMaintenancePageState();
}

class SCAddPropertyMaintenancePageState extends State<SCAddPropertyMaintenancePage> {

  /// SCAddPropertyMaintenanceController
  late SCAddPropertyMaintenanceController controller;

  /// SCSelectDepartmentController
  late SCSelectDepartmentController selectDepartmentController;

  /// SCAddEntryController - tag
  String controllerTag = '';

  /// SCSelectDepartmentController - tag
  String selectDepartmentControllerTag = '';

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance.getXControllerTag((SCAddPropertyMaintenancePage).toString());
    controller = Get.put(SCAddPropertyMaintenanceController(), tag: controllerTag);
    selectDepartmentControllerTag = SCScaffoldManager.instance
        .getXControllerTag((SCAddPropertyMaintenancePage).toString());
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
        }
      }
    }
  }

  @override
  dispose() {
    SCScaffoldManager.instance.deleteGetXControllerTag((SCAddPropertyMaintenancePage).toString(), controllerTag);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: controller.isEdit ? "编辑" : "新增",
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
        child: GetBuilder<SCAddPropertyMaintenanceController>(
            tag: controllerTag,
            init: controller,
            builder: (state) {
              return SCAddPropertyMaintenanceView(state: state, selectDepartmentController: selectDepartmentController);
            }),
      ),
    );
  }

}





