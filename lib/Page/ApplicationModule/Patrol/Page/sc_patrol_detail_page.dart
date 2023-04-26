import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/Patrol/View/Detail/sc_patrol_detail_view.dart';
import '../../../../Constants/sc_asset.dart';
import '../../../../Constants/sc_key.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../../../../Utils/sc_utils.dart';
import '../../MaterialEntry/View/Detail/sc_material_bottom_view.dart';
import '../Controller/sc_patrol_detail_controller.dart';
import '../View/Alert/sc_deal_alert.dart';
import '../View/Alert/sc_more_button_dialog.dart';

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
        title: "详情", centerTitle: true, elevation: 0, body: body());
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: GetBuilder<SCPatrolDetailController>(
        tag: controllerTag,
        init: controller,
        builder: (state) {
          if (controller.getDataSuccess) {
            return Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Column(
                  children: [
                    Expanded(child: SCPatrolDetailView(state: state,)),
                    bottomView()
                  ]
                ),
                Offstage(
                  offstage: !state.showMoreDialog,
                  child: SCMoreButtonDialog(
                    list: state.moreButtonList,
                    closeAction: () {
                      controller.updateMoreDialogStatus();
                    },
                    tapAction: (index) {
                      taskAction(state.moreButtonList[index]);
                      controller.updateMoreDialogStatus();
                    },),
                ),
              ],
            );
          } else {
            return const SizedBox();
          }
        }),
    );
  }

  /// 底部按钮
  Widget bottomView() {
    return SCMaterialDetailBottomView(
      list: controller.bottomButtonList,
      onTap: (value) {
        if (value == "更多") {
          controller.updateMoreDialogStatus();
        } else {
          taskAction(value);
        }
      },
    );
  }

  /// 任务操作
  taskAction(String name) {
    print('任务操作========$name');
    if (name == '添加日志') {

    } else if (name == '回退') {

    } else if (name == '关闭') {

    } else if (name == '处理') {

    } else if (name == '转派') {

    }
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
