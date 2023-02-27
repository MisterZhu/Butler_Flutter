import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Skin/View/sc_custom_scaffold.dart';

import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Utils/sc_utils.dart';
import '../Controller/sc_materialcheck_selectcategory_controller.dart';
import '../View/SelectCategory/sc_check_selectcategory_view.dart';

/// 盘点任务-选择物资分类page

class SCMaterialCheckSelectCategoryPage extends StatefulWidget {
  @override
  SCMaterialCheckSelectCategoryPageState createState() =>
      SCMaterialCheckSelectCategoryPageState();
}

class SCMaterialCheckSelectCategoryPageState
    extends State<SCMaterialCheckSelectCategoryPage> {

  /// SCMaterialCheckSelectCategoryController
  late SCMaterialCheckSelectCategoryController controller;

  /// SCMaterialCheckSelectCategoryController - tag
  String controllerTag = '';

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance
        .getXControllerTag((SCMaterialCheckSelectCategoryPage).toString());
    controller =
        Get.put(SCMaterialCheckSelectCategoryController(), tag: controllerTag);
    controller.loadMaterialClassTree();
  }

  @override
  dispose() {
    SCScaffoldManager.instance.deleteGetXControllerTag(
        (SCMaterialCheckSelectCategoryPage).toString(), controllerTag);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "物资分类",
        centerTitle: true,
        elevation: 0,
        resizeToAvoidBottomInset: true,
        body: body());
  }

  /// body
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
        child: GetBuilder<SCMaterialCheckSelectCategoryController>(
            tag: controllerTag,
            init: controller,
            builder: (state) {
              return SCCheckSelectCategoryView(
                controller: controller,
              );
            }),
      ),
    );
  }
}
