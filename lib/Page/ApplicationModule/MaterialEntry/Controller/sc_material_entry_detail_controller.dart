
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../Model/sc_material_entry_detail_model.dart';
import '../Model/sc_material_entry_model.dart';

/// 入库详情controller

class SCMaterialEntryDetailController extends GetxController {

  List<SCMaterialEntryModel> dataList = [];

  String wareHouseInId = '';

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
}