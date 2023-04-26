import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';

import '../../../../Constants/sc_key.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Utils/Router/sc_router_helper.dart';
import '../../../../Utils/sc_utils.dart';
import '../../MaterialEntry/View/Alert/sc_reject_alert.dart';
import '../../WarningCenter/Model/sc_warning_dealresult_model.dart';

/// 巡查工具类

class SCPatrolUtils {
  /// 回退操作
  rollBack() {
    SCUtils.getCurrentContext(completionHandler: (BuildContext context) {
      SCDialogUtils().showCustomBottomDialog(
          isDismissible: true,
          context: context,
          widget: SCRejectAlert(
              title: '任务退回',
              resultDes: '',
              reasonDes: '退回理由',
              isRequired: true,
              tagList: const [],
              hiddenTags: true,
              showNode: true,
              sureAction: (int index, String value, List imageList) {
                //   SCWarningDealResultModel model = list[index];
                //   controller.deal(
                //       value,
                //       int.parse(model.code ?? '0'),
                //       int.parse(controller.id),
                //       imageList,
                //       controller.detailModel.status ?? 0);
                // },
              }));
    });
  }

  /// 添加日志操作
  addLog() {
    SCUtils.getCurrentContext(completionHandler: (BuildContext context) {
      SCDialogUtils().showCustomBottomDialog(
          isDismissible: true,
          context: context,
          widget: SCRejectAlert(
              title: '添加日志',
              resultDes: '',
              reasonDes: '日志内容',
              isRequired: true,
              tagList: const [],
              hiddenTags: true,
              showNode: false,
              sureAction: (int index, String value, List imageList) {
                //   SCWarningDealResultModel model = list[index];
                //   controller.deal(
                //       value,
                //       int.parse(model.code ?? '0'),
                //       int.parse(controller.id),
                //       imageList,
                //       controller.detailModel.status ?? 0);
                // },
              }));
    });
  }

  /// 处理操作
  deal(String code, int id, int status) {

    // loadDictionaryCode(code, (success, list) {
    //   if (success) {
    //     List<String> tagList = [];
    //     for (SCWarningDealResultModel model in list) {
    //       tagList.add(model.name ?? '');
    //     }
    //     SCUtils.getCurrentContext(completionHandler: (BuildContext context) {
    //       SCDialogUtils().showCustomBottomDialog(
    //           isDismissible: true,
    //           context: context,
    //           widget: SCRejectAlert(
    //             title: '处理',
    //             resultDes: '处理结果',
    //             reasonDes: '处理说明',
    //             isRequired: true,
    //             tagList: tagList,
    //             hiddenTags: true,
    //             showNode: true,
    //             sureAction: (int index, String value, List imageList) {
    //               SCWarningDealResultModel model = list[index];
    //               dealPatrol(value, int.parse(model.code ?? '0'), id, imageList,
    //                   status);
    //             },
    //           ));
    //     });
    //   }
    // });
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

  /// 提交处理
  dealPatrol(String alertExplain, int confirmResult, int id, List fileVoList,
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
}
