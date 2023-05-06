
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Constants/sc_key.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../../Patrol/Controller/sc_patrol_controller.dart';
import '../../Patrol/View/Patrol/sc_patrol_view.dart';

/// 电子巡更任务列表page

class SCElectronicPatrolPage extends StatefulWidget {
  @override
  SCElectronicPatrolPageState createState() => SCElectronicPatrolPageState();
}

class SCElectronicPatrolPageState extends State<SCElectronicPatrolPage> with AutomaticKeepAliveClientMixin{

  /// SCPatrolController
  late SCPatrolController controller;

  /// SCWarningCenterController - tag
  String controllerTag = '';

  /// notify
  late StreamSubscription subscription;

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance.getXControllerTag((SCElectronicPatrolPage).toString());
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
    return (SCElectronicPatrolPage).toString();
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
