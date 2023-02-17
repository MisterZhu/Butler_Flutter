
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/Page/sc_add_material_page.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../Controller/sc_entry_search_controller.dart';
import '../Controller/sc_material_search_controller.dart';
import '../View/Search/sc_entry_search_view.dart';
import '../View/Search/sc_material_search_view.dart';

/// 出入库搜索page

class SCEntrySearchPage extends StatefulWidget {
  @override
  SCEntrySearchPageState createState() => SCEntrySearchPageState();
}

class SCEntrySearchPageState extends State<SCEntrySearchPage> {

  /// SCEntrySearchController
  late SCEntrySearchController controller;

  /// SCEntrySearchController - tag
  String controllerTag = '';

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance.getXControllerTag((SCEntrySearchPage).toString());
    controller = Get.put(SCEntrySearchController(), tag: controllerTag);
    var params = Get.arguments;
    if (params != null) {
      var type = params['type'];
      if (type != null) {
        controller.type = type;
      }
    }
  }

  @override
  dispose() {
    SCScaffoldManager.instance.deleteGetXControllerTag((SCEntrySearchPage).toString(), controllerTag);
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
        body: body());
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: GetBuilder<SCEntrySearchController>(
          tag: controllerTag,
          init: controller,
          builder: (state) {
            return SCEntrySearchView(state: state);
          }),
    );
  }

}
