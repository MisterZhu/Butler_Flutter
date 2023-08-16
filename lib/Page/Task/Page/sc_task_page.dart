import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../../../Skin/Tools/sc_scaffold_manager.dart';
import '../Controller/sc_task_controller.dart';
import '../View/sc_task_listview.dart';


/// 任务page

class SCTaskPage extends StatefulWidget {
  @override
  SCTaskPageState createState() => SCTaskPageState();
}

class SCTaskPageState extends State<SCTaskPage> {

  /// SCTaskController
  late SCTaskController controller;

  /// SCMessageController - tag
  String controllerTag = '';

  /// RefreshController
  RefreshController refreshController = RefreshController(initialRefresh: false);

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance.getXControllerTag((SCTaskPage).toString());
    controller = Get.put(SCTaskController(), tag: controllerTag);
    controller.startTimer();
  }

  @override
  dispose() {
    SCScaffoldManager.instance.deleteGetXControllerTag((SCTaskPage).toString(), controllerTag);
    controller.dispose();
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "任务",
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
      child: GetBuilder<SCTaskController>(
          tag: controllerTag,
          init: controller,
          builder: (state) {
            return SCTaskListView(state: state, refreshController: refreshController,);
          }),
    );
  }
}

