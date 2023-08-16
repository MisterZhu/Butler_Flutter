import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/Patrol/View/Search/sc_patrol_search_view.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import 'package:smartcommunity/Skin/View/sc_custom_scaffold.dart';
import '../../../../Constants/sc_key.dart';
import '../Controller/sc_patrol_search_controller.dart';

/// 搜索巡查page

class SCSearchPatrolPage extends StatefulWidget {
  @override
  SCSearchPatrolPageState createState() => SCSearchPatrolPageState();
}

class SCSearchPatrolPageState extends State<SCSearchPatrolPage> with AutomaticKeepAliveClientMixin{

  /// SCSearchPatrolController
  late SCSearchPatrolController controller;

  /// SCSearchPatrolController - tag
  String controllerTag = '';

  /// notify
  late StreamSubscription subscription;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance.getXControllerTag((SCSearchPatrolPage).toString());
    controller = Get.put(SCSearchPatrolController(), tag: controllerTag);
    controller.initParams(Get.arguments);
    addNotification();
  }

  /// 通知
  addNotification() {
    subscription = SCScaffoldManager.instance.eventBus.on().listen((event) {
      String key = event['key'];
      if (key == SCKey.kRefreshPatrolPage) {
        controller.searchData(isMore: false);
      }
    });
  }

  @override
  dispose() {
    subscription.cancel();
    SCScaffoldManager.instance.deleteGetXControllerTag((SCSearchPatrolPage).toString(), controllerTag);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "搜索",
        centerTitle: true,
        elevation: 0,
        resizeToAvoidBottomInset: false,
        body: body());
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: GetBuilder<SCSearchPatrolController>(
          tag: controllerTag,
          init: controller,
          builder: (state) {
            return SCSearchPatrolView(state: state);
          }),
    );
  }

}