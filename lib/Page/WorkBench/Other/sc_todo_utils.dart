import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Utils/Strings/sc_string.dart';

import '../../../Constants/sc_default_value.dart';
import '../../../Constants/sc_h5.dart';
import '../../../Constants/sc_key.dart';
import '../../../Network/sc_config.dart';
import '../../../Network/sc_http_manager.dart';
import '../../../Network/sc_url.dart';
import '../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../Utils/Date/sc_date_utils.dart';
import '../../../Utils/Router/sc_router_helper.dart';
import '../../../Utils/Router/sc_router_path.dart';
import '../../../Utils/sc_utils.dart';
import '../../ApplicationModule/Patrol/Model/sc_patrol_detail_model.dart';
import '../../ApplicationModule/Patrol/Other/sc_patrol_utils.dart';
import '../Home/Model/sc_todo_model.dart';

/// 点击待办处理
class SCToDoUtils {
  /// 点击卡片-详情
  detail(SCToDoModel model) {
    if (model.appName == "TASK") {
      /// 三巡一保
      if (model.type == "POLICED_POINT" || model.type == "POLICED_DEVICE") {
        /// 巡查
        patrolDetail(model);
      } else if (model.type == "POLICED_WATCH") {
        dealPatrolNewTask(model);
      } else if (model.type == "SAFE_PROD") {
        /// 安全生产
        SCToast.showTip(SCDefaultValue.developingTip);
      } else if (model.type == "QUALITY_REGULATION") {
        /// 品质督查
        qualityRegulationDetail(model);
      } else {
        /// 未知
        SCToast.showTip(SCDefaultValue.developingTip);
      }
    } else if (model.appName == "WORK_ORDER") {
      ///  工单
      workOrderDetail(model);
    } else {
      /// 未知
      SCToast.showTip(SCDefaultValue.developingTip);
    }
  }

  /// 点击卡片-处理
  dealAction(SCToDoModel model, String btnText) {
    if (model.appName == "TASK") {
      /// 三巡一保
      if (model.type == "POLICED_POINT" ||
          model.type == "POLICED_DEVICE" ||
          model.type == "POLICED_WATCH") {
        /// 巡查
        dealPatrolTask(model, btnText);
      } else if (model.type == "SAFE_PROD") {
        /// 安全生产
        dealPatrolTask(model, btnText);
      } else {
        /// 未知

      }
    } else if (model.appName == "WORK_ORDER") {
      ///  工单
      workOrderDetail(model);
    } else {
      /// 未知
      SCToast.showTip('未知错误');
    }
  }

  //抢单处理
  toGetOrder(SCToDoModel model) {
    SCLoadingUtils.show();
    var params = {
      "action": "accept",
      "instanceId": "",
      "taskId": "",
    };
    SCHttpManager.instance.post(
        url: SCUrl.kTransferUserListUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }

  /// 品质督查
  qualityRegulationDetail(SCToDoModel model) {
    List<String>? title = model.taskId?.split("\$\_\$");
    String url = '';
    if ((title ?? []).isNotEmpty && title?.length == 2) {
      url =
          "${SCConfig.BASE_URL}${SCH5.qualityInspectionDetailsUrl}?id=${title?[0]}&nodeId=${title?[1]}";
    } else {
      SCToast.showTip('未知错误');
      return;
    }
    String realUrl =
    SCUtils.getWebViewUrl(url: url, title: '', needJointParams: true);
    SCRouterHelper.pathPage(SCRouterPath.webViewPath, {
      "title": model.subTypeDesc ?? '',
      "url": realUrl,
      "needJointParams": true
    })?.then((value) {
      SCScaffoldManager.instance.eventBus
          .fire({"key": SCKey.kRefreshWorkBenchPage});
    });
  }

  workOrderDetail(SCToDoModel model) {
    int status = (model.statusValue ?? '0').cnToInt();
    String title = SCUtils.getWorkOrderButtonText(status);
    String url =
        "${SCConfig.BASE_URL}${SCH5.workOrderUrl}?isFromWorkBench=1&status=$status&orderId=${model.taskId}";
    String realUrl =
        SCUtils.getWebViewUrl(url: url, title: title, needJointParams: true);
    SCRouterHelper.pathPage(SCRouterPath.webViewPath, {
      "title": model.subTypeDesc ?? '',
      "url": realUrl,
      "needJointParams": false
    })?.then((value) {
      SCScaffoldManager.instance.eventBus
          .fire({"key": SCKey.kRefreshWorkBenchPage});
    });
  }

  /// 巡查详情
  patrolDetail(SCToDoModel model) {
    String id = model.taskId ?? '';
    String procInstId = '';
    String nodeId = '';
    if (id.isNotEmpty) {
      if (id.contains('\$_\$')) {
        List idList = id.split('\$_\$');
        if (idList.length > 1) {
          procInstId = idList[0];
          nodeId = idList[1];
        } else if (idList.length == 1) {
          procInstId = idList[0];
        }
      } else {
        procInstId = model.taskId ?? '';
      }
    }
    SCRouterHelper.pathPage(SCRouterPath.patrolDetailPage, {
      "procInstId": procInstId,
      "nodeId": nodeId,
      "type": model.type
    })?.then((value) {
      SCScaffoldManager.instance.eventBus
          .fire({"key": SCKey.kRefreshWorkBenchPage});
    });
  }

  /// 巡查处理
  dealPatrolTask(SCToDoModel model, String btnText) async {
    String id = model.taskId ?? '';
    String procInstId = '';
    String nodeId = '';
    if (id.isNotEmpty) {
      if (id.contains('\$_\$')) {
        List idList = id.split('\$_\$');
        if (idList.length > 1) {
          procInstId = idList[0];
          nodeId = idList[1];
        }
      }
    }
    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: '${SCUrl.kPatrolDetailUrl}$procInstId\$_\$$nodeId',
        params: null,
        success: (value) {
          SCLoadingUtils.hide();
          String taskId = value['taskId'];
          SCPatrolUtils patrolUtils = SCPatrolUtils();
          patrolUtils.taskId = taskId;
          patrolUtils.procInstId = procInstId;
          patrolUtils.nodeId = nodeId;
          patrolUtils.taskAction(name: btnText);
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }

  /// 巡查处理
  dealPatrolNewTask(SCToDoModel model) async {
    String id = model.taskId ?? '';
    String procInstId = '';
    String nodeId = '';
    if (id.isNotEmpty) {
      if (id.contains('\$_\$')) {
        List idList = id.split('\$_\$');
        if (idList.length > 1) {
          procInstId = idList[0];
          nodeId = idList[1];
        }
      }
    }
    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: '${SCUrl.kPatrolDetailUrl}$procInstId\$_\$$nodeId',
        params: null,
        success: (value) {
          SCLoadingUtils.hide();

          SCPatrolDetailModel model = SCPatrolDetailModel.fromJson(value);
          if (model.formData?.checkObject?.type == "route") {
            SCRouterHelper.pathPage(SCRouterPath.patrolRoutePage, {
              "place": model.formData,
              "procInstId": model.procInstId ?? '',
              "nodeId": model.nodeId ?? ''
            });
          } else {
            log('我的数据-------------------------------------此处执行了${model.procInstId ?? ''}  ${model.nodeId ?? ''}');
            SCRouterHelper.pathPage(SCRouterPath.patrolDetailPage, {
              "procInstId": model.procInstId ?? '',
              "nodeId": model.nodeId ?? '',
              "type": "POLICED_WATCH"
            });
          }
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }

  /// 获取卡片按钮title、处理状态title、颜色值等
  Map<String, dynamic> getCardStyle(SCToDoModel model) {
    // 按钮title
    String btnTitle = '';
    // 状态title
    String statusTitle = model.statusName ?? '';
    // 状态title颜色
    Color statusColor = SCColors.color_1B1D33;
    // 状态
    int status = (model.statusValue ?? '0').cnToInt();
    // 剩余时间相关信息
    var remainingTimeMap = getRemainingTime(model);
    // 创建时间
    String createTime = remainingTimeMap['createTime'];
    // 是否显示倒计时
    bool isShowTimer = remainingTimeMap['isShowTimer'];
    // 剩余时间
    int remainingTime = remainingTimeMap['remainingTime'];
    if ((model.operationList ?? []).isNotEmpty) {
      btnTitle = model.operationList?.first;
    }
    if (model.appName == "TASK") {
      /// 三巡一保
      if (model.type == "POLICED_POINT") {
        /// 巡查
        statusColor = SCPatrolUtils.getStatusColor(status);
      } else if (model.type == "SAFE_PROD") {
        /// 安全生产

      } else {
        /// 未知

      }
    } else if (model.appName == "WORK_ORDER") {
      ///  工单
      btnTitle =
          SCUtils.getWorkOrderButtonText((model.statusValue ?? '0').cnToInt());
    } else {
      /// 未知

    }
    return {
      "btnTitle": btnTitle,
      "statusTitle": statusTitle,
      "statusColor": statusColor,
      'isShowTimer': isShowTimer,
      "remainingTime": remainingTime,
      "createTime": createTime
    };
  }

  /// 通过结束时间获取剩余时间
  Map<String, dynamic> getRemainingTime(SCToDoModel model) {
    // 创建时间
    String createTime = model.createTime ?? '';
    // 是否显示倒计时
    bool isShowTimer = false;
    // 剩余时间
    int remainingTime = 0;
    if (model.appName == "TASK") {
      /// 三巡一保
      if (model.type == "POLICED_POINT") {
        /// 巡查
        // model.endTime = '2023-05-15 09:20:54';
        if (model.endTime != null && model.endTime != '') {
          DateTime endTime = SCDateUtils.stringToDateTime(
              dateString: model.endTime ?? '',
              formateString: 'yyyy-MM-dd HH:mm:ss');
          int endTimeStamp = endTime.millisecondsSinceEpoch ~/ 1000;
          int currentTimeStamp = SCDateUtils.timestamp() ~/ 1000;
          remainingTime = endTimeStamp - currentTimeStamp;
          isShowTimer = true;
        }
      } else if (model.type == "SAFE_PROD") {
        /// 安全生产

      } else {
        /// 未知

      }
    } else if (model.appName == "WORK_ORDER") {
      ///  工单
      if (model.endTime != null && model.endTime != '') {
        DateTime endTime = SCDateUtils.stringToDateTime(
            dateString: model.endTime ?? '',
            formateString: 'yyyy-MM-dd HH:mm:ss');
        int endTimeStamp = endTime.millisecondsSinceEpoch ~/ 1000;
        int currentTimeStamp = SCDateUtils.timestamp() ~/ 1000;
        remainingTime = endTimeStamp - currentTimeStamp;
        isShowTimer = true;
      }
    } else {
      /// 未知

    }
    return {
      'isShowTimer': isShowTimer,
      "remainingTime": remainingTime,
      "createTime": createTime
    };
  }
}
