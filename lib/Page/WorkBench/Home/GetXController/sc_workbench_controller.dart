import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Network/sc_http_manager.dart';
import 'package:smartcommunity/Network/sc_url.dart';
import 'package:smartcommunity/Page/Login/Home/Model/sc_user_model.dart';
import 'package:smartcommunity/Page/WorkBench/Home/GetXController/sc_changespace_controller.dart';
import 'package:smartcommunity/Page/WorkBench/Home/GetXController/sc_wrokbench_listview_controller.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Model/sc_hotel_order_model.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Model/sc_default_config_model.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Model/sc_space_model.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Model/sc_verification_order_model.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import 'package:smartcommunity/Utils/Location/sc_location_utils.dart';

import '../../../../Constants/sc_asset.dart';
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

  /// 处理中工单 数据
  List processingDataList = [];

  /// 进行中数量
  int processOrder = 0;

  /// 新增数量
  int newOrder = 0;

  /// 我的关注数量
  int myAttention = 0;

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

  /// 板块数据源
  List plateList = [
    {"type" : 0, "title" : "工单处理"},
    {"type" : 1, "title" : "实地核验"},
    {"type" : 2, "title" : "订单处理"},
  ];

  @override
  onInit() {
    super.onInit();
    loadData();
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
    update();
    if (currentPlateIndex == 0) {
      workOrderAPI();
    } else if (currentPlateIndex == 1) {
      realVerificationAPI();
    } else if (currentPlateIndex == 2) {
      orderFormAPI();
    }
  }

  /// 加载更多
  Future loadMore() async{
    if (currentWorkOrderIndex == 0) {/// 待处理
      if (currentPlateIndex == 0) {
        return getWorkOrderList(isMore: true);
      } else if (currentPlateIndex == 1) {
        return getRealVerificationWaitList(isMore: true);
      } else {
        return getOrderFormWaitList(isMore: true);
      }
    } else {/// 处理中
      if (currentPlateIndex == 0) {
        return getProcessingWorkOrderList(isMore: true);
      } else if (currentPlateIndex == 1) {
        return getRealVerificationProcessingList(isMore: true);
      } else{
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

  /// 更新头部数量数据
  updateNumData() {
    numDataList = [
      {
        'number': newOrder,
        'description': '今日新增',
        'iconUrl': SCAsset.iconTodayAdd
      },
      {
        'number': processOrder,
        'description': '进行中',
        'iconUrl': SCAsset.iconDoing
      },
      {
        'number': myAttention,
        'description': '我的关注',
        'iconUrl': SCAsset.iconLike
      }
    ];
    update();
  }

  /// 加载数据
  loadData() {
    location();
    getDefaultConfig().then((value) {
      if (value == true) {
        getUserInfo().then((subValue) {
          if (subValue == true) {
            getWorkOrderNumber();
            waitPageNum = 1;
            processingPageNum = 1;
            updatePlateIndex(currentPlateIndex);
          }
        });
      }
    });
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
              controller.initBase(
                  success: (String spaceNameValue){
                    spaceName = spaceNameValue;
                    update();
                  }
              );
            } else {
              SCSpaceModel model = SCSpaceModel.fromJson(
                  {
                    "id" : "",
                    "pid" : "",
                    "flag" : 0,
                    "type" : 1,
                    "floor" : "",
                    "title" : SCScaffoldManager.instance.user.tenantName,
                    "value" : "",
                    "isLeaf" : false,
                    "unable" : 0,
                    "iconUrl" : "",
                    "children" : [],
                    "communityId" : ""
                  });
              var params = {
                "id" : SCScaffoldManager.instance.defaultConfigModel?.id ,
                "userId" : SCScaffoldManager.instance.user.id,
                "tenantId" : SCScaffoldManager.instance.user.tenantId,
                "type" : 1,
                "jsonValue" : jsonEncode([model])
              };
              SCDefaultConfigModel defModel = SCDefaultConfigModel.fromJson(params);
              SCScaffoldManager.instance.defaultConfigModel = defModel;
              SCChangeSpaceController controller =
              Get.find<SCChangeSpaceController>();
              controller.initBase(
                  success: (String spaceNameValue){
                    spaceName = spaceNameValue;
                    update();
                  }
              );
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
          processOrder = value['processOrder'] ?? 0;
          newOrder = value['newOrder'] ?? 0;
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
        }, failure: (value) {
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
        }, failure: (value){
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
    }  else {
      SCLoadingUtils.show();
    }
    var params = {
      "conditions": {
        "fields": [
          {"map": {}, "method": 1, "name": "dealStatus", "value": 0}
        ],
        "specialMap" : {}
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
              waitDataList.addAll(List<SCVerificationOrderModel>.from(
                  list.map((e) => SCVerificationOrderModel.fromJson(e)).toList()));
            } else {
              waitDataList = List<SCVerificationOrderModel>.from(
                  list.map((e) => SCVerificationOrderModel.fromJson(e)).toList());
            }
          } else {
            if (isLoadMore == false) {
              waitDataList = [];
            }
          }
          update();
          waitController.dataList = waitDataList;
          waitController.update();
        }, failure: (value) {
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
    }  else {
      SCLoadingUtils.show();
    }
    var params = {
      "conditions": {
        "fields": [
          {"map": {}, "method": 1, "name": "dealStatus", "value": 1}
        ],
        "specialMap" : {}
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
              processingDataList.addAll(List<SCVerificationOrderModel>.from(
                  list.map((e) => SCVerificationOrderModel.fromJson(e)).toList()));
            } else {
              processingDataList = List<SCVerificationOrderModel>.from(
                  list.map((e) => SCVerificationOrderModel.fromJson(e)).toList());
            }
          } else {
            if (isLoadMore == false) {
              processingDataList = [];
            }
          }
          update();
          processingController.dataList = processingDataList;
          processingController.update();
        }, failure: (value) {
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
        }, failure: (value){
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
        }, failure: (value){
      if (currentPlateIndex == 2 && isLoadMore == true) {
        processingPageNum--;
      }
    });
  }

  /// 定时器
  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (currentPlateIndex == 0) {
        for (int i = 0; i < waitDataList.length; i++) {
          SCWorkOrderModel model = waitDataList[i];
          int subTime = model.remainingTime ?? 0;
          if (subTime > 0) {
            model.remainingTime = subTime - 1;
          } else if (subTime == 0) {
            model.remainingTime = 0;
          } else {}
        }

        for (int i = 0; i < processingDataList.length; i++) {
          SCWorkOrderModel model = processingDataList[i];
          int subTime = model.remainingTime ?? 0;
          if (subTime > 0) {
            model.remainingTime = subTime - 1;
          } else if (subTime == 0) {
            model.remainingTime = 0;
          } else {}
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
    return SCHttpManager.instance.post(url: SCUrl.kDealActualVerifyUrl, params: {"id" : id}, success: (value){}, failure: (value){});
  }

  /// 获取定位
  location() {
    SCLocationUtils.locationOnlyPosition((position, status) {
      if (status == 1) {
        SCScaffoldManager.instance.longitude = position?.longitude ?? 0;
        SCScaffoldManager.instance.latitude = position?.latitude ?? 0;
      }
    });
  }

  @override
  onClose() {
    super.onClose();
    if (timer.isActive) {
      timer.cancel();
    }
  }
}
