
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../Model/sc_receiver_model.dart';


/// 选择领用人controller

class SCSelectReceiverController extends GetxController {

  int pageNum = 1;

  /// 领用人列表数组
  List<SCReceiverModel> dataList = [];

  @override
  onInit() {
    super.onInit();
    loadDataList();
  }

  /// 领用人列表
  loadDataList({bool? isMore, Function(bool success, bool last)? completeHandler}) {
    bool isLoadMore = isMore ?? false;
    if (isLoadMore == true) {
      pageNum++;
    } else {
      pageNum = 1;
      SCLoadingUtils.show();
    }
    var params = {
      "conditions": {
        "categoryId": "",
        "orgIds": [],
        "symbol": "",
        "tenantId": ""
      },
      "count": true,
      "last": true,
      "orderBy": [
        {
        "asc": true,
        "field": ""
        }],
      "pageNum": pageNum,
      "pageSize": 20
    };
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kReceiverListUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          dataList = List<SCReceiverModel>.from(value.map((e) => SCReceiverModel.fromJson(e)).toList());
          update();
        },
        failure: (value) {
        });
  }

}

