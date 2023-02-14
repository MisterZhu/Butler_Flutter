
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/Model/sc_material_entry_model.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../Model/sc_material_entry_detail_model.dart';

/// 入库详情controller

class SCMaterialEntryDetailController extends GetxController {

  List<SCMaterialEntryModel> dataList = [];

  String wareHouseInId = '';

  /// 单据状态(0：待提交，1：待审批，2：审批中，3：已拒绝，4：已驳回，5：已撤回，6：已入库)
  int status = 0;

  SCMaterialEntryDetailModel model = SCMaterialEntryDetailModel();

  @override
  onInit() {
    super.onInit();
  }

  /// 入库详情
  loadMaterialEntryDetail() {
    SCHttpManager.instance.get(
        url: SCUrl.kMaterialEntryDetailUrl,
        params: {'wareHouseInId': wareHouseInId},
        success: (value) {
          model = SCMaterialEntryDetailModel.fromJson(value);
          update();
        },
        failure: (value) {});
  }

  /// 出库详情
  loadMaterialOutboundDetail() {
    SCHttpManager.instance.get(
        url: SCUrl.kMaterialOutboundDetailUrl,
        params: {'wareHouseInId': wareHouseInId},
        success: (value) {
          model = SCMaterialEntryDetailModel.fromJson(value);
          update();
        },
        failure: (value) {});
  }
}