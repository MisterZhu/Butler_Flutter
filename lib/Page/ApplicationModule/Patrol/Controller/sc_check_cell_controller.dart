import 'dart:convert';
import 'dart:developer';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_key.dart';
import 'package:smartcommunity/Network/sc_config.dart';
import 'package:smartcommunity/Page/ApplicationModule/Patrol/Model/sc_form_data_model.dart';
import 'package:smartcommunity/Page/ApplicationModule/Patrol/Model/sc_image_model.dart';
import 'package:smartcommunity/Page/ApplicationModule/Patrol/Model/sc_patrol_detail_model.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import 'package:smartcommunity/Utils/Date/sc_date_utils.dart';
import 'package:smartcommunity/utils/Router/sc_router_helper.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../Model/sc_task_check_model.dart';

/// 任务日志controller

class SCCheckCellController extends GetxController {

  CellDetailList cellDetailList = CellDetailList();

  TaskCheckModel taskCheckModel = TaskCheckModel();

  ///默认选中的单选框的值
  String groupValue = "0";

  /// 图片数组
  List photosList = [];

  List<Attachment>? photosUrl = [];

  String title = "";

  String input = "";

  @override
  onInit() {
    super.onInit();
  }

  /// 初始化
  initParams(Map<String, dynamic> params) {
    if (params.isNotEmpty) {
      cellDetailList = params['cellDetailList'];
      taskCheckModel = params['taskCheckModel'];
      if (cellDetailList != null) {
        title = cellDetailList.checkName!;
        if (cellDetailList.evaluateResult?.isNotEmpty ?? false) {
          if (cellDetailList.evaluateResult == "QUALIFIED") {
            groupValue = "0";
          } else {
            groupValue = "1";
          }
        }
        input = cellDetailList.comments ?? '';
      }
      if ((cellDetailList.attachments ?? []).isNotEmpty) {
        for (Attachment element in cellDetailList.attachments ?? []) {
          photosList.add(element.fileKey);
        }
      }
    }
  }

  loadData() {
    SCLoadingUtils.show();
    String str = "";
    if (groupValue == "0") {
      str = "QUALIFIED";
    } else {
      str = "UNQUALIFIED";
    }
    var param1 = {
      "checkId": cellDetailList.checkId,
      "nodeId": taskCheckModel.nodeId,
      "procInstId": taskCheckModel.procInstId,
      "evaluateResult": str,
      "taskId": taskCheckModel.taskId,
      "comments": input,
      "attachments": transferImage(photosList ?? [])
    };
    SCHttpManager.instance.post(
        url: SCUrl.kPatrolReport,
        params: param1,
        success: (value) {
          SCLoadingUtils.hide();
          SCScaffoldManager.instance.eventBus
              .fire({'key': SCKey.kRefreshCellDetailPage});
          SCRouterHelper.back(null);
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
      };

      try {
        var fileName = params['name'];
        var fileUrl = params['fileKey'];
        if (fileName != null) {
          newParams['name'] = fileName;
        }
        if (fileUrl != null) {
          newParams['fileKey'] = fileUrl;
        }
      } catch (e) {
        List splitName = params.toString().split('/');
        newParams['name'] = splitName[splitName.length - 1];
        newParams['fileKey'] = params;
      }

      log("transferImage-->${imageList.toString()}");
      list.add(newParams);
    }
    return list;
  }
}
