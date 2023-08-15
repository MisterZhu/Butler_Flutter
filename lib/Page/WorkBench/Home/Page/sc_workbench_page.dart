import 'dart:async';
import 'dart:convert';
import 'dart:developer';
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
import '../Model/sc_scan_result_model.dart';
import '../View/Alert/sc_card_time_filtrate_alert.dart';
import '../View/Alert/sc_task_sift_alert.dart';
import '../View/AppBar/sc_workbench_search.dart';

/// 工作台-page

class SCWorkBenchPage extends StatefulWidget {
  @override
  SCWorkBenchPageState createState() => SCWorkBenchPageState();
}

class SCWorkBenchPageState extends State<SCWorkBenchPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  /// 工作台controller
  late SCWorkBenchController workBenchController;

  /// SCWorkBenchController - tag
  String workBenchControllerTag = '';

  /// changeSpaceController
  SCChangeSpaceController changeSpaceController =
      Get.put(SCChangeSpaceController());

  /// 通知
  late StreamSubscription subscription;

  /// pageName
  late String pageName;

  /// tabController
  late TabController tabController;

  @override
  initState() {
    super.initState();
    SCUtils().changeStatusBarStyle(style: SystemUiOverlayStyle.dark);
    pageName = (SCWorkBenchPage).toString();
    workBenchControllerTag =
        SCScaffoldManager.instance.getXControllerTag(pageName);
    workBenchController =
        Get.put(SCWorkBenchController(), tag: workBenchControllerTag);
    workBenchController.tag = workBenchControllerTag;
    workBenchController.pageName = pageName;
    addNotification();
    workBenchController.startTimer();
    workBenchController.initData();
    tabController = TabController(
        length: workBenchController.tabTitleList.length, vsync: this);
    tabController.addListener(() {
      if (workBenchController.currentWorkOrderIndex != tabController.index) {
        workBenchController.updateCurrentWorkOrderIndex(tabController.index);
      }
    });
  }

  @override
  dispose() {
    super.dispose();
    subscription.cancel();
    SCScaffoldManager.instance
        .deleteGetXControllerTag(pageName, workBenchControllerTag);
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
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Column(
        children: [rightItem(), workBenchView()],
      ),
    );
  }

  ///导航栏
  Widget rightItem() {
    return GetBuilder<SCWorkBenchController>(
      init: workBenchController, // 初始化控制器
      builder: (controller) {
        return SCWorkBenchSearch(
          unreadNum: SCScaffoldManager.instance.unreadMessageCount,
          searchAction: () {
            searchAction();
          },
          scanAction: () {
            scanAction();
          },
          messageAction: () {
            messageAction();
          },
        ); // 将你想要包裹的 Widget 放在 builder 函数中返回
      },
    );
  }

  /// 工作台
  Widget workBenchView() {
    Widget contentView;
    if (workBenchController.tabTitleList.isNotEmpty) {
      contentView = Expanded(child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return GetBuilder<SCWorkBenchController>(
            tag: workBenchControllerTag,
            init: workBenchController,
            builder: (value) {
              return SCWorkBenchView(
                state: workBenchController,
                height: constraints.maxHeight,
                tabTitleList: workBenchController.tabTitleList,
                tabController: tabController,
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
                cardTimeAction: () {
                  // 卡片时间筛选
                  cardTimeAction();
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
      }));
    } else {
      contentView = const SizedBox();
    }
    return contentView;
  }

  /// 详情
  detailAction(SCWorkOrderModel model) async {
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
      String realUrl =
          SCUtils.getWebViewUrl(url: url, title: title, needJointParams: true);

      /// 调用Android WebView
      var params = {"title": model.description, "url": realUrl};
      var channel = SCScaffoldManager.flutterToNative;
      var result =
          await channel.invokeMethod(SCScaffoldManager.android_webview, params);
      workBenchController.loadData();
    } else {
      String realUrl =
          SCUtils.getWebViewUrl(url: url, title: title, needJointParams: true);
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
      workBenchController
          .verificationOrderDetailTap('${model.id})')
          .then((value) {
        String realUrl = SCUtils.getWebViewUrl(
            url:
                '${SCConfig.getH5Url(SCH5.verificationDetailUrl)}?isFromWorkBench=1',
            title: '',
            needJointParams: true);
        SCRouterHelper.pathPage(SCRouterPath.webViewPath, {
          "title": '',
          "url": realUrl,
          "needJointParams": false
        })?.then((value) {
          workBenchController.loadData();
        });
      });
    } else if (status == 1) {
      String realUrl = SCUtils.getWebViewUrl(
          url: SCConfig.getH5Url(SCH5.verificationDetailUrl),
          title: '',
          needJointParams: true);
      SCRouterHelper.pathPage(SCRouterPath.webViewPath, {
        "title": '',
        "url": realUrl,
        "needJointParams": false
      })?.then((value) {
        workBenchController.loadData();
      });
    } else {}
  }

  /// 酒店订单处理详情
  hotelOrderDetailAction(SCHotelOrderModel model) {
    String realUrl = SCUtils.getWebViewUrl(
        url:
            '${SCConfig.getH5Url(SCH5.hotelOrderDetailUrl)}?isFromWorkBench=1&orderId=${model.id ?? ''}',
        title: '',
        needJointParams: true);
    SCRouterHelper.pathPage(SCRouterPath.webViewPath, {
      "title": model.hotelName,
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
  scanAction() async {
    var data = await SCRouterHelper.pathPage(SCRouterPath.scanPath, null);
    print("扫码结果333===$data=======");
    Map<String, dynamic> map = json.decode(data);
    ScanResultModel model = ScanResultModel.fromJson(map);
    //TODO 待优化
    switch (model.code) {
      case "100001":
        String token = SCScaffoldManager.instance.user.token ?? '';
        var url = "${model.url}&Authorization=$token";
        var params = {
          'title': "访客管理",
          'url': SCUtils.getWebViewUrl(
              url: url, title: "访客管理", needJointParams: true),
          'removeLoginCheck': true
        };
        SCRouterHelper.pathPage(SCRouterPath.webViewPath, params);
        break;
      case "100002":
        String token = SCScaffoldManager.instance.user.token ?? '';
        var url = "${model.url}&Authorization=$token";
        var params = {
          'title': "物品出门",
          'url': SCUtils.getWebViewUrl(
              url: url, title: "物品出门", needJointParams: true),
          'removeLoginCheck': true
        };
        SCRouterHelper.pathPage(SCRouterPath.webViewPath, params);
        break;
      case "100003":
        String token = SCScaffoldManager.instance.user.token ?? '';
        var url = "${model.url}&Authorization=$token";
        var params = {
          'title': "物品借用",
          'url': SCUtils.getWebViewUrl(
              url: url, title: "物品借用", needJointParams: true),
          'removeLoginCheck': true
        };
        SCRouterHelper.pathPage(SCRouterPath.webViewPath, params);
        break;
      case "100004":
        String token = SCScaffoldManager.instance.user.token ?? '';
        var url = "${model.url}&Authorization=$token";
        var params = {
          'title': "物品寄存",
          'url': SCUtils.getWebViewUrl(
              url: url, title: "物品寄存", needJointParams: true),
          'removeLoginCheck': true
        };
        SCRouterHelper.pathPage(SCRouterPath.webViewPath, params);
        break;
    }
  }

  /// 消息
  messageAction() {
    SCRouterHelper.pathPage(SCRouterPath.messagePage, null)?.then((value) {
      workBenchController.loadUnreadMessageCount();
    });
  }

  /// 卡片详情点击
  cardDetailAction(int index) {

    if(index == 1){
      ///工单
      String timeTitle = workBenchController.selectTimeTypeList.first;
      int unitCode = 1;
      if(timeTitle == "今日"){
        unitCode = 1;
      }else if(timeTitle == "本周"){
        unitCode = 4;
      }else if(timeTitle == "下周"){
        unitCode = 6;
      }else if(timeTitle == "上周"){
        unitCode = 5;
      }else if(timeTitle == "本月"){
        unitCode = 2;
      }else if(timeTitle == "上月"){
        unitCode = 7;
      }else if(timeTitle == "下月"){
        unitCode = 8;
      }

      String token = SCScaffoldManager.instance.user.token ?? '';
      var url = "${SCConfig.getH5Url(SCH5.gongdanUrl)}$unitCode&Authorization=$token";
      var params = {
        'title': "工单",
        'url': SCUtils.getWebViewUrl(
            url: url, title: "工单", needJointParams: false)
      };
      SCRouterHelper.pathPage(SCRouterPath.webViewPath, params);
    }

  }

  /// 卡片时间筛选
  cardTimeAction() {
    SCUtils.getCurrentContext(completionHandler: (BuildContext context) {
      SCDialogUtils().showCustomBottomDialog(
          isDismissible: true,
          context: context,
          widget: SCCardTimeFiltrateAlert(
              timeList: workBenchController.timeTypeDataList,
              selectTimeTypeList: workBenchController.selectTimeTypeList,
              resetAction: () {
                workBenchController.initFilterData();
                Navigator.of(context).pop();
                tabController.animateTo(0);
                workBenchController.loadData();
              },
              sureAction: (selectTimeTypeList) {
                //print(selectTimeTypeList);
                Navigator.of(context).pop();
                workBenchController.selectTimeTypeList = selectTimeTypeList;
                workBenchController.getTaskCount();
              }));
    });
  }

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
            canEditMyTask: true,
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
            editMyTaskAction: () {
              Navigator.of(context).pop();
              editWorkBenchAction();
            },
          ));
    });
  }

  /// 编辑工作台
  editWorkBenchAction() async {
    List myTaskTitleList = workBenchController.tabTitleList;
    List allTaskTitleList = workBenchController.getAllTabTitleData();
    var params = {
      SCKey.kWorkBenchAllTabTitleListKey: allTaskTitleList,
      SCKey.kWorkBenchMyTabTitleListKey: myTaskTitleList
    };
    var result =
        await SCRouterHelper.pathPage(SCRouterPath.workBenchEditPage, params);
    List editMyTaskTitleList = [];
    if ((result ?? {}).containsKey('data')) {
      editMyTaskTitleList = result['data'];
      if (editMyTaskTitleList.length >= 2) {
        workBenchController.updateLocalCacheTab(
            list: editMyTaskTitleList,
            completeHandler: () {
              tabController = TabController(
                  length: workBenchController.tabTitleList.length, vsync: this);
              workBenchController.update();
            });
      }
    }
  }

  /// 通知
  addNotification() {
    subscription = SCScaffoldManager.instance.eventBus.on().listen((event) {
      String key = event['key'];
      if (key == SCKey.kSwitchEnterprise ||
          key == SCKey.kRefreshWorkBenchPage ||
          key == SCKey.kRefreshPatrolPage) {
        workBenchController.loadData(loadAllToDo: true);
      } else if (key == SCKey.kReloadUnreadMessageCount) {
        workBenchController.update();
      } else if (key == SCKey.kRefreshdUnreadMessageCount) {
        log("调用唯独消息接口");
        workBenchController.loadUnreadMessageCount();
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
