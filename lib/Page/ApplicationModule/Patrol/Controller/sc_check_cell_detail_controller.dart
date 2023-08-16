import 'dart:async';
import 'dart:developer';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_key.dart';
import 'package:smartcommunity/Network/sc_config.dart';
import 'package:smartcommunity/Page/ApplicationModule/Patrol/Model/sc_form_data_model.dart';
import 'package:smartcommunity/Page/ApplicationModule/Patrol/Model/sc_image_model.dart';
import 'package:smartcommunity/Page/ApplicationModule/Patrol/Model/sc_patrol_detail_model.dart';
import 'package:smartcommunity/Page/ApplicationModule/Patrol/Model/sc_task_check_model.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import 'package:smartcommunity/Utils/Date/sc_date_utils.dart';
import 'package:smartcommunity/utils/Router/sc_router_helper.dart';
import '../../../../Constants/sc_h5.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../../../../Utils/Router/sc_router_path.dart';
import '../../../../Utils/sc_utils.dart';
import '../Model/sc_work_order_model.dart';

/// 任务日志controller

class SCCheckCellDetailController extends GetxController {
  CellDetailList cellDetailList = CellDetailList();

  TaskCheckModel taskCheckModel = TaskCheckModel();

  SCPatrolDetailModel patrolDetailModel = SCPatrolDetailModel();

  List<String> photoList = [];

  List<WorkOrder> workOrders = [];

  List<WorkOrder> workOrderDetailList = [];

  Timer? timer;

  @override
  onInit() {
    super.onInit();
  }

  /// 初始化
  initParams(Map<String, dynamic> params) {
    if (params.isNotEmpty) {
      try {
        var model = params['cellDetailList'];
        taskCheckModel = params['taskCheckModel'];
        patrolDetailModel = params['patrolDetailModel'];
        if (model != null) {
          cellDetailList = model;
          photoList.clear();
          if (cellDetailList.attachments?.isNotEmpty ?? false) {
            cellDetailList.attachments?.forEach((element) {
              photoList.add(element.fileKey ?? '');
            });
          }
          workOrders = cellDetailList.workOrders ?? [];
        }
      } catch (e) {
        e.toString();
      }
    }

    loadWorkOrderList();
  }

  jumpToEdit() {
    SCRouterHelper.pathPage(SCRouterPath.patrolCheckCellEditPage,
        {'cellDetailList': cellDetailList, 'taskCheckModel': taskCheckModel});
  }

  jumpToAddReport() {
    SCRouterHelper.pathPage(SCRouterPath.webViewPath, {
      "title": '快捷报事',
      "url": SCUtils.getWebViewUrl(
          url: getReportUrl(), title: '快捷报事', needJointParams: true)
    });
  }

  getReportUrl() {
    return SCConfig.getH5Url(
        "${SCH5.quickReportUrl}?procInstId=${taskCheckModel.procInstId ?? ''}"
            "&taskId=${taskCheckModel.taskId ?? ''}&nodeId=${taskCheckModel.nodeId ?? ''}&checkId=${taskCheckModel.checkId ?? ''}"
            "&placeName=${patrolDetailModel.formData?.checkObject?.place?.placeName ?? ''}&procName=${patrolDetailModel.procName}&communityId=${patrolDetailModel.communityId}");
  }

  updateData() {
    var param1 = {
      "checkId": cellDetailList.checkId,
      "nodeId": taskCheckModel.nodeId,
      "procInstId": taskCheckModel.procInstId,
      "taskId": taskCheckModel.taskId
    };
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.taskCheck,
        params: param1,
        success: (value) {
          SCLoadingUtils.hide();
          cellDetailList = CellDetailList.fromJson(value);
          photoList.clear();
          if (cellDetailList.attachments?.isNotEmpty ?? false) {
            cellDetailList.attachments?.forEach((element) {
              photoList.add(element.fileKey ?? '');
            });
          }
          workOrders = cellDetailList.workOrders ?? [];
          update();
        },
        failure: (value) {
          SCLoadingUtils.hide();
          SCToast.showTip(value['message']);
        });
  }

  loadWorkOrderList() {
    if (cellDetailList.workOrders?.isEmpty ?? true) return;
    List<WorkOrder> valueId = cellDetailList.workOrders ?? [];
    List list = [];
    for (var element in valueId) {
      list.add(element.orderId);
    }
    var params = {
      "conditions": {
        "fields": [
          {"map": {}, "method": 15, "name": "wo.id", "value": list}
        ]
      },
      "count": true,
      "last": true,
      "orderBy": [], // 排序，正序是 true，倒序是 false
      "pageNum": 1,
      "pageSize": 40
    };
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kWorkOrderListUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          if (value is Map) {
            List list = value['records'];
            workOrderDetailList = List<WorkOrder>.from(
                list.map((e) => WorkOrder.fromJson(e)).toList());
            update();
            // TODO 待优化
            if (workOrderDetailList.isNotEmpty) {
              startTimer();
            }
          }
        },
        failure: (value) {
          SCLoadingUtils.hide();
          SCToast.showTip(value['message']);
        });
  }

  String setCheckState(String str) {
    if (str == "QUALIFIED") {
      str = "正常";
    } else if (str == "UNQUALIFIED") {
      str = "异常";
    } else {
      str = "未查";
    }
    return str;
  }

  /// 定时器
  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      for (int i = 0; i < workOrderDetailList.length; i++) {
        WorkOrder model = workOrderDetailList[i];
        int subTime = model.remainingTime ?? 0;
        if (subTime > 0) {
          model.remainingTime = subTime - 1;
        } else if (subTime == 0) {
          model.remainingTime = 0;
        } else {}
        update();
      }
    });
  }

  @override
  onClose() {
    super.onClose();
    if (timer != null) {
      timer?.cancel();
    }
  }
}
