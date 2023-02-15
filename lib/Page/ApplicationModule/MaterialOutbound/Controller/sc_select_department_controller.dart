
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../Model/sc_receiver_model.dart';


/// 选择领用部门controller

class SCSelectDepartmentController extends GetxController {

  /// 领用人列表数组
  List<SCReceiverModel> dataList = [];

  @override
  onInit() {
    super.onInit();
    //loadDataList();
  }

  /// 领用部门列表
  loadDataList({Function(bool success)? completeHandler}) {
    var params = {
      "companyId": "",
      "disabled": false,
      "id": 0,
      "orgName": "",
      "orgType": 0,
      "pid": 0,
      "tenantId": "",
      "typeId": 0
    };
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kDepartmentListUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          //dataList = List<SCReceiverModel>.from(value.map((e) => SCReceiverModel.fromJson(e)).toList());
          update();
        },
        failure: (value) {
        });
  }

}

