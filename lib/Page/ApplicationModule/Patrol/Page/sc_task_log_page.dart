
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../Controller/sc_task_log_controller.dart';
import '../View/Patrol/sc_task_log_view.dart';

/// 任务日志page

class SCTaskLogPage extends StatefulWidget {
  @override
  SCTaskLogPageState createState() => SCTaskLogPageState();
}

class SCTaskLogPageState extends State<SCTaskLogPage> {

  /// SCTaskLogController
  late SCTaskLogController controller;

  /// SCWarningCenterController - tag
  String controllerTag = '';

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance.getXControllerTag((SCTaskLogPage).toString());
    controller = Get.put(SCTaskLogController(), tag: controllerTag);
  }

  @override
  dispose() {
    SCScaffoldManager.instance.deleteGetXControllerTag(pageName(), controllerTag);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "任务日志", centerTitle: true, elevation: 0, body: body());
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_FFFFFF,
      child: GetBuilder<SCTaskLogController>(
          tag: controllerTag,
          init: controller,
          builder: (state) {
            return SCTaskLogView(state: state,);
          }),
    );
  }

  /// pageName
  String pageName() {
    return (SCTaskLogPage).toString();
  }

}
