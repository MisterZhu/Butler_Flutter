import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Utils/Router/sc_router_path.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../../../../Utils/Date/sc_date_utils.dart';
import '../../../../Utils/Router/sc_router_helper.dart';
import '../../../../Utils/sc_utils.dart';
import '../../MaterialEntry/View/Alert/sc_reject_alert.dart';
import '../../WarningCenter/Model/sc_warning_dealresult_model.dart';

/// 巡查工具类

class SCPatrolUtils {

  /// 编号
  String procInstId = "";

  /// 任务ID
  String taskId = "";

  /// 任务关闭
  close() {
    dealTask(action: "close", result: (result) {
      if (result == true) {
        SCToast.showTip('关闭成功');
      }
    });
  }

  /// 转派
  transfer(String userId) {
    dealTask(action: "transfer", targetUser: userId, result: (result) {
      if (result == true) {
        SCToast.showTip('转派成功');
      }
    });
  }

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
                dealTask(action: "recall", content: value, imageList: imageList, result: (result) {

                });
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
                dealTask(action: "comment", content: value, imageList: imageList, result: (result) {
                  print('添加日志======$result');
                  if (result == true) {
                    SCToast.showTip('添加日志成功');
                  }
                });
              }));
    });
  }

  /// 处理操作
  deal() {
    dealTask(action: "handle", dealChannel: 1, result: (result) async {
      if (result['isScanCode'] == true) {
        // 扫码
        var data = await SCRouterHelper.pathPage(SCRouterPath.scanPath, null);
        print("扫码结果===$data");
        showDealAlert();
      } else {
        showDealAlert();
      }
    });
  }

  /// 显示处理弹窗
  showDealAlert({String? code}) {
    SCUtils.getCurrentContext(completionHandler: (BuildContext context) {
      SCDialogUtils().showCustomBottomDialog(
          isDismissible: true,
          context: context,
          widget: SCRejectAlert(
            title: '处理',
            resultDes: '',
            reasonDes: '处理说明',
            isRequired: true,
            tagList: [],
            hiddenTags: true,
            showNode: false,
            sureAction: (int index, String value, List imageList) {
              dealTask(action: "handle", dealChannel: 2, result: (result) {

              });
            },
          ));
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


  /// 处理任务
  /// action:操作类型
  /// dealChannel：处理来源，1-判断是否需要扫码,2-处理操作
  /// mode：选择的节点
  /// content：内容
  /// imageList：图片
  /// code：二维码
  /// targetUser转派人
  dealTask(
      {required String action,
        int? dealChannel,
        String? node,
        String? content,
        List? imageList,
        String? code,
        String? targetUser,
        Function(dynamic data)? result}) {
    var comment = {};
    if (action == "handle") {
      // 处理
      if (dealChannel == 2) {
        comment = {
          "attachments": transferImage(imageList ?? []),
          "text": content
        };
      } else {}
    } else if (action == "transfer") {
      // 转派
      comment = {
        "attachments": transferImage(imageList ?? []),
        "text": content
      };
    } else if (action == "close") {
      // 关闭
      comment = {
        "attachments": transferImage(imageList ?? []),
        "text": content
      };
    } else if (action == "comment") {
      // 添加日志
      comment = {
        "attachments": transferImage(imageList ?? []),
        "text": content
      };
    } else if (action == "recall") {
      // 回退
      comment = {
        "attachments": transferImage(imageList ?? []),
        "text": content
      };
    }
    var params = {
      "action": action,
      "comment": comment,
      "formData": {"field_code": code ?? ''},
      "instanceId": procInstId,
      "taskId": taskId,
      "targetUser": ""
    };
    SCHttpManager.instance.post(
        url: SCUrl.kDealTaskUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          print('任务处理=========$value');
          result?.call(value);
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }

  /// 图片转换
  List transferImage(List imageList) {
    List list = [];
    for (var params in imageList) {
      var newParams = {
        "id": SCDateUtils.timestamp(),
        "isImage": true,
        "name": params['name'],
        "url": params['fileKey']
      };
      list.add(newParams);
    }
    return list;
  }
}
