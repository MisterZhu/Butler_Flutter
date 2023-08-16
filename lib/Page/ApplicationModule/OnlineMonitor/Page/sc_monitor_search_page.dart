
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../Controller/sc_monitor_search_controller.dart';
import '../View/sc_monitor_search_view.dart';

/// 监控搜索page

class SCMonitorSearchPage extends StatefulWidget {
  @override
  SCMonitorSearchPageState createState() => SCMonitorSearchPageState();
}

class SCMonitorSearchPageState extends State<SCMonitorSearchPage> {

  /// SCMonitorSearchController
  late SCMonitorSearchController controller;

  /// SCEntrySearchController - tag
  String controllerTag = '';

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance.getXControllerTag((SCMonitorSearchPage).toString());
    controller = Get.put(SCMonitorSearchController(), tag: controllerTag);
  }

  @override
  dispose() {
    SCScaffoldManager.instance.deleteGetXControllerTag((SCMonitorSearchPage).toString(), controllerTag);
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
      child: GetBuilder<SCMonitorSearchController>(
          tag: controllerTag,
          init: controller,
          builder: (state) {
            return SCMonitorSearchView(state: state);
          }),
    );
  }

}
