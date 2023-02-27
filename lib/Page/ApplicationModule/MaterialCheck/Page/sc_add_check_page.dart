import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../../../../Utils/sc_utils.dart';
import '../../MaterialOutbound/Controller/sc_select_department_controller.dart';
import '../Controller/sc_add_check_controller.dart';
import '../View/AddCheck/sc_add_check_view.dart';

/// 新增任务page

class SCAddCheckPage extends StatefulWidget {
  @override
  SCAddCheckPageState createState() => SCAddCheckPageState();
}

class SCAddCheckPageState extends State<SCAddCheckPage> {
  /// SCAddCheckController
  late SCAddCheckController controller;

  /// SCSelectDepartmentController
  late SCSelectDepartmentController selectDepartmentController;

  /// SCAddEntryController - tag
  String controllerTag = '';

  /// SCSelectDepartmentController - tag
  String selectDepartmentControllerTag = '';

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance
        .getXControllerTag((SCAddCheckPage).toString());
    controller = Get.put(SCAddCheckController(), tag: controllerTag);
    selectDepartmentControllerTag = SCScaffoldManager.instance
        .getXControllerTag((SCAddCheckPage).toString());
    selectDepartmentController = Get.put(SCSelectDepartmentController(),
        tag: selectDepartmentControllerTag);
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
    SCScaffoldManager.instance
        .deleteGetXControllerTag((SCAddCheckPage).toString(), controllerTag);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: controller.isEdit ? "编辑" : "新增任务",
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
        child: GetBuilder<SCAddCheckController>(
            tag: controllerTag,
            init: controller,
            builder: (state) {
              return SCAddCheckView(
                state: state,
                selectDepartmentController: selectDepartmentController,
              );
            }),
      ),
    );
  }
}
