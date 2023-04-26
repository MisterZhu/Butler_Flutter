import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/Patrol/View/Detail/sc_patrol_detail_view.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import '../../../../Constants/sc_asset.dart';
import '../../../../Constants/sc_key.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../../../../Utils/Router/sc_router_path.dart';
import '../../../../Utils/sc_utils.dart';
import '../../MaterialEntry/View/Detail/sc_material_bottom_view.dart';
import '../Controller/sc_patrol_detail_controller.dart';
import '../View/Alert/sc_deal_alert.dart';

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
            return Column(
                children: [
                  Expanded(child: SCPatrolDetailView(state: state,)),
                  bottomView()
                ]
            );
          } else {
            return const SizedBox();
          }
        }),
    );
  }

  /// 底部按钮
  Widget bottomView() {
    List btnList = [];
    List moreList = [];
    if ((controller.model.actionVo ?? []).isNotEmpty) {
      List<String> list = controller.model.actionVo!;
      if (list.length == 1) {
        btnList = [
          {
          "type": scMaterialBottomViewType2,
          "title": list.first,
        }];
      } else if (list.length == 2) {
        btnList = [
          {
            "type": scMaterialBottomViewType1,
            "title": list[1],
          },
          {
            "type": scMaterialBottomViewType2,
            "title": list.first,
          }];
      } else {
        btnList = [
          {
          "type": scMaterialBottomViewTypeMore,
          "title": "更多",
          },{
          "type": scMaterialBottomViewType1,
            "title": list[1],
          }, {
          "type": scMaterialBottomViewType2,
            "title": list.first,
        }];
        for (int i = 2; i <list.length; i++) {
          moreList.add({'name': list[i], 'icon': SCAsset.iconPatrolTransfer});
        }
      }
    }
    return SCMaterialDetailBottomView(
      list: btnList,
      onTap: (value) {
        if (value == "更多") {
          moreAction(moreList);
        } else if (value == "处理") {

        } else if (value == "转派") {
          transfer();
        }
      },
    );
  }

  /// 点击更多按钮
  moreAction(List list) {
    SCUtils.getCurrentContext(completionHandler: (BuildContext context) {
      SCDialogUtils().showCustomBottomDialog(
          isDismissible: true,
          context: context,
          widget: SCDealAlert(
            list: list,
            tapAction: (name) {
              if (name == '添加日志') {

              } else if (name == '回退') {

              } else if (name == '关闭') {

              } else if (name == '处理') {

              } else if (name == '转派') {
                  transfer();
              }
            },
          ));
    });

  }

  /// 转派
  transfer() {
    SCRouterHelper.pathPage(SCRouterPath.patrolTransferPage, null);
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
