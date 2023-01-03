import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_h5.dart';
import 'package:smartcommunity/Constants/sc_key.dart';
import 'package:smartcommunity/Network/sc_config.dart';
import 'package:smartcommunity/Page/WorkBench/Home/GetXController/sc_changespace_controller.dart';
import 'package:smartcommunity/Page/WorkBench/Home/GetXController/sc_workbench_controller.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Model/sc_space_model.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Model/sc_work_order_model.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/Alert/SwitchSpace/sc_workbench_changespace_alert.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/WorkBench/sc_workbench_view.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import 'package:smartcommunity/Utils/Router/sc_router_path.dart';
import '../../../../Utils/sc_utils.dart';
import '../Model/sc_home_task_model.dart';
import '../View/Alert/sc_task_module_alert.dart';

/// 工作台-page

class SCWorkBenchPage extends StatefulWidget {
  @override
  SCWorkBenchPageState createState() => SCWorkBenchPageState();
}

class SCWorkBenchPageState extends State<SCWorkBenchPage>
    with SingleTickerProviderStateMixin {
  late SCWorkBenchController workBenchController;

  /// tab-title
  List<String> tabTitleList = ['待处理', '处理中'];

  /// 分类
  List<String> classificationList = [
    '工单处理',
    '订单处理',
    '居民审核',
    '维保维修',
    '三巡一保',
    '报事报修',
    '工单处理'
  ];

  /// tabController
  late TabController tabController;

  /// SCWorkBenchController - tag
  String workBenchControllerTag = '';

  /// changeSpaceController
  SCChangeSpaceController changeSpaceController =
      Get.put(SCChangeSpaceController());

  late StreamSubscription subscription;

  @override
  initState() {
    super.initState();
    SCUtils().changeStatusBarStyle(style: SystemUiOverlayStyle.dark);
    String pageName = (SCWorkBenchPage).toString();
    workBenchControllerTag =
        SCScaffoldManager.instance.getXControllerTag(pageName);

    workBenchController =
        Get.put(SCWorkBenchController(), tag: workBenchControllerTag);
    workBenchController.tag = workBenchControllerTag;
    workBenchController.pageName = pageName;
    tabController = TabController(length: tabTitleList.length, vsync: this);
    addNotification();
  }

  @override
  dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SCColors.color_FFFFFF,
      resizeToAvoidBottomInset: false,
      body: body(),
    );
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return GetBuilder<SCWorkBenchController>(
            tag: workBenchControllerTag,
            init: workBenchController,
            builder: (value) {
              return SCWorkBenchView(
                state: workBenchController,
                height: constraints.maxHeight,
                tabTitleList: tabTitleList,
                classificationList: classificationList,
                tabController: tabController,
                tagAction: (index) {},
                menuTap: () {
                  showTaskAlert();
                },
                onRefreshAction: () {
                  workBenchController.loadData();
                },
                detailAction: (SCWorkOrderModel model) {
                  detailAction(model);
                },
                showSpaceAlert: () {
                  showSpaceAlert();
                },
                scanAction: () {
                  scanAction();
                },
                messageAction: () {
                  messageAction();
                },
                cardDetailAction: (int index) {
                  cardDetailAction(index);
                },
              );
            });
      }),
    );
  }

  /// 弹出任务模块弹窗
  showTaskAlert() {
    List testList = [
      {'id': '0', 'name': '全部', 'isSelect': false},
      {'id': '1', 'name': '工单处理', 'isSelect': false},
      {'id': '2', 'name': '居民审核', 'isSelect': false},
      {'id': '3', 'name': '维保任务', 'isSelect': false},
      {'id': '4', 'name': '巡检任务', 'isSelect': false},
      {'id': '5', 'name': '巡查任务', 'isSelect': false},
      {'id': '6', 'name': '巡更任务', 'isSelect': false},
      {'id': '7', 'name': '装修审核', 'isSelect': false},
      {'id': '8', 'name': '资产审核', 'isSelect': false},
    ];
    List<SCHomeTaskModel> list =
        testList.map((e) => SCHomeTaskModel.fromJson(e)).toList();
    SCUtils.getCurrentContext(completionHandler: (BuildContext context) {
      SCDialogUtils().showCustomBottomDialog(
          isDismissible: true,
          context: context,
          widget: SCTaskModuleAlert(
            list: list,
            closeTap: (selectList) {},
          ));
    });
  }

  /// 详情
  detailAction(SCWorkOrderModel model) {
    String url =
        "${SCConfig.BASE_URL}${SCH5.workOrderUrl}?status=${model.status}&title=${model.status}&orderId=${model.orderId}&isCharge=${model.isCharge}&spaceId=${model.spaceId}&communityId=${model.communityId}&from=qwHome";
    SCRouterHelper.pathPage(SCRouterPath.webViewPath, {
      "title": model.categoryName ?? '',
      "url": url,
      "needJointParams": true
    });
  }

  /// 空间弹窗
  showSpaceAlert() {
    changeSpaceController.clearData();
    changeSpaceController.initBase();
    changeSpaceController.loadManageTreeData(
        success: (List<SCSpaceModel> list) {
      SCDialogUtils().showCustomBottomDialog(
          context: context,
          isDismissible: true,
          widget: GetBuilder<SCChangeSpaceController>(builder: (state) {
            return SCWorkBenchChangeSpaceAlert(
              changeSpaceController: changeSpaceController,
              selectList: state.selectList,
              onCancel: () {},
              onSure: () {
                changeSpaceController.switchSpace(success: () {
                  workBenchController.loadData();
                });
              },
            );
          }));
    });
  }

  /// 扫一扫
  scanAction() {
    SCRouterHelper.pathPage(SCRouterPath.scanPath, null);
  }

  /// 消息
  messageAction() {}

  /// 卡片详情
  cardDetailAction(int index) {}

  /// 通知
  addNotification() {
    subscription = SCScaffoldManager.instance.eventBus.on().listen((event) {
      String key = event['key'];
      if (key == SCKey.kSwitchEnterprise) {
        workBenchController.loadData();
      }
    });
  }
}
