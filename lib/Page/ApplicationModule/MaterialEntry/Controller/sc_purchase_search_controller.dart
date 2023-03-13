import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../Model/sc_purchase_model.dart';

/// 采购需求单搜索controller

class SCPurchaseSearchController extends GetxController {

  List<SCPurchaseModel> list = [];

  /// 搜索采购单
  searchData({required String text, Function(bool success, bool last)? completeHandler}) {
    var params= {};
    SCHttpManager.instance.post(
        url: SCUrl.kPurchaseSearchUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
        },
        failure: (value) {
          SCToast.showTip(value['message']);
          completeHandler?.call(false, false);
        });
  }

}