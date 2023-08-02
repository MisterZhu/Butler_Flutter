import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';

import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../../../../Utils/Router/sc_router_helper.dart';
import '../../../../Utils/Router/sc_router_path.dart';
import '../../../ApplicationModule/Patrol/Model/sc_form_data_model.dart';

/// 扫一扫controller
class SCScanController extends GetxController {
  /// 是否开启闪光灯
  bool isOpenFlash = false;

  /// 开启闪光灯
  openFlash({required bool isOpen}) {
    isOpenFlash = isOpen;
    update();
  }

  deviceBasic(var id) {
    SCLoadingUtils.show();
    print("id ======  $id");

    SCHttpManager.instance.get(
        url: SCUrl.deviceBasicUrl+id,
        success: (value) {
          SCLoadingUtils.hide();
          Device device = Device.fromJson(value);
          SCRouterHelper.pathPage(SCRouterPath.patrolPage,
              {"pageType": 2, "deviceCode": device.deviceCode});
        },
        failure: (value) {
          // if (value['message'] != null) {
          //   String message = value['message'];
          //   SCToast.showTip(message);
          // }
        });
  }
}
