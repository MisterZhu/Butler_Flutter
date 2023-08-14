
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';

import '../../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../Controller/sc_task_log_controller.dart';
import '../../Page/sc_task_log_page.dart';
import '../Patrol/sc_task_log_view.dart';

/// 任务日志page

class SCTaskLogPageView extends StatefulWidget {

  final String bizId;

  const SCTaskLogPageView({super.key, required this.bizId});
  @override
  SCTaskLogPageViewState createState() => SCTaskLogPageViewState();
}

class SCTaskLogPageViewState extends State<SCTaskLogPageView> {

  /// SCTaskLogController
  late SCTaskLogController controller;

  /// SCWarningCenterController - tag
  String controllerTag = '';

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance.getXControllerTag((SCTaskLogPage).toString());
    controller = Get.put(SCTaskLogController(), tag: controllerTag);
    controller.initParams({
      'bizId': widget.bizId
    });
  }

  @override
  dispose() {
    SCScaffoldManager.instance.deleteGetXControllerTag(pageName(), controllerTag);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
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
    return (SCTaskLogPageView).toString();
  }

}
