
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../Controller/sc_add_material_controller.dart';
import '../View/AddMaterial/sc_add_material_view.dart';

/// 添加物资page

class SCAddMaterialPage extends StatefulWidget {
  @override
  SCAddMaterialPageState createState() => SCAddMaterialPageState();
}

class SCAddMaterialPageState extends State<SCAddMaterialPage> {

  /// SCAddMaterialController
  late SCAddMaterialController addController;

  /// SCAddMaterialController - tag
  String addControllerTag = '';

  @override
  initState() {
    super.initState();
    addControllerTag = SCScaffoldManager.instance.getXControllerTag((SCAddMaterialPageState).toString());
    addController = Get.put(SCAddMaterialController(), tag: addControllerTag);
    addController.loadMaterialListData();
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
          tag: addControllerTag,
          init: addController,
          builder: (state) {
            return SCAddMaterialView(state: state,);
          }),
    );
  }

}



