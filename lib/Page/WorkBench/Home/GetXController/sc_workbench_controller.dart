import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Network/sc_http_manager.dart';
import 'package:smartcommunity/Network/sc_url.dart';
import 'package:smartcommunity/Page/Login/Home/Model/sc_user_model.dart';
import 'package:smartcommunity/Page/WorkBench/Home/GetXController/sc_changespace_controller.dart';
import 'package:smartcommunity/Page/WorkBench/Home/GetXController/sc_workbench_todo_controller.dart';
import 'package:smartcommunity/Page/WorkBench/Home/GetXController/sc_wrokbench_listview_controller.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Model/sc_hotel_order_model.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Model/sc_default_config_model.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Model/sc_space_model.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Model/sc_verification_order_model.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/WorkBench/sc_workbench_todo_listview.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import 'package:smartcommunity/Utils/Permission/sc_permission_utils.dart';
import '../../../../Constants/sc_key.dart';
import '../../../../Utils/Location/sc_location_model.dart';
import '../../../ApplicationModule/MaterialEntry/Model/sc_material_entry_model.dart';
import '../../../../Utils/sc_sp_utils.dart';
import '../Model/sc_work_order_model.dart';

/// 工作台Controller

class SCWorkBenchController extends GetxController{

  String pageName = '';

  String tag = '';

  /// 抢单数量
  int orderNum = 0;

  /// 工单数量
  int workOrderNum = 0;

  /// 今日任务数量
  //int taskNum = 0;

  /// 收缴率
  //num collectionRate = 0;

  /// 今日服务业主数量
  //int serviceNum = 0;

  /// 时间类型
  List timeTypeDataList = [];

  /// 当前选中时间类型
  List selectTimeTypeList = [];

  List numDataList = [];

  /// 空间名称
  String spaceName = '';

  /// 定时器
  late Timer timer;

  /// 当前工单index,0-待处理,1-处理中
  int currentWorkOrderIndex = 0;

  /// 当前板块index,0-工单处理，1-实地核验，2-订单处理
  int currentPlateIndex = 0;

  /// 任务类型
  List taskTypeDataList = [];

  /// 任务类型数组
  List taskTypeList = [];

  /// 任务类型key
  List taskTypeKeyList = [];

  /// 任务类型value
  List taskTypeValueList = [];

  /// 我的任务选中的数组
  List myTaskSelectList = [];

  /// 任务类型选中的数组
  List taskTypeSelectList = [];

  /// tab-data
  List tabDataList = [];

  /// tab-title
  List<String> tabTitleList = [];

  /// tabBarView-list
  List<Widget> tabBarViewList = [];

  /// tab-GetXController
  List<SCWorkBenchToDoController> todoControllerList = [];

  /// tab-GetXController
  List todoControllerTagList = [];

  /// 待办——key
  List todoKeyList = [];
//未读消息
  RxInt unreadMegNum = 0.obs;
  @override
  onInit() {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 2000), () {location();});
    // startTimer();
  }

  /// 初始化
  initData() {
    getLocalCacheTab();
    taskTypeList = ['全部', '工单服务', '审批中心', '巡查任务', '收费账单'];
    initToDoController();
    initFilterData();
    loadData(loadAllToDo: true);
    loadUnreadMessageCount();
    getLocalCacheTab();
  }

  /// 初始化tabData
  initTabData(List list) {
    timeTypeDataList = [];
    tabDataList = list;
    tabTitleList = [];
    todoKeyList = [];
    taskTypeList = [];
    taskTypeKeyList = [];
    taskTypeValueList = [];
    for (var params in tabDataList) {
      tabTitleList.add(params['title']);
      todoKeyList.add(params['key']);
    }

    timeTypeDataList = [
      {
        "title": "今日",
        "key": "",
        "value": "1"
      },
      {
        "title": "本周",
        "key": "",
        "value": "4"
      },
      {
        "title": "下周",
        "key": "",
        "value": "6"
      },
      {
        "title": "上周",
        "key": "",
        "value": "5"
      },
      {
        "title": "本月",
        "key": "",
        "value": "2"
      },
      {
        "title": "上月",
        "key": "TASK",
        "value": "7"
      },
      {
        "title": "下月",
        "key": "TASK",
        "value": "8"
      },
    ];

    selectTimeTypeList = ["今日"];

    taskTypeDataList = [
      {
        "title": "全部",
        "key": "",
        "value": "",
        "isSelect":"0"
      },
      {
        "title": "工单服务",
        "key": "WORK_ORDER",
        "value": "",
      },
      {
        "title": "巡查任务",
        "key": "TASK",
        "value": "POLICED_POINT",
      },
    ];

    for (var params in taskTypeDataList) {
      taskTypeList.add(params['title']);
      taskTypeKeyList.add(params['key']);
      taskTypeValueList.add(params['value']);
    }
  }

  /// 初始化todoController
  initToDoController() {
    todoControllerList = [];
    todoControllerTagList =[];
    tabBarViewList= [];
    for (int i = 0; i < tabTitleList.length; i++) {
      String controllerTag = "SCWorkBenchToDoController_$i";
      SCWorkBenchToDoController todoController =
          Get.put(SCWorkBenchToDoController(), tag: controllerTag);
      todoController.key = todoKeyList[i];
      Widget view = GetBuilder<SCWorkBenchToDoController>(
          tag: controllerTag,
          init: todoController,
          builder: (value) {
            return SCWorkBenchToDoListView(
              data: todoController.data,
              refreshController: todoController.refreshController,
              onRefreshAction: () {
                loadData();
                todoController.getData(isMore: false);
              },
              loadMoreAction: () {
                todoController.getData(isMore: true);
              },
            );
          });
      todoControllerList.add(todoController);
      todoControllerTagList.add(controllerTag);
      tabBarViewList.add(view);
      todoController.getData(isMore: false);
    }
  }

  /// 获取本地存储的tab
  getLocalCacheTab() {
    if (SCSpUtil.containsKey(SCKey.kWorkBenchTabKey)) {
      var data = SCSpUtil.getMap(SCKey.kWorkBenchTabKey);
      initTabData(data['data']);
    } else {
      List list = getAllTabData();
      if (list.length > 2) {
        var data = list.sublist(0, 2);
        initTabData(data);
        SCSpUtil.setMap(SCKey.kWorkBenchTabKey, {'data': data}).then((value) {

        });
      }
    }
  }

  /// 更新本地存储的tab
  updateLocalCacheTab({required List list, Function? completeHandler}) {
    List newMyTaskList = [];

    for (var title in list) {
      bool contains = false;
      var params = {};
      for (var map in getAllTabData()) {
        String subTitle = map['title'];
        if (title == subTitle) {
          params = map;
          contains = true;
        }
      }

      if (contains) {
        newMyTaskList.add(params);
      }
    }

    if (newMyTaskList.isNotEmpty) {
      SCSpUtil.setMap(SCKey.kWorkBenchTabKey, {'data': newMyTaskList}).then((value) {
        initData();
        completeHandler?.call();
      });
    }
  }

  /// 更新选中的我的任务
  int updateMyTaskSelectList(List list) {
    myTaskSelectList = list;
    int index = -1;
    String value = list.first;
    for (int i = 0; i < tabTitleList.length; i++) {
      String subValue = tabTitleList[i];
      if (value == subValue) {
        index = i;
        break;
      }
    }
    update();
    return index;
  }

  /// 更新选中的任务类型
  updateTaskTypeSelectList(List list) {
    taskTypeSelectList = list;
    String value = list.first;
    for (int i = 0; i < taskTypeDataList.length;i++) {
      var params = taskTypeDataList[i];
      String subValue = params['title'];
      if (value == subValue) {
        for (SCWorkBenchToDoController toDoController in todoControllerList) {
          toDoController.subKey = params['key'];
          toDoController.subValue = params['value'];
          toDoController.getData(isMore: false);
        }
        break;
      }
    }
    update();
  }

  /// 更新选中的时间类型
  updateTimeTypeSelectList(List list){
    selectTimeTypeList = list;
    update();
  }

  /// 更新当前工单index
  updateCurrentWorkOrderIndex(int value) {
    currentWorkOrderIndex = value;
    myTaskSelectList = [tabTitleList[value]];
  }

  /// 更新头部数量数据
  updateNumData() {
    numDataList = [
      {
        'number': orderNum,
        'description': '抢单',
      },
      {
        'number': workOrderNum,
        'description': '工单',
      },
      // {
      //   'number': taskNum,
      //   'description': '今日任务',
      // },
      // {
      //   'number': collectionRate,
      //   'description': '收缴率',
      //   'richText': '%'
      // },
      // {
      //   'number': serviceNum,
      //   'description': '今日服务业主',
      // }
    ];
    update();
  }

  /// 加载数据
  loadData({bool? loadAllToDo}) {
    getDefaultConfig().then((value) {
      if (value == true) {
        getUserInfo().then((subValue) {
          if (subValue == true) {
            getWorkOrderNumber();
            getTaskCount();
            if (loadAllToDo == true) {
              getToDoData();
            }
          }
        });
      }
    });
  }

  /// 待办
  getToDoData() {
    for (int i = 0; i < todoControllerList.length; i++) {
      SCWorkBenchToDoController toDoController = todoControllerList[i];
      toDoController.getData(isMore: false);
    }
  }

  /// 获取用户信息
  Future getUserInfo() {
    if (SCScaffoldManager.instance.isLogin) {
      String token = SCScaffoldManager.instance.user.token ?? '';
      var params = {'id': SCScaffoldManager.instance.user.id};
      return SCHttpManager.instance.get(
          url: SCUrl.kUserInfoUrl,
          params: params,
          success: (value) {
            value['token'] = token;
            SCUserModel userModel = SCUserModel.fromJson(value);
            SCScaffoldManager.instance.user = userModel;
            Get.forceAppUpdate();
          });
    } else {
      return Future(() => false);
    }
  }

  /// 获取默认配置
  Future getDefaultConfig() {
    if (SCScaffoldManager.instance.isLogin) {
      return SCHttpManager.instance.get(
          url: SCUrl.kUserDefaultConfigUrl,
          params: null,
          success: (value) {
            if (value is Map) {
              SCDefaultConfigModel model = SCDefaultConfigModel.fromJson(value);
              SCScaffoldManager.instance.defaultConfigModel = model;
              SCChangeSpaceController controller =
                  Get.find<SCChangeSpaceController>();
              controller.initBase(success: (String spaceNameValue) {
                spaceName = spaceNameValue;
                update();
              });
            } else {
              SCSpaceModel model = SCSpaceModel.fromJson({
                "id": "",
                "pid": "",
                "flag": 0,
                "type": 1,
                "floor": "",
                "title": SCScaffoldManager.instance.user.tenantName,
                "value": "",
                "isLeaf": false,
                "unable": 0,
                "iconUrl": "",
                "children": [],
                "communityId": ""
              });
              var params = {
                "id": SCScaffoldManager.instance.defaultConfigModel?.id,
                "userId": SCScaffoldManager.instance.user.id,
                "tenantId": SCScaffoldManager.instance.user.tenantId,
                "type": 1,
                "jsonValue": jsonEncode([model])
              };
              SCDefaultConfigModel defModel =
                  SCDefaultConfigModel.fromJson(params);
              SCScaffoldManager.instance.defaultConfigModel = defModel;
              SCChangeSpaceController controller =
                  Get.find<SCChangeSpaceController>();
              controller.initBase(success: (String spaceNameValue) {
                spaceName = spaceNameValue;
                update();
              });
            }
          });
    } else {
      return Future(() => false);
    }
  }

  /// 获取工单数量
  getWorkOrderNumber() {
    SCHttpManager.instance.get(
        url: SCUrl.kWorkOrderNumberUrl,
        params: null,
        success: (value) {
          // processOrder = value['processOrder'] ?? 0;
          // newOrder = value['newOrder'] ?? 0;
          updateNumData();
        });
  }

  /// 获取卡片数量
  getTaskCount() {
    String timeTitle = selectTimeTypeList.first;
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
    var params = {
      "unitCode": unitCode,
    };
    //print("1111111${unitCode}");
    SCHttpManager.instance.post(url: SCUrl.kWorkBenchTaskCountUrl, params: params, success: (value) {
      orderNum = value['hallCount'] ?? 0;
      workOrderNum = value['workOrderCount'] ?? 0;
      // taskNum = value['todayTaskCount'] ?? 0;
      // collectionRate = (value['collectionRate'] ?? 0) * 100;
      // serviceNum = value['todayServiceBusinessCount'] ?? 0;
      update();
    }, failure: (value) {

    });
  }

  /// 提交入库
  materialEntrySubmit(
      {required String id, Function(bool success)? completeHandler}) async {
    var params = {
      "wareHouseInId": id,
    };
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        isQuery: true,
        url: SCUrl.kSubmitMaterialUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          completeHandler?.call(true);
        },
        failure: (value) {
          completeHandler?.call(false);
          SCToast.showTip(value['message']);
        });
  }

  /// 提交出库
  materialOutSubmit(
      {required String id, Function(bool success)? completeHandler}) async {
    var params = {
      "wareHouseOutId": id,
    };
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kSubmitOutboundUrl,
        isQuery: true,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          completeHandler?.call(true);
        },
        failure: (value) {
          completeHandler?.call(false);
          SCToast.showTip(value['message']);
        });
  }

  /// 提交报损
  materialFrmLossSubmit(
      {required String id, Function(bool success)? completeHandler}) async {
    var params = {
      "wareHouseReportId": id,
    };
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kSubmitFrmLossUrl,
        isQuery: true,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          completeHandler?.call(true);
        },
        failure: (value) {
          completeHandler?.call(false);
          SCToast.showTip(value['message']);
        });
  }

  /// 提交调拨
  materialTransferSubmit(
      {required String id, Function(bool success)? completeHandler}) async {
    var params = {
      "wareHouseChangeId": id,
    };
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kSubmitTransferUrl,
        isQuery: true,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          completeHandler?.call(true);
        },
        failure: (value) {
          completeHandler?.call(false);
          SCToast.showTip(value['message']);
        });
  }

  /// 定时器
  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      for (int i = 0; i < todoControllerTagList.length; i++) {
        String controllerTag = todoControllerTagList[i];
        SCWorkBenchToDoController todoController =
        Get.find(tag: controllerTag);
        todoController.update();
      }
    });
  }

  /// 实地核验订单点击
  Future verificationOrderDetailTap(String id) {
    return SCHttpManager.instance.post(
        url: SCUrl.kDealActualVerifyUrl,
        params: {"id": id},
        success: (value) {},
        failure: (value) {});
  }

  /// 获取定位
  location() async {
    bool isShowAlert = SCSpUtil.getBool(SCKey.kIsShowSetNotificationAlert);
    PermissionStatus permissionStatus = await SCPermissionUtils.notification();
    if (permissionStatus != PermissionStatus.granted && !isShowAlert) {
      SCPermissionUtils.notificationAlert(completionHandler: (success) {
        SCPermissionUtils.startLocationWithPrivacyAlert(
            completionHandler: (dynamic result, SCLocationModel? model) {
              int status = result['status'];
              if (status == 1) {
                double longitude = result['longitude'];
                double latitude = result['latitude'];
                SCScaffoldManager.instance.longitude = longitude;
                SCScaffoldManager.instance.latitude = latitude;
              }
            });
      });
    } else {
      SCPermissionUtils.startLocationWithPrivacyAlert(
          completionHandler: (dynamic result, SCLocationModel? model) {
            int status = result['status'];
            if (status == 1) {
              double longitude = result['longitude'] ?? 0.0;
              double latitude = result['latitude'] ?? 0.0;
              SCScaffoldManager.instance.longitude = longitude;
              SCScaffoldManager.instance.latitude = latitude;
            }
          });
    }
  }

  /// 初始化筛选条件
  initFilterData() {
    myTaskSelectList = [tabTitleList.first];
    taskTypeSelectList = [taskTypeList.first];
    for (SCWorkBenchToDoController toDoController in todoControllerList) {
      toDoController.subKey = "";
      toDoController.subValue = "";
      toDoController.getData(isMore: false);
    }
  }

  /// 获取未读消息数量
  loadUnreadMessageCount() {
    SCHttpManager.instance.get(
        url: SCUrl.kMessageCountUrl,
        params: {'checked': false},
        success: (value) {
          if (value is int) {
            SCScaffoldManager.instance.unreadMessageCount = value;
            unreadMegNum.value = value;
            var params = {"key" : SCKey.kReloadUnreadMessageCount};
            SCScaffoldManager.instance.eventBus.fire(params);
          }
        },
        failure: (value) {
        });
  }

  /// 所有的tab数据
  List getAllTabData() {
    return [
      {
        "title": "任务大厅",
        "key": "hallUserIds",
      },
      {
        "title": "我待办的",
        "key": "handleUserIds",
      },
      {
        "title": "我创建的",
        "key": "creator",
      },
      {
        "title": "我经办的",
        "key": "handledUserIds",
      },
      {
        "title": "我关注的",
        "key": "followUserIds",
      },
    ];
  }

  /// 获取所有的tabTitle数据
  List getAllTabTitleData() {
    List list = [];
    for (var map in getAllTabData()) {
      list.add(map['title']);
    }
    return list;
  }

  @override
  onClose() {
    super.onClose();
    if (timer.isActive) {
      timer.cancel();
    }
  }
}
