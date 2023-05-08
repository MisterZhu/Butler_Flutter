import 'package:sc_uikit/sc_uikit.dart';

import '../../../Constants/sc_h5.dart';
import '../../../Constants/sc_key.dart';
import '../../../Network/sc_config.dart';
import '../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../Utils/Router/sc_router_helper.dart';
import '../../../Utils/Router/sc_router_path.dart';
import '../../../Utils/sc_utils.dart';
import '../Home/Model/sc_todo_model.dart';

/// 点击待办处理
class SCToDoUtils {
  /// 点击处理按钮
  deal(SCToDoModel model) {
    if (model.appName == "TASK") {/// 三巡一保
      if (model.type == "POLICED_POINT") {/// 巡查
        patrolDetail(model);
      } else if (model.type == "SAFE_PROD") {/// 安全生产

      } else {/// 未知

      }

    } else if (model.appName == "WORK_ORDER") {///  工单
      workOrderDetail(model);
    } else {/// 未知
      SCToast.showTip('未知错误');
    }
  }

  /// 工单详情
  workOrderDetail(SCToDoModel model) {
    String statusValue = model.statusValue ?? '0';
    int status = int.parse(statusValue.isEmpty ? '0' : statusValue);
    String title = SCUtils.getWorkOrderButtonText(status);
    String url =
        "${SCConfig.BASE_URL}${SCH5.workOrderUrl}?isFromWorkBench=1&status=$status&orderId=${model.id}";
    String realUrl = SCUtils.getWebViewUrl(url: url, title: title, needJointParams: true);
    SCRouterHelper.pathPage(SCRouterPath.webViewPath, {
      "title": model.title ?? '',
      "url": realUrl,
      "needJointParams": false
    })?.then((value) {
      SCScaffoldManager.instance.eventBus.fire({"key" : SCKey.kRefreshWorkBenchPage});
    });
  }

  /// 巡查详情
  patrolDetail(SCToDoModel model) {
    String id = model.taskId ?? '';
    String procInstId = '';
    String nodeId = '';
    if (id.isNotEmpty) {
      if (id.contains('_')) {
        List idList = id.split('_');
        if (idList.length > 1) {
          procInstId = idList[0];
          nodeId = idList[1];
        }
      }
    }
    SCRouterHelper.pathPage(SCRouterPath.patrolDetailPage, {"procInstId": procInstId, "nodeId": nodeId})?.then((value) {
      SCScaffoldManager.instance.eventBus.fire({"key" : SCKey.kRefreshWorkBenchPage});
    });
  }
}