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

import '../../../../Constants/sc_asset.dart';
import '../../../../Constants/sc_key.dart';
import '../../../../Utils/Location/sc_location_model.dart';
import '../../../ApplicationModule/MaterialEntry/Model/sc_material_entry_model.dart';
import '../../../../Utils/sc_sp_utils.dart';
import '../Model/sc_work_order_model.dart';

/// 工作台Controller

class SCWorkBenchController extends GetxController {
  String pageName = '';

  String tag = '';

  /// 待处理工单数据
  List waitDataList = [];

  /// 待处理pageNum
  int waitPageNum = 1;

  /// 处理中pageNum
  int processingPageNum = 1;

  /// 我执行的pageNum
  int iExecutedPageNum = 1;

  /// 我创建的
  int iCreatedPageNum = 1;

  /// 我经办的
  int iDoPageNum = 1;

  /// 我关注的
  int iLikedPageNum = 1;

  /// 抢单大厅
  int grabHallPageNum = 1;

  /// 处理中工单 数据
  List processingDataList = [];

  /// 抢单大厅数量
  int orderNum = 10;

  /// 今日任务数量
  int taskNum = 20;

  /// 收缴率
  num collectionRate = 88.8;

  /// 今日服务业主数量
  int serviceNum = 2;

  List numDataList = [];

  /// 空间名称
  String spaceName = '';

  /// 定时器
  late Timer timer;

  /// 待处理controller
  late SCWorkBenchListViewController waitController;

  /// 处理中controller
  late SCWorkBenchListViewController processingController;

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

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  onInit() {
    super.onInit();
    initTabData();
    // taskTypeList = ['全部', '工单服务', '审批中心', '巡查任务', '收费账单'];
    initToDoController();
    initFilterData();
    location();
    loadData();
  }

  /// 初始化tabData
  initTabData() {
    tabDataList = [
      {
        "title": "我执行的",
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
      {
        "title": "任务大厅",
        "key": "hallUserIds",
      },
    ];
    for (var params in tabDataList) {
      tabTitleList.add(params['title']);
      todoKeyList.add(params['key']);
    }

    taskTypeDataList = [
      {
        "title": "全部",
        "key": "",
        "value": ""
      },
      {
        "title": "工单服务",
        "key": "WORK_ORDER",
        "value": ""
      },
      {
        "title": "巡查任务",
        "key": "TASK",
        "value": "2"
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
        }
        break;
      }
    }
    update();
  }

  /// 更新当前工单index
  updateCurrentWorkOrderIndex(int value) {
    currentWorkOrderIndex = value;
    if (value == 0) {
      waitPageNum = 1;
    } else {
      processingPageNum = 1;
    }
  }

  /// 更新当前板块index
  updatePlateIndex(int value) {
    currentPlateIndex = value;
    if (currentWorkOrderIndex == 0) {
      waitPageNum = 1;
    } else {
      processingPageNum = 1;
    }
    update();
    if (currentPlateIndex == 0) {
      workOrderAPI();
    } else if (currentPlateIndex == 1) {
      realVerificationAPI();
    } else if (currentPlateIndex == 2) {
      orderFormAPI();
    } else if (currentPlateIndex == 3) {
      // 物资入库
      if (currentWorkOrderIndex == 0) {
        materialEntryAPI();
      }
    } else if (currentPlateIndex == 4) {
      // 物资出库
      if (currentWorkOrderIndex == 0) {
        materialOutAPI();
      }
    } else if (currentPlateIndex == 5) {
      // 物资报损
      if (currentWorkOrderIndex == 0) {
        materialFrmLossAPI();
      }
    } else if (currentPlateIndex == 6) {
      // 物资调拨
      if (currentWorkOrderIndex == 0) {
        materialTransferAPI();
      }
    }

    // getTaskData(isMore: false);
  }

  /// 加载更多
  Future loadMore() async {
    if (currentWorkOrderIndex == 0) {
      /// 待处理
      if (currentPlateIndex == 0) {
        // 工单处理
        return getWorkOrderList(isMore: true);
      } else if (currentPlateIndex == 1) {
        // 实地核验
        return getRealVerificationWaitList(isMore: true);
      } else if (currentPlateIndex == 2) {
        // 订单处理
        return getOrderFormWaitList(isMore: true);
      } else if (currentPlateIndex == 3) {
        // 物资入库
        return getMaterialEntryWaitList(isMore: true);
      } else if (currentPlateIndex == 4) {
        // 物资出库
        return getMaterialOutWaitList(isMore: true);
      } else if (currentPlateIndex == 5) {
        // 物资报损
        return getMaterialFrmLossWaitList(isMore: true);
      } else if (currentPlateIndex == 6) {
        // 物资调拨
        return getMaterialTransferWaitList(isMore: true);
      }
    } else {
      /// 处理中
      if (currentPlateIndex == 0) {
        // 工单处理
        return getProcessingWorkOrderList(isMore: true);
      } else if (currentPlateIndex == 1) {
        // 实地核验
        return getRealVerificationProcessingList(isMore: true);
      } else if (currentPlateIndex == 2) {
        // 订单处理
        return getOrderFormProcessingList(isMore: true);
      }
    }
  }

  /// 调用工单处理接口
  workOrderAPI({bool? isMore}) {
    getWorkOrderList(isMore: isMore);
    getProcessingWorkOrderList(isMore: isMore);
  }

  /// 调用实地核验接口
  realVerificationAPI({bool? isMore}) {
    getRealVerificationWaitList(isMore: isMore);
    getRealVerificationProcessingList(isMore: isMore);
  }

  /// 调用订单处理接口
  orderFormAPI({bool? isMore}) {
    getOrderFormWaitList(isMore: isMore);
    getOrderFormProcessingList(isMore: isMore);
  }

  /// 调用物资入库接口
  materialEntryAPI({bool? isMore}) {
    getMaterialEntryWaitList(isMore: isMore);
  }

  /// 调用物资出库接口
  materialOutAPI({bool? isMore}) {
    getMaterialOutWaitList(isMore: isMore);
  }

  /// 调用物资报损接口
  materialFrmLossAPI({bool? isMore}) {
    getMaterialFrmLossWaitList(isMore: isMore);
  }

  /// 调用物资调拨接口
  materialTransferAPI({bool? isMore}) {
    getMaterialTransferWaitList(isMore: isMore);
  }

  /// 更新头部数量数据
  updateNumData() {
    numDataList = [
      {
        'number': orderNum,
        'description': '抢单大厅',
      },
      {
        'number': taskNum,
        'description': '今日任务',
      },
      {
        'number': collectionRate,
        'description': '收缴率',
      },
      {
        'number': serviceNum,
        'description': '今日服务业主',
      }
    ];
    update();
  }

  /// 加载数据
  loadData() {
    getDefaultConfig().then((value) {
      refreshController.refreshCompleted();
      if (value == true) {
        getUserInfo().then((subValue) {
          if (subValue == true) {
            getWorkOrderNumber();
            waitPageNum = 1;
            processingPageNum = 1;
            updatePlateIndex(currentPlateIndex);
            getToDoData();
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

  /// 工单处理-待处理数据
  Future getWorkOrderList({bool? isMore}) {
    bool isLoadMore = isMore ?? false;
    if (isLoadMore == true) {
      waitPageNum++;
    } else {
      SCLoadingUtils.show();
    }
    var params = {
      "conditions": {
        "fields": [
          {"map": {}, "method": 1, "name": "wo.status", "value": 2},
          {
            "map": {},
            "method": 1,
            "name": "wo.process_user_id",
            "value": SCScaffoldManager.instance.user.id
          }
        ]
      },
      "count": true,
      "last": true,
      "orderBy": [
        {"asc": false, "field": "wo.create_time"}
      ],
      "pageNum": waitPageNum,
      "pageSize": 10
    };
    return SCHttpManager.instance.post(
        url: SCUrl.kWorkOrderListUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          if (value is Map) {
            List list = value['records'];
            if (isLoadMore == true) {
              waitDataList.addAll(List<SCWorkOrderModel>.from(
                  list.map((e) => SCWorkOrderModel.fromJson(e)).toList()));
            } else {
              waitDataList = List<SCWorkOrderModel>.from(
                  list.map((e) => SCWorkOrderModel.fromJson(e)).toList());
            }
          } else {
            if (isLoadMore == false) {
              waitDataList = [];
            }
          }
          update();
          waitController.dataList = waitDataList;
          waitController.update();
        },
        failure: (value) {
          SCLoadingUtils.hide();
          if (currentPlateIndex == 0 && isLoadMore == true) {
            waitPageNum--;
          }
        });
  }

  /// 工单处理-处理中数据
  Future getProcessingWorkOrderList({bool? isMore}) {
    bool isLoadMore = isMore ?? false;
    if (isLoadMore == true) {
      processingPageNum++;
    } else {
      SCLoadingUtils.show();
    }
    var params = {
      "conditions": {
        "fields": [
          {"map": {}, "method": 1, "name": "wo.status", "value": 5},
          {
            "map": {},
            "method": 1,
            "name": "wo.process_user_id",
            "value": SCScaffoldManager.instance.user.id
          }
        ]
      },
      "count": true,
      "last": true,
      "orderBy": [
        {"asc": false, "field": "wo.create_time"}
      ],
      "pageNum": processingPageNum,
      "pageSize": 10
    };
    return SCHttpManager.instance.post(
        url: SCUrl.kWorkOrderListUrl,
        params: params,
        success: (value) {
          log('aaa===$value');
          SCLoadingUtils.hide();
          if (value is Map) {
            List list = value['records'];
            if (isLoadMore == true) {
              processingDataList.addAll(List<SCWorkOrderModel>.from(
                  list.map((e) => SCWorkOrderModel.fromJson(e)).toList()));
            } else {
              processingDataList = List<SCWorkOrderModel>.from(
                  list.map((e) => SCWorkOrderModel.fromJson(e)).toList());
            }
          } else {
            if (isLoadMore == false) {
              processingDataList = [];
            }
          }
          update();
          processingController.dataList = processingDataList;
          processingController.update();
        },
        failure: (value) {
          SCLoadingUtils.hide();
          if (currentPlateIndex == 0 && isLoadMore == true) {
            processingPageNum--;
          }
        });
  }

  /// 实地核验-待处理数据
  Future getRealVerificationWaitList({bool? isMore}) {
    bool isLoadMore = isMore ?? false;
    if (isLoadMore == true) {
      waitPageNum++;
    } else {
      SCLoadingUtils.show();
    }
    var params = {
      "conditions": {
        "fields": [
          {"map": {}, "method": 1, "name": "dealStatus", "value": 0}
        ],
        "specialMap": {}
      },
      "count": true,
      "last": true,
      "orderBy": [
        {"asc": true, "field": "applyTime"}
      ],
      "pageNum": waitPageNum,
      "pageSize": 10
    };
    return SCHttpManager.instance.post(
        url: SCUrl.kActualVerifyUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          if (value is Map) {
            List list = value['records'];
            if (isLoadMore == true) {
              waitDataList.addAll(List<SCVerificationOrderModel>.from(list
                  .map((e) => SCVerificationOrderModel.fromJson(e))
                  .toList()));
            } else {
              waitDataList = List<SCVerificationOrderModel>.from(list
                  .map((e) => SCVerificationOrderModel.fromJson(e))
                  .toList());
            }
          } else {
            if (isLoadMore == false) {
              waitDataList = [];
            }
          }
          update();
          waitController.dataList = waitDataList;
          waitController.update();
        },
        failure: (value) {
          SCLoadingUtils.hide();
          if (currentPlateIndex == 1 && isLoadMore == true) {
            waitPageNum--;
          }
        });
  }

  /// 实地核验-处理中数据
  Future getRealVerificationProcessingList({bool? isMore}) {
    bool isLoadMore = isMore ?? false;
    if (isLoadMore == true) {
      processingPageNum++;
    } else {
      SCLoadingUtils.show();
    }
    var params = {
      "conditions": {
        "fields": [
          {"map": {}, "method": 1, "name": "dealStatus", "value": 1}
        ],
        "specialMap": {}
      },
      "count": true,
      "last": true,
      "orderBy": [
        {"asc": true, "field": "applyTime"}
      ],
      "pageNum": processingPageNum,
      "pageSize": 10
    };
    return SCHttpManager.instance.post(
        url: SCUrl.kActualVerifyUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          if (value is Map) {
            List list = value['records'];
            if (isLoadMore == true) {
              processingDataList.addAll(List<SCVerificationOrderModel>.from(list
                  .map((e) => SCVerificationOrderModel.fromJson(e))
                  .toList()));
            } else {
              processingDataList = List<SCVerificationOrderModel>.from(list
                  .map((e) => SCVerificationOrderModel.fromJson(e))
                  .toList());
            }
          } else {
            if (isLoadMore == false) {
              processingDataList = [];
            }
          }
          update();
          processingController.dataList = processingDataList;
          processingController.update();
        },
        failure: (value) {
          SCLoadingUtils.hide();
          if (currentPlateIndex == 1 && isLoadMore == true) {
            processingPageNum--;
          }
        });
  }

  /// 订单处理-待处理数据
  Future getOrderFormWaitList({bool? isMore}) {
    bool isLoadMore = isMore ?? false;
    if (isLoadMore == true) {
      waitPageNum++;
    } else {
      SCLoadingUtils.show();
    }
    var params = {
      "conditions": {
        "fields": [
          {"name": "state", "value": 2}
        ]
      },
      "pageNum": waitPageNum,
      "pageSize": 10
    };
    return SCHttpManager.instance.post(
        url: SCUrl.kOrderFormUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          if (value is Map) {
            List list = value['records'];
            if (isLoadMore == true) {
              waitDataList.addAll(List<SCHotelOrderModel>.from(
                  list.map((e) => SCHotelOrderModel.fromJson(e)).toList()));
            } else {
              waitDataList = List<SCHotelOrderModel>.from(
                  list.map((e) => SCHotelOrderModel.fromJson(e)).toList());
            }
          } else {
            if (isLoadMore == false) {
              waitDataList = [];
            }
          }
          update();
          waitController.dataList = waitDataList;
          waitController.update();
        },
        failure: (value) {
          SCLoadingUtils.hide();
          if (currentPlateIndex == 2 && isLoadMore == true) {
            waitPageNum--;
          }
        });
  }

  /// 订单处理-处理中数据
  Future getOrderFormProcessingList({bool? isMore}) {
    bool isLoadMore = isMore ?? false;
    if (isLoadMore == true) {
      processingPageNum++;
    } else {
      SCLoadingUtils.show();
    }
    var params = {
      "conditions": {
        "fields": [
          {"name": "state", "value": 3}
        ]
      },
      "pageNum": processingPageNum,
      "pageSize": 10
    };
    return SCHttpManager.instance.post(
        url: SCUrl.kOrderFormUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          if (value is Map) {
            List list = value['records'];
            if (isLoadMore == true) {
              processingDataList.addAll(List<SCHotelOrderModel>.from(
                  list.map((e) => SCHotelOrderModel.fromJson(e)).toList()));
            } else {
              processingDataList = List<SCHotelOrderModel>.from(
                  list.map((e) => SCHotelOrderModel.fromJson(e)).toList());
            }
          } else {
            if (isLoadMore == false) {
              processingDataList = [];
            }
          }
          update();
          processingController.dataList = processingDataList;
          processingController.update();
        },
        failure: (value) {
          SCLoadingUtils.hide();
          if (currentPlateIndex == 2 && isLoadMore == true) {
            processingPageNum--;
          }
        });
  }

  /// 物资入库-待处理数据
  Future getMaterialEntryWaitList({bool? isMore}) {
    bool isLoadMore = isMore ?? false;
    if (isLoadMore == true) {
      waitPageNum++;
    } else {
      SCLoadingUtils.show();
    }
    List fields = [];
    var dic = {"map": {}, "method": 1, "name": "status", "value": 1};
    fields.add(dic);
    var params = {
      "conditions": {"fields": fields, "specialMap": {}},
      "count": false,
      "last": false,
      "orderBy": [
        {"asc": false, "field": "gmtModify"}
      ],
      "pageNum": waitPageNum,
      "pageSize": 20
    };
    return SCHttpManager.instance.post(
        url: SCUrl.kMaterialEntryListUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          if (value is Map) {
            List list = value['records'];
            if (isLoadMore == true) {
              waitController.materialEntryList.addAll(
                  List<SCMaterialEntryModel>.from(list
                      .map((e) => SCMaterialEntryModel.fromJson(e))
                      .toList()));
            } else {
              waitController.materialEntryList =
                  List<SCMaterialEntryModel>.from(list
                      .map((e) => SCMaterialEntryModel.fromJson(e))
                      .toList());
            }
          } else {
            if (isLoadMore == false) {
              waitController.materialEntryList = [];
            }
          }
          if (isLoadMore == true) {
            waitController.isEntryListLast = value['last'] ?? false;
          }
          update();
          waitController.update();
        },
        failure: (value) {
          SCLoadingUtils.hide();
          if (currentPlateIndex >= 2 && isLoadMore == true) {
            waitPageNum--;
          }
        });
  }

  /// 物资出库-待处理数据
  Future getMaterialOutWaitList({bool? isMore}) {
    bool isLoadMore = isMore ?? false;
    if (isLoadMore == true) {
      waitPageNum++;
    } else {
      SCLoadingUtils.show();
    }
    List fields = [];
    var dic = {"map": {}, "method": 1, "name": "status", "value": 1};
    fields.add(dic);
    var params = {
      "conditions": {"fields": fields, "specialMap": {}},
      "count": false,
      "last": false,
      "orderBy": [
        {"asc": false, "field": "gmtModify"}
      ],
      "pageNum": waitPageNum,
      "pageSize": 20
    };
    return SCHttpManager.instance.post(
        url: SCUrl.kMaterialOutboundListUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          if (value is Map) {
            List list = value['records'];
            if (isLoadMore == true) {
              waitController.materialOutList.addAll(
                  List<SCMaterialEntryModel>.from(list
                      .map((e) => SCMaterialEntryModel.fromJson(e))
                      .toList()));
            } else {
              waitController.materialOutList = List<SCMaterialEntryModel>.from(
                  list.map((e) => SCMaterialEntryModel.fromJson(e)).toList());
            }
          } else {
            if (isLoadMore == false) {
              waitController.materialOutList = [];
            }
          }
          update();
          waitController.update();
        },
        failure: (value) {
          SCLoadingUtils.hide();
          if (currentPlateIndex >= 2 && isLoadMore == true) {
            waitPageNum--;
          }
        });
  }

  /// 物资报损-待处理数据
  Future getMaterialFrmLossWaitList({bool? isMore}) {
    bool isLoadMore = isMore ?? false;
    if (isLoadMore == true) {
      waitPageNum++;
    } else {
      SCLoadingUtils.show();
    }
    List fields = [];
    var dic = {"map": {}, "method": 1, "name": "status", "value": 1};
    fields.add(dic);
    var params = {
      "conditions": {"fields": fields, "specialMap": {}},
      "count": false,
      "last": false,
      "orderBy": [
        {"asc": false, "field": "gmtModify"}
      ],
      "pageNum": waitPageNum,
      "pageSize": 20
    };
    return SCHttpManager.instance.post(
        url: SCUrl.kMaterialFrmLossListUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          if (value is Map) {
            List list = value['records'];
            if (isLoadMore == true) {
              waitController.materialReportList.addAll(
                  List<SCMaterialEntryModel>.from(list
                      .map((e) => SCMaterialEntryModel.fromJson(e))
                      .toList()));
            } else {
              waitController.materialReportList =
                  List<SCMaterialEntryModel>.from(list
                      .map((e) => SCMaterialEntryModel.fromJson(e))
                      .toList());
            }
          } else {
            if (isLoadMore == false) {
              waitController.materialReportList = [];
            }
          }
          update();
          waitController.update();
        },
        failure: (value) {
          SCLoadingUtils.hide();
          if (currentPlateIndex >= 2 && isLoadMore == true) {
            waitPageNum--;
          }
        });
  }

  /// 物资调拨-待处理数据
  Future getMaterialTransferWaitList({bool? isMore}) {
    bool isLoadMore = isMore ?? false;
    if (isLoadMore == true) {
      waitPageNum++;
    } else {
      SCLoadingUtils.show();
    }
    List fields = [];
    var dic = {"map": {}, "method": 1, "name": "status", "value": 1};
    fields.add(dic);
    var params = {
      "conditions": {"fields": fields, "specialMap": {}},
      "count": false,
      "last": false,
      "orderBy": [
        {"asc": false, "field": "gmtModify"}
      ],
      "pageNum": waitPageNum,
      "pageSize": 20
    };
    return SCHttpManager.instance.post(
        url: SCUrl.kMaterialTransferListUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          if (value is Map) {
            List list = value['records'];
            if (isLoadMore == true) {
              waitController.materialTransferList.addAll(
                  List<SCMaterialEntryModel>.from(list
                      .map((e) => SCMaterialEntryModel.fromJson(e))
                      .toList()));
            } else {
              waitController.materialTransferList =
                  List<SCMaterialEntryModel>.from(list
                      .map((e) => SCMaterialEntryModel.fromJson(e))
                      .toList());
            }
          } else {
            if (isLoadMore == false) {
              waitController.materialTransferList = [];
            }
          }
          update();
          waitController.update();
        },
        failure: (value) {
          SCLoadingUtils.hide();
          if (currentPlateIndex >= 2 && isLoadMore == true) {
            waitPageNum--;
          }
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
      if (currentPlateIndex == 0) {
        for (int i = 0; i < waitDataList.length; i++) {
          if (waitDataList[i] is SCWorkOrderModel) {
            SCWorkOrderModel model = waitDataList[i];
            int subTime = model.remainingTime ?? 0;
            if (subTime > 0) {
              model.remainingTime = subTime - 1;
            } else if (subTime == 0) {
              model.remainingTime = 0;
            } else {}
          }
        }

        for (int i = 0; i < processingDataList.length; i++) {
          if (processingDataList[i] is SCWorkOrderModel) {
            SCWorkOrderModel model = processingDataList[i];
            int subTime = model.remainingTime ?? 0;
            if (subTime > 0) {
              model.remainingTime = subTime - 1;
            } else if (subTime == 0) {
              model.remainingTime = 0;
            } else {}
          }
        }

        waitController.dataList = waitDataList;
        waitController.update();
        processingController.dataList = processingDataList;
        processingController.update();
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
    }
  }

  @override
  onClose() {
    super.onClose();
    if (timer.isActive) {
      timer.cancel();
    }
  }
}
