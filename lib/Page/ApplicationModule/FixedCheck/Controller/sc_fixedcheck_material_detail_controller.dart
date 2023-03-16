
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../../MaterialEntry/Model/sc_entry_type_model.dart';
import '../../MaterialEntry/Model/sc_material_list_model.dart';

/// 固定资产盘点-物资详情controller

class SCFixedCheckMaterialDetailController extends GetxController {

  SCMaterialListModel materialModel = SCMaterialListModel();

  /// 报损类型数组
  List<SCEntryTypeModel> typeList = [];

  /// 报损原因数组
  List reasonList = [];

  @override
  onInit() {
    super.onInit();
    loadFrmLossType();
  }

  /// 报损类型
  loadFrmLossType() {
    SCHttpManager.instance.post(
        url: SCUrl.kWareHouseTypeUrl,
        params: {'dictionaryCode': 'REPORTLOSS_TYPE'},
        success: (value) {
          typeList = List<SCEntryTypeModel>.from(
              value.map((e) => SCEntryTypeModel.fromJson(e)).toList());
          reasonList = typeList.map((e) => e.name).toList();
          update();
        },
        failure: (value) {

        });
  }

}