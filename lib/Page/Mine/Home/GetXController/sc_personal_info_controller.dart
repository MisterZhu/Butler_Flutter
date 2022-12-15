import 'package:get/get.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';


/// 个人资料controller

class SCPersonalInfoController extends GetxController {
  String userHeadPicUrl = SCAsset.iconUserDefault;
  
  /// 修改用户头像
  changeUserHeadPic({required String url}) {
    userHeadPicUrl = url;
    update();
  }
}