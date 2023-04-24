
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Constants/sc_key.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../Controller/sc_patrol_controller.dart';
import '../View/Patrol/sc_patrol_view.dart';

/// 巡查任务列表page

class SCPatrolPage extends StatefulWidget {
  @override
  SCPatrolPageState createState() => SCPatrolPageState();
}

class SCPatrolPageState extends State<SCPatrolPage> with AutomaticKeepAliveClientMixin{

  /// SCPatrolController
  late SCPatrolController controller;

  /// SCWarningCenterController - tag
  String controllerTag = '';

  /// notify
  late StreamSubscription subscription;

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance.getXControllerTag((SCPatrolPage).toString());
    controller = Get.put(SCPatrolController(), tag: controllerTag);
    controller.loadData(isMore: false);
    addNotification();
  }

  @override
  dispose() {
    subscription.cancel();
    SCScaffoldManager.instance.deleteGetXControllerTag(pageName(), controllerTag);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "巡查任务", centerTitle: true, elevation: 0, body: body());
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: GetBuilder<SCPatrolController>(
          tag: controllerTag,
          init: controller,
          builder: (state) {
            return SCPatrolView(state: state,);
          }),
    );
  }

  /// pageName
  String pageName() {
    return (SCPatrolPage).toString();
  }

  /// 通知
  addNotification() {
    subscription = SCScaffoldManager.instance.eventBus.on().listen((event) {
      String key = event['key'];
      if (key == SCKey.kRefreshPatrolPage) {
        controller.loadData(isMore: false);
      }
    });
  }

  @override
  bool get wantKeepAlive => true;

}
