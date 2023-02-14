
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../../../../Utils/sc_utils.dart';
import '../Controller/sc_add_entry_controller.dart';
import '../Model/sc_material_list_model.dart';
import '../View/AddEntry/sc_add_entry_view.dart';

/// 新增入库page

class SCAddEntryPage extends StatefulWidget {
  @override
  SCAddEntryPageState createState() => SCAddEntryPageState();
}

class SCAddEntryPageState extends State<SCAddEntryPage> {

  /// SCAddEntryController
  late SCAddEntryController addController;

  /// SCAddEntryController - tag
  String addControllerTag = '';

  @override
  initState() {
    super.initState();
    addControllerTag = SCScaffoldManager.instance.getXControllerTag((SCAddEntryPage).toString());
    addController = Get.put(SCAddEntryController(), tag: addControllerTag);
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "新增入库",
        centerTitle: true,
        elevation: 0,
        resizeToAvoidBottomInset: true, /// 页面不会随着键盘上移
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
            tag: addControllerTag,
            init: addController,
            builder: (state) {
              return SCAddEntryView(state: state,);
            }),
      ),
    );
  }

}



