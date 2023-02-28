import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/Model/sc_material_entry_model.dart';
import '../../../../Constants/sc_enum.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';

/// 出入库搜索controller

class SCEntrySearchController extends GetxController {

  int pageNum = 1;

  List<SCMaterialEntryModel> dataList = [];

  String tips = '';

  /// 搜索内容
  String searchString = '';

  /// 0入库搜索，1出库搜索
  SCWarehouseManageType type = SCWarehouseManageType.entry;

  /// 更新搜索内容
  updateSearchString(String value) {
    searchString = value;
    update();
  }

  /// 列表数据
  searchData({bool? isMore, Function(bool success, bool last)? completeHandler}) {
    bool isLoadMore = isMore ?? false;
    if (isLoadMore == true) {
      pageNum++;
    } else {
      pageNum = 1;
      SCLoadingUtils.show();
    }
    var params = {
      "conditions": {
        "fields": [{
          "map": {
            "wareHouseName": searchString,
            "operatorName": searchString
          },
          "method": 7,
          "name": "searchs",
          "value": ""
        }],
        "specialMap": {}
      },
      "count": false,
      "last": false,
      "orderBy": [{"asc": false, "field": "gmtModify"}],
      "pageNum": pageNum,
      "pageSize": 20
    };
    String url = SCUrl.kMaterialEntryListUrl;
    if (type == SCWarehouseManageType.outbound) {
      url =  SCUrl.kMaterialOutboundListUrl;
    } else if (type == SCWarehouseManageType.frmLoss) {
      url = SCUrl.kMaterialFrmLossListUrl;
    } else if (type == SCWarehouseManageType.transfer) {
      url = SCUrl.kMaterialTransferListUrl;
    } else if (type == SCWarehouseManageType.check) {
      url = SCUrl.kMaterialCheckListUrl;
    }
    SCHttpManager.instance.post(
        url: url,
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
          if (dataList.isNotEmpty) {
            tips = '';
          } else {
            tips = '暂无搜索结果';
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

}