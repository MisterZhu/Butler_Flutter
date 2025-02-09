import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/Model/sc_material_entry_model.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../Model/sc_entry_type_model.dart';

/// 物资入库controller

class SCMaterialEntryController extends GetxController {
  int pageNum = 1;

  /// 选中的状态，默认显示全部
  int selectStatusId = -1;

  /// 选中的类型，默认显示全部
  int selectTypeId = -1;

  /// 排序，true操作时间正序，false操作时间倒序
  bool sort = false;

  List<SCMaterialEntryModel> dataList = [];

  /// 入库类型数组
  List<SCEntryTypeModel> typeList = [];

  @override
  onInit() {
    super.onInit();
  }

  /// 选择状态，刷新页面数据
  updateStatus(int value) {
    selectStatusId = value;
    pageNum = 1;

    /// 重新获取数据
    loadData(isMore: false);
  }

  /// 选择类型，刷新页面数据
  updateType(int value) {
    selectTypeId = value;
    pageNum = 1;

    /// 重新获取数据
    loadData(isMore: false);
  }

  /// 更新排序，刷新页面数据
  updateSort(bool value) {
    sort = value;
    pageNum = 1;

    /// 重新获取数据
    loadData(isMore: false);
  }

  /// 入库列表数据
  loadData({bool? isMore, Function(bool success, bool last)? completeHandler}) {
    bool isLoadMore = isMore ?? false;
    if (isLoadMore == true) {
      pageNum++;
    } else {
      pageNum = 1;
      SCLoadingUtils.show();
    }
    List fields = [];
    if (selectTypeId >= 0) {
      var dic = {"map": {}, "method": 1, "name": "type", "value": selectTypeId};
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
      "conditions": {"fields": fields, "specialMap": {}},
      "count": false,
      "last": false,
      "orderBy": [
        {"asc": sort, "field": "gmtModify"}
      ],
      "pageNum": pageNum,
      "pageSize": 20
    };
    SCHttpManager.instance.post(
        url: SCUrl.kMaterialEntryListUrl,
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
          bool last = false;
          if (isLoadMore) {
            last = value['last'];
          }
          completeHandler?.call(true, last);
        },
        failure: (value) {
          if (isLoadMore) {
            pageNum--;
          }
          SCToast.showTip(value['message']);
          completeHandler?.call(false, false);
        });
  }

  /// 入库类型
  loadWareHouseType(Function? resultHandler) {
    SCHttpManager.instance.post(
        url: SCUrl.kWareHouseTypeUrl,
        params: {'dictionaryCode': 'WAREHOUSING'},
        success: (value) {
          typeList = List<SCEntryTypeModel>.from(
              value.map((e) => SCEntryTypeModel.fromJson(e)).toList());
          update();
          resultHandler?.call();
        },
        failure: (value) {});
  }

  /// 提交入库
  submit({required String id, Function(bool success)? completeHandler}) async {
    var params = {
      "wareHouseInId": id,
    };
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        isQuery: true,
        url: SCUrl.kSubmitMaterialUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          completeHandler?.call(true);
        },
        failure: (value) {
          completeHandler?.call(false);
          SCToast.showTip(value['message']);
        });
  }
}
