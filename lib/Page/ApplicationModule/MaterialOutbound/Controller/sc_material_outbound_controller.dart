import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../../MaterialEntry/Model/sc_entry_type_model.dart';
import '../../MaterialEntry/Model/sc_material_entry_model.dart';

/// 物资出库controller

class SCMaterialOutboundController extends GetxController {

  int pageNum = 1;


  /// 选中的状态，默认显示全部
  int selectStatusId = -1;

  /// 选中的类型，默认显示全部
  int selectTypeId = -1;

  /// 排序，true操作时间正序，false操作时间倒序
  bool sort = true;

  List<SCMaterialEntryModel> dataList = [];

  /// 出库类型数组
  List<SCEntryTypeModel> outboundList = [];

  @override
  onInit() {
    super.onInit();
  }

  /// 选择状态，刷新页面数据
  updateStatus(int value) {
    selectStatusId = value;
    pageNum = 1;
    /// 重新获取数据
    loadOutboundListData(isMore: false);
  }

  /// 选择类型，刷新页面数据
  updateType(int value) {
    selectTypeId = value;
    pageNum = 1;
    /// 重新获取数据
    loadOutboundListData(isMore: false);
  }

  /// 更新排序，刷新页面数据
  updateSort(bool value) {
    sort = value;
    pageNum = 1;
    /// 重新获取数据
    loadOutboundListData(isMore: false);
  }

  /// 出库列表数据
  loadOutboundListData({bool? isMore}) {
    bool isLoadMore = isMore ?? false;
    if (isLoadMore == true) {
      pageNum++;
    } else {
      SCLoadingUtils.show();
    }
    List fields = [];
    if (selectTypeId >= 0) {
      var dic = {
        "map": {},
        "method": 1,
        "name": "type",
        "value": selectTypeId
      };
      fields.add(dic);
    }
    if (selectStatusId >= 0) {
      var dic = {
        "map": {},
        "method": 1,
        "name": "status",
        "value": selectStatusId
      };
      fields.add(dic);
    }
    var params = {
      "conditions": {
        "fields": fields,
        "specialMap": {}
      },
      "count": false,
      "last": false,
      "orderBy": [{"asc": sort, "field": "gmtModify"}],
      "pageNum": pageNum,
      "pageSize": 20
    };
    print('params===========$params');
    SCHttpManager.instance.post(
        url: SCUrl.kMaterialOutboundListUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
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

  /// 出库类型
  loadOutboundType(Function? resultHandler) {
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kWareHouseTypeUrl,
        params: {'dictionaryCode' : 'OUTBOUND'},
        success: (value) {
          SCLoadingUtils.hide();
          print('出库类型======================================$value');
          outboundList = List<SCEntryTypeModel>.from(value.map((e) => SCEntryTypeModel.fromJson(e)).toList());
          update();
          resultHandler?.call();
        },
        failure: (value) {
          print('出库类型=====================================$value');
        });
  }

}