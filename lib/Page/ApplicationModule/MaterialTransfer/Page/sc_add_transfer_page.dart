
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../../../../Utils/sc_utils.dart';
import '../Controller/sc_add_transfer_controller.dart';
import '../View/AddTransfer/sc_add_transfer_view.dart';

/// 新增调拨page

class SCAddTransferPage extends StatefulWidget {
  @override
  SCAddTransferPageState createState() => SCAddTransferPageState();
}

class SCAddTransferPageState extends State<SCAddTransferPage> {

  /// SCAddTransferController
  late SCAddTransferController controller;

  /// SCAddEntryController - tag
  String controllerTag = '';

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance.getXControllerTag((SCAddTransferPage).toString());
    controller = Get.put(SCAddTransferController(), tag: controllerTag);
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
    SCScaffoldManager.instance.deleteGetXControllerTag((SCAddTransferPage).toString(), controllerTag);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: controller.isEdit ? "编辑" : "新增调拨",
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
        child: GetBuilder<SCAddTransferController>(
            tag: controllerTag,
            init: controller,
            builder: (state) {
              return SCAddTransferView(state: state,);
            }),
      ),
    );
  }

}





