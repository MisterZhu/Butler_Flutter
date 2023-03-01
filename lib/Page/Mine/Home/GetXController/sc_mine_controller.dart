import 'dart:ui';
import 'package:get/get.dart';
import '../../../../Constants/sc_asset.dart';


/// 我的-GetXController

class SCMineController extends GetxController {

  /// 用户头像
  String headPicUrl = SCAsset.iconUserDefault;

  /// 更换用户头像
  changeUserHeadPic({required String url}) {
    headPicUrl = url;
    update();
  }
}