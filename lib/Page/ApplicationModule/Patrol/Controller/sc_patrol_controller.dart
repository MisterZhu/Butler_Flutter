import 'dart:convert';
import 'dart:developer';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/Patrol/Model/sc_patrol_type_model.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../../WarningCenter/Model/sc_warning_dealresult_model.dart';
import '../Model/sc_patrol_task_model.dart';

/// 巡查controller

class SCPatrolController extends GetxController {
  int pageNum = 1;

  /// 选中的状态index
  int selectStatusIndex = 0;

  /// 排序，true操作时间正序，false操作时间倒序
  bool sort = false;

  /// 选中的排序index，默认倒序
  int selectSortIndex = 1;

  /// 类型第一列的index
  int typeIndex1 = -1;

  /// 类型第二列的index
  int typeIndex2 = -1;

  /// 类型列表
  List<SCWarningDealResultModel> typeList = [];

  List siftList = ['分类', '状态', '排序'];

  List<SCWarningDealResultModel> statusList = [];

  /// 项目id
  String communityId = "";

  /// 已选的项目index
  int currentCommunityIndex = 0;

  /// RefreshController
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  /// 数据是否加载成功
  bool loadDataSuccess = false;

  List<SCPatrolTaskModel> dataList = [];

  /// 页面类型，0巡查，1品质督查，2巡检 3.巡更
  int pageType = 0;

  /// appCode
  String appCode = "POLICED_POINT";
  String deviceCode = "";


  /// 初始化
  initParams(Map<String, dynamic> params) {
    if (params.isNotEmpty) {
      if (params.containsKey("pageType")) {
        pageType = params['pageType'];
        if (pageType == 1) {
          // 品质督查
          appCode = "QUALITY_REGULATION";
        } else if (pageType == 2) {
          // 巡检
          appCode = "POLICED_DEVICE";
          if (params.containsKey("deviceCode")) {
            deviceCode = params['deviceCode'];
          }
        } else if (pageType == 3) {
          appCode = "POLICED_WATCH";
        }
      }
    }
    getTaskStatusData();
    getTypeData();
    if (deviceCode.isNotEmpty) {
      loadScanData(isMore: false);
    } else {
      loadData(isMore: false);
    }
  }

  /// 更新项目id
  updateCommunityId(String value, int index) {
    communityId = value;
    currentCommunityIndex = index;
    update();
    loadData(isMore: false);
  }

  /// 选择状态，刷新页面数据
  updateStatusIndex(int value) {
    selectStatusIndex = value;
    pageNum = 1;

    /// 重新获取数据
    if (deviceCode.isNotEmpty) {
      loadScanData(isMore: false);
    } else {
      loadData(isMore: false);
    }
  }

  /// 更新排序，刷新页面数据
  updateSort(bool value) {
    sort = value;
    pageNum = 1;

    /// 重新获取数据
    if (deviceCode.isNotEmpty) {
      loadScanData(isMore: false);
    } else {
      loadData(isMore: false);
    }
  }

  /// 巡查列表数据
  loadData({bool? isMore, Function(bool success, bool last)? completeHandler}) {
    bool isLoadMore = isMore ?? false;
    if (isLoadMore == true) {
      pageNum++;
    } else {
      pageNum = 1;
      SCLoadingUtils.show();
    }
    List fields = [];
    if (typeIndex1 >= 0) {
      // 分类
      SCWarningDealResultModel model1 = typeList[typeIndex1];
      if (typeIndex2 >= 0) {
        SCWarningDealResultModel model2 = model1.pdictionary![typeIndex2];
        var dic = {
          "map": {},
          "method": 7,
          "name": "childrenIdList",
          "value": [model2.id]
        };
        fields.add(dic);
      } else {
        List idList = [];
        for (SCWarningDealResultModel model3 in (model1.pdictionary ?? [])) {
          idList.add(model3.id);
        }
        var dic = {
          "map": {},
          "method": 7,
          "name": "childrenIdList",
          "value": idList
        };
        fields.add(dic);
      }
    }
    if (selectStatusIndex > 0) {
      // 状态
      SCWarningDealResultModel model = statusList[selectStatusIndex];
      var dic = {
        "map": {},
        "method": 1,
        "name": "wf.name",
        // TODO ---【临时代码】待数据看板9月份上线 注释----
        "value": (statusList[selectStatusIndex].name?.length ?? 0) >= 3 &&
                pageType == 2
            ? model.name?.substring(0, 3)
            : model.name
      };
      fields.add(dic);
    }
    if (communityId.isNotEmpty) {
      var dic = {
        "map": {},
        "method": 1,
        "name": "wt.suitableTargetId",
        "value": communityId
      };
      fields.add(dic);
    }
    var dic1 = {"map": {}, "method": 1, "name": "wt.appCode", "value": appCode};
    fields.add(dic1);
    var params = {
      "conditions": {"fields": fields},
      "count": true,
      "last": false,
      "orderBy": [
        {"asc": sort, "field": "wt.gmtModify"}
      ],
      // 排序，正序是 true，倒序是 false
      "pageNum": pageNum,
      "pageSize": 20
    };
    SCHttpManager.instance.post(
        url: SCUrl.kPatrolListUrl,
        params: params,
        success: (value) {
          loadDataSuccess = true;
          SCLoadingUtils.hide();
          if (value is Map) {
            List list = value['records'];
            if (isLoadMore == true) {
              dataList.addAll(List<SCPatrolTaskModel>.from(
                  list.map((e) => SCPatrolTaskModel.fromJson(e)).toList()));
            } else {
              dataList = List<SCPatrolTaskModel>.from(
                  list.map((e) => SCPatrolTaskModel.fromJson(e)).toList());
            }
          } else {
            if (isLoadMore == false) {
              dataList = [];
            }
          }
          // TODO ---【临时代码】待数据看板9月份上线 项目侧：只处理目前5种状态 注释----
          if (selectStatusIndex != 0 && pageType == 2) {
            var total = value['total'].toString();
            statusList[selectStatusIndex].name =
                (statusList[selectStatusIndex].name!.substring(0, 3) + total)
                    .toString();
          }
          // TODO ---【临时代码】待数据看板9月份上线 注释----
          update();
          bool last = false;
          if (isLoadMore) {
            last = value['last'];
          }
          completeHandler?.call(true, last);
        },
        failure: (value) {
          if (isLoadMore) {
            pageNum--;
          }
          SCToast.showTip(value['message']);
          completeHandler?.call(false, false);
        });
  }

  /// 扫描列表数据
  loadScanData(
      {bool? isMore, Function(bool success, bool last)? completeHandler}) {
    bool isLoadMore = isMore ?? false;
    if (isLoadMore == true) {
      pageNum++;
    } else {
      pageNum = 1;
      SCLoadingUtils.show();
    }
    List fields = [
      {"map": {}, "method": 1, "name": "wt.appCode", "value": appCode}
    ];
    var dic1 = {
      "map": {"wt.procInstName": deviceCode, "procName": deviceCode},
      "method": 1,
      "name": "searchs",
      "value": deviceCode
    };
    fields.add(dic1);
    var params = {
      "conditions": {"fields": fields},
      "count": false,
      "last": false,
      "orderBy": [],
      "pageNum": pageNum,
      "pageSize": 20
    };
    SCHttpManager.instance.post(
        url: SCUrl.kPatrolListUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          loadDataSuccess = true;
          SCLoadingUtils.hide();
          if (value is Map) {
            List list = value['records'];
            if (isLoadMore == true) {
              dataList.addAll(List<SCPatrolTaskModel>.from(
                  list.map((e) => SCPatrolTaskModel.fromJson(e)).toList()));
            } else {
              dataList = List<SCPatrolTaskModel>.from(
                  list.map((e) => SCPatrolTaskModel.fromJson(e)).toList());
            }
          } else {
            if (isLoadMore == false) {
              dataList = [];
            }
          }
          update();
          bool last = false;
          if (isLoadMore) {
            last = value['last'];
          }
          completeHandler?.call(true, last);
        },
        failure: (value) {
          if (isLoadMore) {
            pageNum--;
          }
          SCToast.showTip(value['message']);
          completeHandler?.call(false, false);
        });
  }

  /// 任务状态
  getTaskStatusData() {
    var dictionaryCode = 'CUSTOM_STATUS';
    if (pageType == 2) {
      dictionaryCode = 'PATROL_INS';
    }
    SCHttpManager.instance.get(
        url: SCUrl.kConfigDictionaryPidCodeUrl,
        params: {'dictionaryCode': dictionaryCode},
        success: (value) {
          List<SCWarningDealResultModel> list =
              List<SCWarningDealResultModel>.from(value
                  .map((e) => SCWarningDealResultModel.fromJson(e))
                  .toList());
          SCWarningDealResultModel model =
              SCWarningDealResultModel.fromJson({'name': '全部', 'code': -1});
          list.insert(0, model);
          statusList = list;
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }

  /// 获取分类
  getTypeData() {
    SCHttpManager.instance.post(
        url: SCUrl.kPatrolTypeUrl,
        params: {"appCode": appCode},
        success: (value) {
          List<SCPatrolTypeModel> list = List<SCPatrolTypeModel>.from(
              value.map((e) => SCPatrolTypeModel.fromJson(e)).toList());
          for (SCPatrolTypeModel model in list) {
            List children = [];
            for (SCPatrolTypeModel subModel in (model.children ?? [])) {
              var subParams = {
                "id": subModel.id.toString(),
                "name": subModel.categoryName,
              };
              children.add(subParams);
            }
            var params = {
              "id": model.id.toString(),
              "name": model.categoryName,
              "pdictionary": children
            };
            SCWarningDealResultModel subModel =
                SCWarningDealResultModel.fromJson(params);
            typeList.add(subModel);
          }
          log('分类===${jsonEncode(value)}');
        },
        failure: (value) {});
  }

  /// 更新类型的index
  updateTypeIndex(int value1, int value2) {
    typeIndex1 = value1;
    typeIndex2 = value2;
    update();
    loadData(isMore: false);
  }

  /// 重置预警类型
  resetAction() {
    typeIndex1 = -1;
    typeIndex2 = -1;
    update();
    loadData(isMore: false);
  }
}
