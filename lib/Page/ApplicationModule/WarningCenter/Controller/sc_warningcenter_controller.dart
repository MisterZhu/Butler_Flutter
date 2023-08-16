
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/WarningCenter/Model/sc_warning_dealresult_model.dart';
import 'package:smartcommunity/Page/ApplicationModule/WarningCenter/Model/sc_warningcenter_detail_model.dart';
import 'package:smartcommunity/Page/ApplicationModule/WarningCenter/Other/sc_warning_utils.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../../MaterialEntry/Model/sc_entry_type_model.dart';
import '../Model/sc_warningcenter_model.dart';

/// 预警中心controller

class SCWarningCenterController extends GetxController {

  /// 预警类型第一列的index
  int warningTypeIndex1 = -1;

  /// 预警类型第二列的index
  int warningTypeIndex2 = -1;

  /// 预警等级index
  int warningGradeIndex = 0;

  /// 预警状态index
  int warningStatusIndex = 0;

  /// 项目id
  String communityId = "";

  /// 已选的项目index
  int currentCommunityIndex = 0;

  /// 预警类型列表
  List<SCWarningDealResultModel> warningTypeList = [];

  /// 预警等级列表
  List warningGradeList = [];

  /// 预警状态列表
  List warningStatusList = [];

  int pageNum = 1;

  /// 选中的状态，默认显示全部
  int selectStatusId = -1;

  /// 选中的类型，默认显示全部
  int selectTypeId = -1;

  /// 排序，true操作时间正序，false操作时间倒序
  bool sort = false;

  List<SCWarningCenterModel> dataList = [];


  List siftList =  ['预警类型', '预警等级', '预警状态'];

  /// RefreshController
  RefreshController refreshController =
  RefreshController(initialRefresh: false);

  /// 数据是否加载成功
  bool loadDataSuccess = false;

  @override
  onInit() {
    super.onInit();
    getWarningTypeData((success, list) {});
    getWarningGradeData((success, list) {});
    getWarningStatusData((success, list) {});
  }

  /// 选择状态，刷新页面数据
  updateStatus(int value) {
    selectStatusId = value;
    pageNum = 1;
    /// 重新获取数据
    loadData(isMore: false);
  }

  /// 选择类型，刷新页面数据
  updateType(int value) {
    selectTypeId = value;
    pageNum = 1;
    /// 重新获取数据
    loadData(isMore: false);
  }

  /// 更新排序，刷新页面数据
  updateSort(bool value) {
    sort = value;
    pageNum = 1;
    /// 重新获取数据
    loadData(isMore: false);
  }

  /// 预警中心数据
  loadData({bool? isMore, Function(bool success, bool last)? completeHandler}) {
    bool isLoadMore = isMore ?? false;
    if (isLoadMore == true) {
      pageNum++;
    } else {
      pageNum = 1;
      SCLoadingUtils.show();
    }
    List fields = [];
    if (warningTypeIndex1 >= 0) {// 预警类型
      SCWarningDealResultModel model1 = warningTypeList[warningTypeIndex1];
      if (warningTypeIndex2 >= 0) {
        SCWarningDealResultModel model2 = model1.pdictionary![warningTypeIndex2];
        var dic1 = {
          "map": {},
          "method": 1,
          "name": "b.alert_type",
          "value": model1.code
        };
        var dic2 = {
          "map": {},
          "method": 1,
          "name": "a.confirm_result",
          "value": model2.code
        };
        fields.add(dic1);
        fields.add(dic2);
      } else {
        var dic = {
          "map": {},
          "method": 1,
          "name": "b.alert_type",
          "value": model1.code
        };
        fields.add(dic);
      }
    }
    if (communityId.isNotEmpty) {
      var dic = {
        "map": {},
        "method": 1,
        "name": "a.community_id",
        "value": communityId
      };
      fields.add(dic);
    }
    if (warningGradeIndex > 0) {// 预警等级
      SCWarningDealResultModel model = warningGradeList[warningGradeIndex];
      var dic = {
        "map": {},
        "method": 1,
        "name": "a.level_id",
        "value": model.code
      };
      fields.add(dic);
    }
    if (warningStatusIndex > 0) {// 预警状态
      SCWarningDealResultModel model = warningStatusList[warningStatusIndex];
      var dic = {
        "map": {},
        "method": 1,
        "name": "a.status",
        "value": model.code
      };
      fields.add(dic);
    }
    var params = {
      "conditions": {
        "fields": fields,
        "specialMap": {}
      },
      "count": false,
      "last": false,
      "orderBy": [{"asc": sort, "field": "gmtModify"}],
      "pageNum": pageNum,
      "pageSize": 20
    };
    SCHttpManager.instance.post(
        url: SCUrl.kWarningCenterListUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          loadDataSuccess = true;
          if (value is Map) {
            List list = value['records'];
            if (isLoadMore == true) {
              dataList.addAll(List<SCWarningCenterModel>.from(
                  list.map((e) => SCWarningCenterModel.fromJson(e)).toList()));
            } else {
              dataList = List<SCWarningCenterModel>.from(
                  list.map((e) => SCWarningCenterModel.fromJson(e)).toList());
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

  /// 处理结果数据字典
  loadDictionaryCode(String code,Function(bool success, List list)? completeHandler) {
    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: SCUrl.kConfigDictionaryPidCodeUrl,
        params: {'dictionaryCode': 'ALERT_CONFIRM_RESULT', 'code': code},
        success: (value) {
          SCLoadingUtils.hide();
          List<SCWarningDealResultModel> list = List<SCWarningDealResultModel>.from(value.map((e) => SCWarningDealResultModel.fromJson(e)).toList());
          for (SCWarningDealResultModel model in list) {
            if (model.code == code) {
              completeHandler?.call(true, model.pdictionary ?? []);
              break;
            }
          }
        },
        failure: (value) {
          completeHandler?.call(false, []);
          SCToast.showTip(value['message']);
        });
  }

  /// 预警类型
  getWarningTypeData(Function(bool success, List list)? completeHandler) {
    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: SCUrl.kConfigDictionaryPidCodeUrl,
        params: {'dictionaryCode': 'ALERT_CONFIRM_RESULT'},
        success: (value) {
          SCLoadingUtils.hide();
          List<SCWarningDealResultModel> list = List<SCWarningDealResultModel>.from(value.map((e) => SCWarningDealResultModel.fromJson(e)).toList());
          warningTypeList = list;
          completeHandler?.call(true, list);
        },
        failure: (value) {
          completeHandler?.call(false, []);
          SCToast.showTip(value['message']);
        });
  }

  /// 预警等级
  getWarningGradeData(Function(bool success, List list)? completeHandler) {
    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: SCUrl.kConfigDictionaryPidCodeUrl,
        params: {'dictionaryCode': 'EARLY_WARNING_LEVEL'},
        success: (value) {
          SCLoadingUtils.hide();
          print("预警等级===$value");
          List<SCWarningDealResultModel> list = List<SCWarningDealResultModel>.from(value.map((e) => SCWarningDealResultModel.fromJson(e)).toList());
          SCWarningDealResultModel model = SCWarningDealResultModel.fromJson({"name": "全部"});
          list.insert(0, model);
          warningGradeList = list;
          completeHandler?.call(true, list);
        },
        failure: (value) {
          completeHandler?.call(false, []);
          SCToast.showTip(value['message']);
        });
  }

  /// 预警状态
  getWarningStatusData(Function(bool success, List list)? completeHandler) {
    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: SCUrl.kConfigDictionaryPidCodeUrl,
        params: {'dictionaryCode': 'EARLY_WARNING_STATE'},
        success: (value) {
          print("预警状态===$value");
          SCLoadingUtils.hide();
          List<SCWarningDealResultModel> list = List<SCWarningDealResultModel>.from(value.map((e) => SCWarningDealResultModel.fromJson(e)).toList());
          SCWarningDealResultModel model = SCWarningDealResultModel.fromJson({"name": "全部"});
          list.insert(0, model);
          warningStatusList= list;
          completeHandler?.call(true, list);
        },
        failure: (value) {
          completeHandler?.call(false, []);
          SCToast.showTip(value['message']);
        });
  }

  /// 处理
  deal(String alertExplain, int confirmResult, int id, List fileVoList, int status) {
    SCLoadingUtils.show();
    var params = {
      "alertExplain": alertExplain,
      "confirmResult": confirmResult,
      "id": id,
      "fileVoList": fileVoList,
      "status": status
    };
    SCHttpManager.instance.post(
        url: SCUrl.kAlertDealUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          loadData(isMore: false);
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }

  /// 更新预警类型的index
  updateWarningTypeIndex(int value1, int value2) {
    warningTypeIndex1 = value1;
    warningTypeIndex2 = value2;
    update();
    loadData(isMore: false);
  }

  /// 重置预警类型
  resetAction() {
    warningTypeIndex1 = -1;
    warningTypeIndex2 = -1;
    update();
    loadData(isMore: false);
  }

  /// 更新预警等级的index
  updateWarningGradeIndex(int value) {
    warningGradeIndex = value;
    update();
    loadData(isMore: false);
  }

  /// 更新预警状态的index
  updateWarningStatusIndex(int value) {
    warningStatusIndex = value;
    update();
    loadData(isMore: false);
  }

  /// 更新项目id
  updateCommunityId(String value, int index) {
    communityId = value;
    currentCommunityIndex = index;
    update();
    loadData(isMore: false);
  }

  /// 处理状态文本颜色
  Color getStatusColor(int status) {
    return SCWarningCenterUtils.getStatusColor(status);
  }

  /// 预警等级文本颜色
  Color getLevelTextColor(int level) {
    return SCWarningCenterUtils.getLevelTextColor(level);
  }

  /// 预警等级背景颜色
  Color getLevelBGColor(int level) {
    return SCWarningCenterUtils.getLevelBGColor(level);
  }

  /// 预警详情
  detail(String id) {
    String url = SCUrl.kWarningDetailUrl + id;
    SCHttpManager.instance.get(url: url, success: (value){
      SCWarningCenterDetailModel model = SCWarningCenterDetailModel.fromJson(value);
      log('详情===${jsonEncode(value)}');
    }, failure: (value) {
      SCToast.showTip(value['message']);
    });
  }

  @override
  onClose() {
    refreshController.dispose();
    super.onClose();
  }
}