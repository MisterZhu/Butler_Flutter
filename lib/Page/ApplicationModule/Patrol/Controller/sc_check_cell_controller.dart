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

/// 任务日志controller

class SCCheckCellController extends GetxController {
  SCUIDetailCellModel detailCellModel = SCUIDetailCellModel();

  SCPatrolDetailModel detailModel = SCPatrolDetailModel();

  ///默认选中的单选框的值
  String groupValue = "0";

  /// 图片数组
  List photosList = [];

  List<Attachment>? photosUrl = [];

  String title = "";

  String input = "";

  CheckList checkId = CheckList();

  @override
  onInit() {
    super.onInit();
  }

  /// 初始化
  initParams(Map<String, dynamic> params) {
    if (params.isNotEmpty) {
      var model = params['model'];
      if (model != null) {
        detailCellModel = model;
        title = detailCellModel.title!;
        log("detailCellModel--->${detailCellModel.toString()}");
      }
      var patrolDetail = params['patrolDetail'];
      if (patrolDetail != null) {
        detailModel = patrolDetail;
        log("detailModel--->${detailModel.toString()}");
      }
      checkId = params['checkItem'];
      if (checkId.evaluateResult?.isNotEmpty ?? false) {
        if (checkId.evaluateResult == "QUALIFIED") {
          groupValue = "0";
        } else {
          groupValue = "1";
        }
      }
      input = checkId.comments ?? '';
      if ((checkId.attachments ?? []).isNotEmpty) {
        for (var element in checkId.attachments ?? []) {
          photosList.add(element.url);
        }
        log('photosList-->${photosList.toString()}');
      }
    }
  }

  loadData(int type, List imageList) {
    SCLoadingUtils.show();
    String str = "";
    if (type == 0) {
      str = "QUALIFIED";
    } else {
      str = "UNQUALIFIED";
    }
    var param1 = {
      "checkId": checkId.id,
      "nodeId": detailModel.nodeId,
      "procInstId": detailModel.procInstId,
      "evaluateResult": str,
      "taskId": detailModel.taskId,
      "comments": input,
      "attachments": transferImage(imageList ?? [])
    };
    SCHttpManager.instance.post(
        url: SCUrl.kPatrolReport,
        params: param1,
        success: (value) {
          SCLoadingUtils.hide();
          SCScaffoldManager.instance.eventBus
              .fire({'key': SCKey.kRefreshPatrolDetailPage});
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
          newParams['url'] = fileUrl;
        }
      } catch (e) {
        List splitName = params.toString().split('/');
        newParams['name'] = splitName[splitName.length - 1];
        newParams['url'] = params;
      }

      log("transferImage-->${imageList.toString()}");
      list.add(newParams);
    }
    return list;
  }
}
