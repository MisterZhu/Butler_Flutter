import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/WarningCenter/Model/sc_warningcenter_model.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';

import '../../../../Constants/sc_key.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../Model/sc_warning_dealresult_model.dart';
import '../Other/sc_warning_utils.dart';

/// 搜索预警
class SCSearchWarningController extends GetxController {
  int pageNum = 1;

  List<SCWarningCenterModel> dataList = [];

  String tips = '';

  /// 搜索内容
  String searchString = '';

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
    var params = {
      "conditions": {
        "fields": [
          {"map": {}, "method": 1, "name": "a.alert_code", "value": searchString}
        ],
        "specialMap": {}
      },
      "count": false,
      "last": false,
      "orderBy": [
        {"asc": true, "field": "gmtModify"}
      ],
      "pageNum": pageNum,
      "pageSize": 20
    };
    SCHttpManager.instance.post(
        url: SCUrl.kWarningCenterListUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          if (value is Map) {
            List list = value['records'];
            if (isLoadMore == true) {
              dataList.addAll(List<SCWarningCenterModel>.from(list
                  .map((e) => SCWarningCenterModel.fromJson(e))
                  .toList()));
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
}
