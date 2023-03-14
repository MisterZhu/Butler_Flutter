
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/PropertyFrmLoss/Model/sc_property_list_model.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../../../../Utils/sc_utils.dart';
import '../Controller/sc_add_entry_controller.dart';
import '../Model/sc_entry_type_model.dart';
import '../Model/sc_material_entry_model.dart';
import '../Model/sc_material_list_model.dart';
import '../View/AddEntry/sc_add_entry_view.dart';

/// 新增入库page

class SCAddEntryPage extends StatefulWidget {
  @override
  SCAddEntryPageState createState() => SCAddEntryPageState();
}

class SCAddEntryPageState extends State<SCAddEntryPage> {

  /// SCAddEntryController
  late SCAddEntryController controller;

  /// SCAddEntryController - tag
  String controllerTag = '';

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance.getXControllerTag((SCAddEntryPage).toString());
    controller = Get.put(SCAddEntryController(), tag: controllerTag);
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
          if (controller.isEdit == true) {
            controller.editParams = params;
            controller.materialType = params['materialType'] ?? 0;
            if (selectedList != null) {
              controller.selectedList = selectedList;
            }
          }
        }
        if (params.containsKey('orderId')) {
          controller.orderId = params['orderId'];
        }
        if (params.containsKey('isReturnEntry')) {
          controller.isReturnEntry = params['isReturnEntry'];
        }
        if (params.containsKey('entryModel')) {
          SCMaterialEntryModel model = params['entryModel'];
          controller.outId = model.id ?? '';
          controller.loadMaterialOutList();
          controller.wareHouseId = model.wareHouseId ?? '';
          controller.wareHouseName = model.wareHouseName ?? '';
          controller.typeID = 4;
        }
      }
    }
  }

  @override
  dispose() {
    SCScaffoldManager.instance.deleteGetXControllerTag((SCAddEntryPage).toString(), controllerTag);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: controller.isEdit ? "编辑" : "新增入库",
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
        child: GetBuilder<SCAddEntryController>(
            tag: controllerTag,
            init: controller,
            builder: (state) {
              return SCAddEntryView(state: state,);
            }),
      ),
    );
  }

}



