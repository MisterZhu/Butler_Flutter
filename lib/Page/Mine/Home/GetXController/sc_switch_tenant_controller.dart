
import 'dart:developer';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/Login/Home/Model/sc_user_model.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Utils/Router/sc_router_helper.dart';
import '../Model/sc_tenant_list_model.dart';

class SCSwitchTenantController extends GetxController {

  List<SCTenantListModel> dataList = [];

  /// 外部用户ID 比如微信小程序端的openId
  String externalId = '';

  /// 外部用户类型  1:微信; 2:支付宝
  String externalUserType = '1';

  /// 要切换至的用户ID
  String userId = '';

  /// 要切换至的租户ID
  String tenantId = '';

  @override
  onInit() {
    super.onInit();

  }

  /// 获取租户列表数据
  loadTenantListData() {
    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: SCUrl.kSwitchTenantUrl,
        params: null,
        success: (value) {
          dataList = List<SCTenantListModel>.from(value.map((e) => SCTenantListModel.fromJson(e)).toList());
          update();
        },
        failure: (value) {
          log('appList失败===$value');

        });
  }

  /// 切换租户
  switchTenant() {
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kSwitchTenantUrl,
        params: {
          "tenantId": tenantId,
          "userId": userId
        },
        success: (value) {
          SCUserModel model = SCUserModel.fromJson(value['userInfoV']);
          SCScaffoldManager.instance.user = model;
          SCRouterHelper.back(null);
          Get.forceAppUpdate();
        },
        failure: (value) {
          if (value['message'] != null) {
            String message = value['message'];
            SCToast.showTip(message);
          }
        });
  }

}