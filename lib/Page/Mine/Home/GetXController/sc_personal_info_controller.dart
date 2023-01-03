import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:smartcommunity/Network/sc_config.dart';
import 'package:smartcommunity/Network/sc_http_manager.dart';
import 'package:smartcommunity/Network/sc_url.dart';
import 'package:smartcommunity/Page/Mine/Home/Model/sc_headpic_model.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import 'package:smartcommunity/Utils/Upload/sc_upload_utils.dart';

/// 个人资料controller

class SCPersonalInfoController extends GetxController {

  /// 头像
  String userHeadPicUrl = '';

  /// 生日
  String birthday = '';

  @override
  onInit() {
    super.onInit();
    if (SCScaffoldManager.instance.user.headPicUri?.fileKey == null) {
      userHeadPicUrl = '';
    } else {
      userHeadPicUrl = SCConfig.getImageUrl(SCScaffoldManager.instance.user.headPicUri!.fileKey!);
    }
    birthday = SCScaffoldManager.instance.user.birthday ?? '';
  }

  /// 修改用户头像
  changeUserHeadPic({required String url}) {
    userHeadPicUrl = url;
    update();
    Get.forceAppUpdate();
  }

  /// 更新用户头像
  updateUserHeadPic(String path) {
    SCLoadingUtils.show();
    SCUploadUtils.uploadHeadPic(
        imagePath: path,
        successHandler: (value) {
          SCHeadPicModel model = SCHeadPicModel.fromJson(value);
          var params = {
            "id" : SCScaffoldManager.instance.user.id,
            "headPicUri" : model.toJson()
          };
          SCHttpManager.instance.put(url: SCUrl.kModifyUserInfoUrl, params: params, success: (value){
            SCLoadingUtils.hide();
            String headPicUrl = SCConfig.getImageUrl(value["headPicUri"]);
            SCScaffoldManager.instance.user.headPicUri?.fileKey = value["headPicUri"];
            changeUserHeadPic(url: headPicUrl);
          }, failure: (value){
            SCLoadingUtils.hide();
            SCToast.showTip(value['message']);
          });
        },
        failureHandler: (value) {
          SCLoadingUtils.hide();
          SCToast.showTip(value['message']);
        });
  }

  /// 更新用户出生日期
  updateBirthday(String birthdayValue) {
    var params = {
      "id" : SCScaffoldManager.instance.user.id,
      "birthday" : birthdayValue
    };
    SCLoadingUtils.show();
    SCHttpManager.instance.put(url: SCUrl.kModifyUserInfoUrl, params: params, success: (value){
      SCLoadingUtils.hide();
      birthday = birthdayValue;
      SCScaffoldManager.instance.user.birthday = birthdayValue;
      update();
    }, failure: (value){
      SCLoadingUtils.hide();
      SCToast.showTip(value['message']);
    });
  }
}
