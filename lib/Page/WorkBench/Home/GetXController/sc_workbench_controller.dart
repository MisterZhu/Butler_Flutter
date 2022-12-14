import 'package:get/get.dart';
import 'package:smartcommunity/Network/sc_http_manager.dart';
import 'package:smartcommunity/Network/sc_url.dart';
import 'package:smartcommunity/Page/Login/Home/Model/sc_user_model.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';

/// 工作台Controller

class SCWorkBenchController extends GetxController {

  @override
  onInit(){
    super.onInit();
    getUserInfo();
  }

  /// 获取用户信息
  getUserInfo() {
    if (SCScaffoldManager.instance.isLogin) {
      var params = {
        'id' : SCScaffoldManager.instance.user.id
      };
      SCHttpManager.instance.get(url: SCUrl.kUserInfoUrl, params: params, success: (value){
        String token = SCScaffoldManager.instance.user.token ?? '';
        SCUserModel userModel = SCUserModel.fromJson(value);
        SCScaffoldManager.instance.user = userModel;
        SCScaffoldManager.instance.user.token = token;
        Get.forceAppUpdate();
      });
    }
  }
}