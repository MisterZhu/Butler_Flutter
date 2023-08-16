import 'package:get/get.dart';

import '../Model/sc_material_list_model.dart';

/// 采购单-选择物资controller

class SCPurchaseSelectMaterialController extends GetxController {
  /// 所有物资
  List<SCMaterialListModel> allMaterialList = [];

  /// 选择的物资列表
  List<SCMaterialListModel> selectMaterialList = [];

  /// 初始化数据
  initData() {
    for (SCMaterialListModel model in allMaterialList) {
      if (selectMaterialList.isNotEmpty) {
        for (SCMaterialListModel subModel in selectMaterialList) {
          model.isSelect = (model.materialId ==  subModel.materialId);
        }
      } else {
        model.isSelect = false;
      }
    }
  }
}