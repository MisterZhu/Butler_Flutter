import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../GetXController/sc_workbench_search_controller.dart';
import '../View/Search/sc_workbench_search_view.dart';


/// 消息page

class SCWorkBenchSearchPage extends StatefulWidget {
  @override
  SCWorkBenchSearchPageState createState() => SCWorkBenchSearchPageState();
}

class SCWorkBenchSearchPageState extends State<SCWorkBenchSearchPage> {

  /// SCMessageController
  late SCWorkBenchSearchController controller;

  /// SCMessageController - tag
  String controllerTag = '';

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance.getXControllerTag((SCWorkBenchSearchPage).toString());
    controller = Get.put(SCWorkBenchSearchController(), tag: controllerTag);
  }

  @override
  dispose() {
    SCScaffoldManager.instance.deleteGetXControllerTag((SCWorkBenchSearchPage).toString(), controllerTag);
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "搜索",
        centerTitle: true,
        navBackgroundColor: SCColors.color_FFFFFF,
        elevation: 0,
        body: body());
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: GetBuilder<SCWorkBenchSearchController>(
          tag: controllerTag,
          init: controller,
          builder: (state) {
            return SCWorkBenchSearchView(state: state);
          }),
    );
  }
}

