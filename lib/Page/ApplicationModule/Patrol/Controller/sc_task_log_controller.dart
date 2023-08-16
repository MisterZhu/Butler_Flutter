
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../Model/sc_task_log_model.dart';

/// 任务日志controller

class SCTaskLogController extends GetxController {

  List<SCTaskLogModel> dataList = [];

  String bizId = '';

  @override
  onInit() {
    super.onInit();
  }

  /// 初始化
  initParams(Map<String, dynamic> params) {
    if (params.isNotEmpty) {
      if (params.containsKey("bizId")) {
        bizId = params['bizId'];
      }
      loadData();
    }
  }

  loadData() {
    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: SCUrl.kPatrolTaskLogUrl,
        params: {'bizId': bizId},
        success: (value) {
          SCLoadingUtils.hide();
          dataList = List<SCTaskLogModel>.from(value.map((e) => SCTaskLogModel.fromJson(e)).toList());
          update();
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }
}