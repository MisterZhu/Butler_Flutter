
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';

/// 任务日志controller

class SCTaskLogController extends GetxController {

  List dataList = ['', '', '', '', '', '', '', '', '',  '', '', '', ''];

  String code = '';

  @override
  onInit() {
    super.onInit();
  }


  /// 初始化
  initParams(Map<String, dynamic> params) {
    if (params.isNotEmpty) {
      if (params.containsKey("code")) {
        code = params['code'];
      }
      loadData();
    }
  }

  loadData() {
    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: SCUrl.kPatrolTaskLogUrl+code,
        params: null,
        success: (value) {
          SCLoadingUtils.hide();
          //List<SCWarningDealResultModel> list = List<SCWarningDealResultModel>.from(value.map((e) => SCWarningDealResultModel.fromJson(e)).toList());

        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }
}