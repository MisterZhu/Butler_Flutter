
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sc_uikit/sc_uikit.dart';

import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';

class SCSettingController extends GetxController {

  /// 注销
  logOff() {
    SCLoadingUtils.show();
    SCHttpManager.instance.patch(
      url: SCUrl.kLogOffUrl,
      params: {
        "state": 1,
        "userIds": [SCScaffoldManager.instance.user.id]
      },
      success: (value){
        SCLoadingUtils.hide();
        SCScaffoldManager.instance.logout();
      }, failure: (value){
        SCLoadingUtils.hide();
        SCToast.showTip(value['message']);
    });
  }

}