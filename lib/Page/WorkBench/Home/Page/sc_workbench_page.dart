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
import 'package:smartcommunity/Page/WorkBench/Home/GetXController/sc_wrokbench_listview_controller.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Model/sc_space_model.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Model/sc_work_order_model.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/Alert/SwitchSpace/sc_workbench_changespace_alert.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/WorkBench/sc_workbench_view.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import 'package:smartcommunity/Utils/Router/sc_router_observer.dart';
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
    with SingleTickerProviderStateMixin,RouteAware {

  /// 工作台controller
  late SCWorkBenchController workBenchController;

  /// 待处理controller
  late SCWorkBenchListViewController waitController;

  /// 处理中controller
  late SCWorkBenchListViewController processingController;

  /// tab-title
  List<String> tabTitleList = ['待处理', '处理中'];

  /// tabController
  late TabController tabController;

  /// SCWorkBenchController - tag
  String workBenchControllerTag = '';

  /// 待处理SCWorkBenchListViewController - tag
  String waitControllerTag = '';

  /// 处理中SCWorkBenchListViewController - tag
  String processingControllerTag = '';

  /// changeSpaceController
  SCChangeSpaceController changeSpaceController =
      Get.put(SCChangeSpaceController());

  late StreamSubscription subscription;

  late String pageName;

  @override
  initState() {
    super.initState();
    SCUtils().changeStatusBarStyle(style: SystemUiOverlayStyle.dark);
    pageName = (SCWorkBenchPage).toString();
    workBenchControllerTag =
        SCScaffoldManager.instance.getXControllerTag(pageName);
    waitControllerTag = SCScaffoldManager.instance.getXControllerTag(pageName);
    processingControllerTag = SCScaffoldManager.instance.getXControllerTag(pageName);
    workBenchController =
        Get.put(SCWorkBenchController(), tag: workBenchControllerTag);
    workBenchController.tag = workBenchControllerTag;
    workBenchController.pageName = pageName;
    tabController = TabController(length: tabTitleList.length, vsync: this);
    waitController =
        Get.put(SCWorkBenchListViewController(), tag: waitControllerTag);
    workBenchController.tag = waitControllerTag;
    workBenchController.pageName = pageName;
    processingController =
        Get.put(SCWorkBenchListViewController(), tag: processingControllerTag);
    processingController.tag = processingControllerTag;
    processingController.pageName = pageName;
    workBenchController.waitController = waitController;
    workBenchController.processingController = processingController;
    addNotification();
    workBenchController.startTimer();
    tabController.addListener(() {
      if (workBenchController.currentWorkOrderIndex != tabController.index) {
        workBenchController.updateCurrentWorkOrderIndex(tabController.index);
      }
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    /// 路由订阅
    SCAppRouteObserver().routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  /// Called when the top route has been popped off, and the current route
  @override
  void didPopNext() {
    workBenchController.loadData();
  }

  @override
  dispose() {
    /// 取消路由订阅
    SCAppRouteObserver().routeObserver.unsubscribe(this);
    super.dispose();
    subscription.cancel();
    SCScaffoldManager.instance.deleteGetXControllerTag(pageName, workBenchControllerTag);
    SCScaffoldManager.instance.deleteGetXControllerTag(pageName, waitControllerTag);
    SCScaffoldManager.instance.deleteGetXControllerTag(pageName, processingControllerTag);
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
                waitController: waitController,
                doingController: processingController,
                height: constraints.maxHeight,
                tabTitleList: tabTitleList,
                classificationList: workBenchController.plateList,
                tabController: tabController,
                tagAction: (index) {
                  if (workBenchController.currentPlateIndex != index) {
                    workBenchController.updatePlateIndex(index);
                  }
                },
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
                headerAction: () {
                  userInfoAction();
                },
              );
            });
      }),
    );
  }

  /// 弹出任务模块弹窗
  showTaskAlert() {
    List<SCHomeTaskModel> list = [];
    for (int i=0; i<workBenchController.plateList.length; i++) {
      var map = workBenchController.plateList[i];
      list.add(SCHomeTaskModel.fromJson({"name" : map['title'], "id" : "${map["type"]}", "isSelect" : i == workBenchController.currentPlateIndex}));
    }
    SCUtils.getCurrentContext(completionHandler: (BuildContext context) {
      SCDialogUtils().showCustomBottomDialog(
          isDismissible: true,
          context: context,
          widget: SCTaskModuleAlert(
            list: list,
            currentIndex: workBenchController.currentPlateIndex,
            closeTap: (SCHomeTaskModel model, int index) {
              workBenchController.updatePlateIndex(index);
            },
          ));
    });
  }

  /// 详情
  detailAction(SCWorkOrderModel model) {
    String title = Uri.encodeComponent(SCUtils.getWorkOrderButtonText(model.status ?? 0));
    String url =
        "${SCConfig.BASE_URL}${SCH5.workOrderUrl}?status=${model.status}&title=$title&orderId=${model.orderId}&isCharge=${model.isCharge}&spaceId=${model.spaceId}&communityId=${model.communityId}&from=qwHome";
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

  /// 用户信息
  userInfoAction() {
    SCRouterHelper.pathPage(SCRouterPath.personalInfoPath, null);
  }

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
