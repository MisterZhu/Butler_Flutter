
import 'dart:developer';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
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
    SCHttpManager.instance.get(
        url: SCUrl.kApplicationListUrl,
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
    SCHttpManager.instance.post(
        url: SCUrl.kApplicationListUrl,
        params: {
          "externalId": externalId,
          "externalUserType": externalUserType,
          "tenantId": tenantId,
          "userId": userId
        },
        success: (value) {


        },
        failure: (value) {
          log('appList失败===$value');

        });
  }

}