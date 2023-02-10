import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../Model/sc_material_entry_model.dart';

/// 物资入库controller

class SCMaterialEntryController extends GetxController {

  int pageNum = 1;

  List<SCMaterialEntryModel> dataList = [];

  /// 入库列表数据
  loadEntryListData({bool? isMore}) {
    bool isLoadMore = isMore ?? false;
    if (isLoadMore == true) {
      pageNum++;
    } else {
      SCLoadingUtils.show();
    }
    var params = {
      "conditions": {
        "fields": [{"map": {}, "method": 0, "name": "", "value": {}}],
        "specialMap": {}
      },
      "count": false,
      "last": false,
      "orderBy": [{"asc": true, "field": "gmtModify"}],
      "pageNum": pageNum,
      "pageSize": 20
    };
    print('params===========$params');
    SCHttpManager.instance.post(
        url: SCUrl.kMaterialEntryListUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          print('入库列表数据======================================$value');
          if (value is Map) {
            List list = value['records'];
            if (isLoadMore == true) {
              dataList.addAll(List<SCMaterialEntryModel>.from(
                  list.map((e) => SCMaterialEntryModel.fromJson(e)).toList()));
            } else {
              dataList = List<SCMaterialEntryModel>.from(
                  list.map((e) => SCMaterialEntryModel.fromJson(e)).toList());
            }
          } else {
            if (isLoadMore == false) {
              dataList = [];
            }
          }
          update();
        },
        failure: (value) {
        });
  }

}