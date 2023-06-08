import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/Patrol/Page/sc_patrol_detail_new_view.dart';
import 'package:smartcommunity/Page/ApplicationModule/Patrol/View/Detail/sc_patrol_detail_view.dart';
import 'package:smartcommunity/Page/ApplicationModule/Patrol/Other/sc_patrol_utils.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import '../../../../Constants/sc_asset.dart';
import '../../../../Constants/sc_key.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../../../../Utils/Router/sc_router_path.dart';
import '../../../../Utils/sc_utils.dart';
import '../../MaterialEntry/View/Alert/sc_reject_alert.dart';
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

  late SCPatrolUtils patrolUtils;

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance
        .getXControllerTag((SCPatrolDetailPage).toString());
    controller = Get.put(SCPatrolDetailController(), tag: controllerTag);
    controller.initParams(Get.arguments);
    patrolUtils = SCPatrolUtils();
    patrolUtils.taskId = controller.model.taskId ?? '';
    patrolUtils.procInstId = controller.procInstId;
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
               //     Expanded(child: SCPatrolDetailView(state: state,)),
                  //测试数据
                    getPatrolView(state),
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

  Widget getPatrolView(state){
    if(controller.type == "POLICED_WATCH"){
     return Expanded(child: PatrolDetailNewView(state:state));
    }else{
     return Expanded(child: SCPatrolDetailView(state: state,));
    }
  }



  /// 底部按钮
  Widget bottomView() {
    return Offstage(
      offstage: (controller.model.actionVo ?? []).isEmpty,
      child: SCMaterialDetailBottomView(
        list: controller.bottomButtonList,
        onTap: (value) {
          if (value == "更多") {
            controller.updateMoreDialogStatus();
          } else {
            taskAction(value);
          }
        },
      ),
    );
  }

  /// 任务处理
  taskAction(String name) {
    SCPatrolUtils patrolUtils = SCPatrolUtils();
    patrolUtils.taskId = controller.model.taskId ?? '';
    patrolUtils.procInstId = controller.procInstId;
    patrolUtils.nodeId = controller.nodeId;
    patrolUtils.taskAction(name: name, isDetailPage: true);
  }

  /// pageName
  String pageName() {
    return (SCPatrolDetailPage).toString();
  }

  /// 通知
  addNotification() {
    subscription = SCScaffoldManager.instance.eventBus.on().listen((event) {
      String key = event['key'];
      print("刷新数据=======================$key=======");
      if (key == SCKey.kRefreshPatrolDetailPage) {
        controller.getDetailData();
      }
    });
  }

  @override
  bool get wantKeepAlive => true;
}
