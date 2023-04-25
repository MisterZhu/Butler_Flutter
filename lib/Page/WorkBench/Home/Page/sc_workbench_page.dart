import 'dart:async';
import 'dart:io';

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
import 'package:smartcommunity/Page/WorkBench/Home/Model/sc_hotel_order_model.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Model/sc_space_model.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Model/sc_verification_order_model.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Model/sc_work_order_model.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/Alert/SwitchSpace/sc_workbench_changespace_alert.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/WorkBench/sc_workbench_view.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import 'package:smartcommunity/Utils/Router/sc_router_path.dart';
import '../../../../Utils/sc_utils.dart';
import '../Model/sc_home_task_model.dart';
import '../View/Alert/sc_task_module_alert.dart';
import '../View/Alert/sc_task_sift_alert.dart';

/// 工作台-page

class SCWorkBenchPage extends StatefulWidget {
  @override
  SCWorkBenchPageState createState() => SCWorkBenchPageState();
}

class SCWorkBenchPageState extends State<SCWorkBenchPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {

  /// 工作台controller
  late SCWorkBenchController workBenchController;

  /// 待处理controller
  late SCWorkBenchListViewController waitController;

  /// 处理中controller
  late SCWorkBenchListViewController processingController;

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

  /// 通知
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
    tabController = TabController(length: workBenchController.tabTitleList.length, vsync: this);
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
    // // 监听接收native_flutter消息
    // SCScaffoldManager.instance.nativeToFlutter.receiveBroadcastStream()
    //     .listen(getNativeData, onError: getNativeDataError);
    // Future.delayed(const Duration(seconds: 5), (){
    //   SCScaffoldManager.instance.flutterToNativeAction(SCFlutterKey.kShowAlert, {"data" : "123"});
    // });
  }

  @override
  dispose() {
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
                tabTitleList: workBenchController.tabTitleList,
                tabController: tabController,
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
                searchAction: () {
                  searchAction();
                },
                siftAction: () {
                  siftAction();
                },
                verificationDetailAction: (SCVerificationOrderModel model) {
                  verificationDetailAction(model);
                },
                hotelOrderDetailAction: (SCHotelOrderModel model) {
                  hotelOrderDetailAction(model);
                },
              );
            });
      }),
    );
  }

  /// 详情
  detailAction(SCWorkOrderModel model) async{
    String title = SCUtils.getWorkOrderButtonText(model.status ?? 0);
    String url =
        "${SCConfig.BASE_URL}${SCH5.workOrderUrl}?isFromWorkBench=1&status=${model.status}&orderId=${model.orderId}&isCharge=${model.isCharge}&spaceId=${model.spaceId}&communityId=${model.communityId}";
    if ((model.yycOrderType ?? 0) >= 99) {
      int type = model.yycOrderType ?? 0;
      if (type == 99) {
        title = "提交检查";
      } else if (type == 100) {
        title = "通过";
      } else if (type == 101) {
        title = "回退";
      }
      url =
          "${SCConfig.BASE_URL}${SCH5.workOrderUrl}?isFromWorkBench=1&status=${model.status}&orderId=${model.orderId}&isCharge=0&type=$type&spaceId=${model.spaceId}&communityId=${model.communityId}";
    }
    if (Platform.isAndroid) {
      String realUrl = SCUtils.getWebViewUrl(url: url,title: title,  needJointParams: true);

      /// 调用Android WebView
      var params = {"title": model.description, "url": realUrl};
      var channel = SCScaffoldManager.flutterToNative;
      var result =
          await channel.invokeMethod(SCScaffoldManager.android_webview, params);
      workBenchController.loadData();
    } else {
      String realUrl = SCUtils.getWebViewUrl(url: url, title: title, needJointParams: true);
      SCRouterHelper.pathPage(SCRouterPath.webViewPath, {
        "title": model.description ?? '',
        "url": realUrl,
        "needJointParams": false
      })?.then((value) {
        workBenchController.loadData();
      });
    }
  }

  /// 实地核验详情
  verificationDetailAction(SCVerificationOrderModel model) {
    int status = model.dealStatus ?? -1;
    if (status == 0) {
      workBenchController.verificationOrderDetailTap('${model.id})').then((value) {
        String realUrl = SCUtils.getWebViewUrl(url: '${SCConfig.getH5Url(SCH5.verificationDetailUrl)}?isFromWorkBench=1',title: '',  needJointParams: true);
        SCRouterHelper.pathPage(SCRouterPath.webViewPath, {
          "title":  '',
          "url": realUrl,
          "needJointParams": false
        })?.then((value) {
          workBenchController.loadData();
        });
      });
    } else if (status == 1) {
      String realUrl = SCUtils.getWebViewUrl(url: SCConfig.getH5Url(SCH5.verificationDetailUrl),title: '',  needJointParams: true);
      SCRouterHelper.pathPage(SCRouterPath.webViewPath, {
        "title":  '',
        "url": realUrl,
        "needJointParams": false
      })?.then((value) {
        workBenchController.loadData();
      });
    } else {

    }
  }
  /// 酒店订单处理详情
  hotelOrderDetailAction(SCHotelOrderModel model) {
    String realUrl = SCUtils.getWebViewUrl(url: '${SCConfig.getH5Url(SCH5.hotelOrderDetailUrl)}?isFromWorkBench=1&orderId=${model.id ?? ''}', title: '', needJointParams: true);
    SCRouterHelper.pathPage(SCRouterPath.webViewPath, {
      "title":  model.hotelName,
      "url": realUrl,
      "needJointParams": true
    })?.then((value) {
      workBenchController.loadData();
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
  messageAction() {
    SCRouterHelper.pathPage(SCRouterPath.messagePage, null);
  }

  /// 卡片详情
  cardDetailAction(int index) {}

  /// 用户信息
  userInfoAction() {
    SCRouterHelper.pathPage(SCRouterPath.personalInfoPath, null);
  }

  /// 点击搜索
  searchAction() {
    SCRouterHelper.pathPage(SCRouterPath.workBenchSearchPage, null);
  }

  /// 点击筛选
  siftAction() {
    SCUtils.getCurrentContext(completionHandler: (BuildContext context) {
      SCDialogUtils().showCustomBottomDialog(
          isDismissible: true,
          context: context,
          widget: SCTaskSiftAlert(
            myTaskList: workBenchController.tabTitleList,
            taskTypeList: workBenchController.taskTypeList,
            selectTaskList: workBenchController.myTaskSelectList,
            selectTypeList: workBenchController.taskTypeSelectList,
            resetAction: () {
              workBenchController.initFilterData();
              Navigator.of(context).pop();
              tabController.animateTo(0);
              workBenchController.loadData();
            },
            sureAction: (list1, list2) {
              int index = workBenchController.updateMyTaskSelectList(list1);
              workBenchController.updateTaskTypeSelectList(list2);
              Navigator.of(context).pop();
              if (index >= 0) {
                tabController.animateTo(index);
              }
              workBenchController.loadData();
            },
          ));
    });
  }

  /// 通知
  addNotification() {
    subscription = SCScaffoldManager.instance.eventBus.on().listen((event) {
      String key = event['key'];
      if (key == SCKey.kSwitchEnterprise || key == SCKey.kRefreshWorkBenchPage) {
        workBenchController.loadData();
      }
    });
  }

  /*获得到原生传递过来的消息*/
  void getNativeData(dynamic data) {
    // print('原生传递过来的消息:${data.toString()}');
    //
    // Map<String, dynamic> baseParams = Map<String, dynamic>.from(data);
    // String? key = baseParams['key'];
    // Map<String, dynamic> params =
    // new Map<String, dynamic>.from(baseParams['data']);
  }

  /*获取到错误*/
  void getNativeDataError(Object err) {}

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
