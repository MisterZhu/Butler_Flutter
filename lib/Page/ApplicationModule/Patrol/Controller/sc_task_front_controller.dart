
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sc_uikit/sc_uikit.dart';

import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../../../WorkBench/Home/Model/sc_todo_model.dart';

/// 工单controller

class SCTaskFrontController extends GetxController {

  List<SCToDoModel> dataList = [];

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
    SCHttpManager.instance.post(
        url: SCUrl.kPatrolFrontPage,
        params: {
          "conditions": {
            "fields": [
              {
                "map": {},
                "method": 0,
                "name": 'procInstId',
                "value": bizId
              }
            ],
            "specialMap": {},
            "specialMap2": {
              "additionalProperties1": {
                "map": {},
                "method": 0,
                "name": "",
                "value": {}
              }
            }
          },
          "count": true,
          "last": true,
          "orderBy": [
            {
              "asc": true,
              "field": ""
            }
          ],
          "pageNum": 1,
          "pageSize": 999
        },
        success: (value) {
          SCLoadingUtils.hide();
          if (value['records'] != null && value['records'].lenth() > 0) {
            List records = value['records'];
            dataList = List<SCToDoModel>.from(records.map((e) => SCToDoModel.fromJson(e)).toList());
          }
          update();
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }
}