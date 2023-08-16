import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/Model/sc_material_entry_model.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../../MaterialEntry/Model/sc_entry_type_model.dart';

/// 领料物资出入库controller

class SCMaterialRequisitionController extends GetxController {
  int pageNum = 1;

  /// 选中的状态，默认显示全部
  int selectStatusId = -1;

  /// 排序，true操作时间正序，false操作时间倒序
  bool sort = false;

  List<SCMaterialEntryModel> dataList = [];

  /// 分类index
  int categoryIndex = 0;

  List statusList = [];

  /// 工单id
  String orderId = '';

  @override
  onInit() {
    super.onInit();
    statusList = [
      {'name': '全部', 'code': -1},
      {'name': '待提交', 'code': 0},
      {'name': '待审批', 'code': 1},
      {'name': '审批中', 'code': 2},
      {'name': '已拒绝', 'code': 3},
      {'name': '已驳回', 'code': 4},
      {'name': '已撤回', 'code': 5},
      {'name': '已通过', 'code': 6},
      {'name': '已出库', 'code': 7},
    ];
  }

  updateCategoryIndex(int value) {
    categoryIndex = value;
    selectStatusId = -1;
    if (categoryIndex == 0) {
      statusList = [
        {'name': '全部', 'code': -1},
        {'name': '待提交', 'code': 0},
        {'name': '待审批', 'code': 1},
        {'name': '审批中', 'code': 2},
        {'name': '已拒绝', 'code': 3},
        {'name': '已驳回', 'code': 4},
        {'name': '已撤回', 'code': 5},
        {'name': '已通过', 'code': 6},
        {'name': '已出库', 'code': 7},
      ];
      loadOutboundData(isMore: false);
    } else {
      statusList = [
        {'name': '全部', 'code': -1},
        {'name': '待提交', 'code': 0},
        {'name': '待审批', 'code': 1},
        {'name': '审批中', 'code': 2},
        {'name': '已拒绝', 'code': 3},
        {'name': '已驳回', 'code': 4},
        {'name': '已撤回', 'code': 5},
        {'name': '已入库', 'code': 6},
      ];
      loadEntryData(isMore: false);
    }
  }

  /// 选择状态，刷新页面数据
  updateStatus(int value) {
    selectStatusId = value;
    pageNum = 1;
    /// 重新获取数据
    if (categoryIndex == 0) {
      loadOutboundData(isMore: false);
    } else {
      loadEntryData(isMore: false);
    }
  }

  /// 更新排序，刷新页面数据
  updateSort(bool value) {
    sort = value;
    pageNum = 1;

    /// 重新获取数据
    if (categoryIndex == 0) {
      loadOutboundData(isMore: false);
    } else {
      loadEntryData(isMore: false);
    }
  }

  /// 物资归还入库列表数据
  loadEntryData({bool? isMore, Function(bool success, bool last)? completeHandler}) {
    bool isLoadMore = isMore ?? false;
    if (isLoadMore == true) {
      pageNum++;
    } else {
      pageNum = 1;
      SCLoadingUtils.show();
    }
    List fields = [];
    var dic = {
        "map": {},
        "method": 1,
        "name": "type",
        "value": 4
    };
    fields.add(dic);
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
          SCLoadingUtils.hide();
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


  /// 出库列表数据
  loadOutboundData({bool? isMore, Function(bool success, bool last)? completeHandler}) {
    bool isLoadMore = isMore ?? false;
    if (isLoadMore == true) {
      pageNum++;
    } else {
      pageNum = 1;
      SCLoadingUtils.show();
    }
    List fields = [];
    var dic = {
        "map": {},
        "method": 1,
        "name": "type",
        "value": 1
    };
    fields.add(dic);
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
