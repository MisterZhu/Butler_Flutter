import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../Model/sc_material_list_model.dart';

/// 新增物资controller

class SCAddMaterialController extends GetxController {

  String wareHouseName = '';

  /// 数据源
  List<SCMaterialListModel> materialList = [];

  /// 默认已选的数据
  List<SCMaterialListModel> originalList = [];

  /// 物资列表数据
  loadMaterialListData() {
    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: SCUrl.kMaterialListUrl,
        params: null,
        success: (value) {
          SCLoadingUtils.hide();
          materialList = List<SCMaterialListModel>.from(
              value.map((e) => SCMaterialListModel.fromJson(e)).toList());
          for (SCMaterialListModel model in materialList) {
            for (SCMaterialListModel subModel in originalList) {
              if (model.id == subModel.id) {
                model.localNum = subModel.localNum;
                model.isSelect = true;
              }
            }
          }
          update();
        },
        failure: (value) {
          SCLoadingUtils.hide();
        });
  }
}
