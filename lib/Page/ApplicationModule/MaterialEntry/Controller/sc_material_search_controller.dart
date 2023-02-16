import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../Model/sc_material_list_model.dart';

/// 物资搜索controller

class SCMaterialSearchController extends GetxController {

  int pageNum = 1;

  List<SCMaterialListModel> dataList = [];

  /// 默认已选的数据
  List<SCMaterialListModel> originalList = [];

  String tips = '';

  /// 搜索内容
  String searchString = '';

  /// 更新搜索内容
  updateSearchString(String value) {
    searchString = value;
    update();
  }

  /// 物资列表数据
  searchData() {
    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: SCUrl.kAllMaterialListUrl,
        params: {'materialName': searchString},
        success: (value) {
          dataList = List<SCMaterialListModel>.from(
              value.map((e) => SCMaterialListModel.fromJson(e)).toList());
          for (SCMaterialListModel model in dataList) {
            for (SCMaterialListModel subModel in originalList) {
              if (model.id == subModel.id) {
                model.localNum = subModel.localNum;
                model.isSelect = true;
              }
            }
          }
          if (dataList.isNotEmpty) {
            tips = '';
          } else {
            tips = '暂无搜索结果';
          }
          SCLoadingUtils.hide();
          update();
        },
        failure: (value) {
          SCLoadingUtils.hide();
        });
  }

}