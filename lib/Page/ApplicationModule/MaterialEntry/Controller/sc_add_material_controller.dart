
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../Model/sc_material_list_model.dart';

/// 新增物资controller

class SCAddMaterialController extends GetxController {

  int pageNum = 1;

  List<SCMaterialListModel> materialList = [];

  /// 物资列表数据
  loadMaterialListData({bool? isMore}) {
    bool isLoadMore = isMore ?? false;
    if (isLoadMore == true) {
      pageNum++;
    } else {
      SCLoadingUtils.show();
    }
    var params = {
      "conditions": {
        "fields": [
          {"map": {}, "method": 0, "name": "", "value": {}}],
        "specialMap": {}
      },
      "count": false,
      "last": false,
      "orderBy": [],
      "pageNum": pageNum,
      "pageSize": 20
    };
    print('params===========$params');
    SCHttpManager.instance.post(
        url: SCUrl.kMaterialListUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          print('物资列表数据======================================$value');
          if (value is Map) {
            List list = value['records'];
            if (isLoadMore == true) {
              materialList.addAll(List<SCMaterialListModel>.from(
                  list.map((e) => SCMaterialListModel.fromJson(e)).toList()));
            } else {
              materialList = List<SCMaterialListModel>.from(
                  list.map((e) => SCMaterialListModel.fromJson(e)).toList());
            }
          } else {
            if (isLoadMore == false) {
              materialList = [];
            }
          }
          update();
        },
        failure: (value) {
        });
  }

}
