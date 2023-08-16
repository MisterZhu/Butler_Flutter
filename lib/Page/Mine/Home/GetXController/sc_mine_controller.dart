
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Network/sc_http_manager.dart';
import 'package:smartcommunity/Page/Mine/Home/Model/sc_community_alert_model.dart';
import 'package:smartcommunity/Page/Mine/Home/Model/sc_community_common_model.dart';
import '../../../../Constants/sc_asset.dart';
import '../../../../Network/sc_url.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';


/// 我的-GetXController

class SCMineController extends GetxController {

  /// 用户头像
  String headPicUrl = SCAsset.iconUserDefault;

  /// 项目列表
  List<SCCommunityAlertModel> communityList = [];

  /// 更换用户头像
  changeUserHeadPic({required String url}) {
    headPicUrl = url;
    update();
  }

  /// 获取项目列表
  loadCommunity({Function(List<SCCommunityCommonModel> list)? success}) {
    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: SCUrl.kCommunityListUrl,
        params: {"tenantId" : (SCScaffoldManager.instance.defaultConfigModel?.tenantId ?? '')},
        success: (value){
          SCLoadingUtils.hide();
          List<SCCommunityCommonModel> titleList = [];
          List<SCCommunityAlertModel> subCommunityList = [];
          for (var map in value) {
            titleList.add(SCCommunityCommonModel.fromJson({"title" : map['name']}));
            subCommunityList.add(SCCommunityAlertModel.fromJson(map));
          }
          communityList = subCommunityList;
          success?.call(titleList);
        },
        failure: (value){
          SCToast.showTip(value['message']);
    });
  }
}