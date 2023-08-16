import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_key.dart';
import '../../../Network/sc_http_manager.dart';
import '../../../Network/sc_url.dart';
import '../../../Skin/Tools/sc_scaffold_manager.dart';
import '../Model/sc_message_card_model.dart';

class SCHandleMessageController extends GetxController {
  dynamic taskMsg = null;
  String content = '';

  @override
  onInit() {
    super.onInit();
  }

  /// 初始化
  initParams(Map<String, dynamic> params) {
    print("params2222===>$params");
    if (params.isNotEmpty) {
      print("params23=1===>$params");
      print("params23=2===>$params.content");
      // if (params.containsKey("pageType")) {
      //   pageType = params['pageType'];
      //   if (pageType == 1) {
      //     // 品质督查
      //     appCode = "QUALITY_REGULATION";
      //   } else if (pageType == 2) {
      //     // 巡检
      //     appCode = "POLICED_DEVICE";
      //     if (params.containsKey("deviceCode")) {
      //       deviceCode = params['deviceCode'];
      //     }
      //   } else if (pageType == 3) {
      //     appCode = "POLICED_WATCH";
      //   }
    }
  }
}
