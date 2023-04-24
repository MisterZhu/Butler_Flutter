import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/HouseInspect/View/sc_bottom_button_item.dart';
import 'package:smartcommunity/Page/ApplicationModule/Patrol/View/Detail/sc_patrol_detail_view.dart';

import '../../../../Constants/sc_key.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../../MaterialEntry/View/Detail/sc_material_bottom_view.dart';
import '../Controller/sc_patrol_detail_controller.dart';

/// 巡查详情page

class SCPatrolDetailPage extends StatefulWidget {
  @override
  SCPatrolDetailPageState createState() => SCPatrolDetailPageState();
}

class SCPatrolDetailPageState extends State<SCPatrolDetailPage> {
  /// SCPatrolDetailController
  late SCPatrolDetailController controller;

  /// SCPatrolDetailController - tag
  String controllerTag = '';

  /// notify
  late StreamSubscription subscription;

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance
        .getXControllerTag((SCPatrolDetailPage).toString());
    controller = Get.put(SCPatrolDetailController(), tag: controllerTag);
    controller.initParams(Get.arguments);
    addNotification();
  }

  @override
  dispose() {
    subscription.cancel();
    SCScaffoldManager.instance
        .deleteGetXControllerTag(pageName(), controllerTag);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "任务处理", centerTitle: true, elevation: 0, body: body());
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: Column(
        children: [contentView(), bottomView()],
      ),
    );
  }

  /// content
  Widget contentView() {
    return Expanded(
        child: GetBuilder<SCPatrolDetailController>(
            tag: controllerTag,
            init: controller,
            builder: (state) {
              if (controller.getDataSuccess) {
                return SCPatrolDetailView(
                  state: state,
                );
              } else {
                return const SizedBox();
              }
            }));
  }

  /// 底部按钮
  Widget bottomView() {
    return SCMaterialDetailBottomView(
      list: [{
        "type": scMaterialBottomViewTypeMore,
        "title": "更多",
      },{
        "type": scMaterialBottomViewType1,
        "title": "提交1",
      }, {
        "type": scMaterialBottomViewType2,
        "title": "提交2",
      },],
    );
  }

  /// pageName
  String pageName() {
    return (SCPatrolDetailPage).toString();
  }

  /// 通知
  addNotification() {
    subscription = SCScaffoldManager.instance.eventBus.on().listen((event) {
      String key = event['key'];
      if (key == SCKey.kRefreshPatrolDetailPage) {
        // controller.loadData(isMore: false);
      }
    });
  }

  @override
  bool get wantKeepAlive => true;
}
