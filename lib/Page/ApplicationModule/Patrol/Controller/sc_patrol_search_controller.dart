import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import '../../../../Constants/sc_key.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../../WarningCenter/Model/sc_warning_dealresult_model.dart';
import '../Model/sc_patrol_task_model.dart';
import '../Other/sc_patrol_utils.dart';

/// 搜索巡查
class SCSearchPatrolController extends GetxController {
  int pageNum = 1;

  List<SCPatrolTaskModel> dataList = [];

  String tips = '';

  /// 搜索内容
  String searchString = '';

  /// appCode
  String appCode = "POLICED_POINT";

  /// 页面类型，0巡查，1品质督查，2巡检
  int pageType = 0;

  /// 初始化
  initParams(Map<String, dynamic> params) {
    if (params.isNotEmpty) {
      if (params.containsKey("pageType")) {
        pageType = params['pageType'];
        if (pageType == 1) {// 品质督查
          appCode = "QUALITY_REGULATION";
        } else if (pageType == 2) {// 巡检
          appCode = "POLICED_DEVICE";
        }
      }
    }
  }

  /// 更新搜索内容
  updateSearchString(String value) {
    searchString = value;
    update();
  }

  /// 搜索列表数据
  searchData(
      {bool? isMore,
      Function(bool success, bool last)? completeHandler}) {
    bool isLoadMore = isMore ?? false;
    if (isLoadMore == true) {
      pageNum++;
    } else {
      pageNum = 1;
      SCLoadingUtils.show();
    }
    List fields = [{"map": {}, "method": 1, "name": "wt.appCode", "value": appCode}];
    var dic1 = {
      "map": {"wt.procInstName":searchString,"procName":searchString},
      "method": 1,
      "name": "searchs",
      "value": searchString
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
          if (value is Map) {
            List list = value['records'];
            if (isLoadMore == true) {
              dataList.addAll(List<SCPatrolTaskModel>.from(list
                  .map((e) => SCPatrolTaskModel.fromJson(e))
                  .toList()));
            } else {
              dataList = List<SCPatrolTaskModel>.from(
                  list.map((e) => SCPatrolTaskModel.fromJson(e)).toList());
            }
          } else {
            if (isLoadMore == false) {
              dataList = [];
            }
          }
          if (dataList.isNotEmpty) {
            tips = '';
          } else {
            tips = '暂无搜索结果';
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
  loadDictionaryCode(
      String code, Function(bool success, List list)? completeHandler) {
    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: SCUrl.kConfigDictionaryPidCodeUrl,
        params: {'dictionaryCode': 'ALERT_CONFIRM_RESULT', 'code': code},
        success: (value) {
          SCLoadingUtils.hide();
          List<SCWarningDealResultModel> list =
              List<SCWarningDealResultModel>.from(value
                  .map((e) => SCWarningDealResultModel.fromJson(e))
                  .toList());
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

  /// 处理
  deal(String alertExplain, int confirmResult, int id, List fileVoList,
      int status) {
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
          SCScaffoldManager.instance.eventBus
              .fire({"key": SCKey.kRefreshWarningCenterPage});
          SCRouterHelper.back(null);
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }

  /// 处理状态文本颜色
  Color getStatusColor(int status) {
    return SCPatrolUtils.getStatusColor(status);
  }

}
