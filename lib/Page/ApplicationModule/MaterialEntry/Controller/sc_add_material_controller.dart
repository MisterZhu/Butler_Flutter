
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../Model/sc_material_list_model.dart';

/// 新增物资controller

class SCAddMaterialController extends GetxController {

  String wareHouseName = '';

  List<SCMaterialListModel> materialList = [];

  /// 物资列表数据
  loadMaterialListData() {
    SCHttpManager.instance.get(
        url: SCUrl.kMaterialListUrl,
        params: {'materialName': wareHouseName},
        success: (value) {
          SCLoadingUtils.hide();
          materialList = List<SCMaterialListModel>.from(value.map((e) => SCMaterialListModel.fromJson(e)).toList());
          update();
        },
        failure: (value) {
        });
  }

}
