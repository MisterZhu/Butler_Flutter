import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Constants/sc_enum.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../../PropertyFrmLoss/Model/sc_property_list_model.dart';
import '../Model/sc_material_list_model.dart';

/// 物资搜索controller

class SCMaterialSearchController extends GetxController {

  int pageNum = 1;

  List<SCMaterialListModel> materialList = [];

  /// 默认已选的数据
  List<SCMaterialListModel> originalList = [];

  List<SCMaterialListModel> propertyList = [];

  /// 默认已选的数据
  List<SCMaterialListModel> originalPropertyList = [];


  String tips = '';

  /// 搜索内容
  String searchString = '';

  /// 仓库id
  String wareHouseId = '';

  /// 页面类型
  SCWarehouseManageType type = SCWarehouseManageType.entry;

  /// 是否隐藏数量输入框
  bool hideNumTextField = false;

  /// 是否是资产
  bool isProperty = false;

  String orgId = '';

  /// 更新搜索内容
  updateSearchString(String value) {
    searchString = value;
    update();
  }

  /// 搜索物资列表数据
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
        "deleted": false,
        "enabled": true,
        "fields": [],
        "wareHouseId": wareHouseId,  /// 仓库ID
        "materialName": searchString  /// 物资名称
      },
      "count": false,
      "last": false,
      "orderBy": [],
      "pageNum": pageNum,
      "pageSize": 20
    };
    SCHttpManager.instance.post(
        url: type == SCWarehouseManageType.entry ? SCUrl.kMaterialListUrl : SCUrl.kOtherMaterialListUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          List list = value['records'];
          if (isLoadMore == true) {
            materialList.addAll(List<SCMaterialListModel>.from(
                list.map((e) => SCMaterialListModel.fromJson(e)).toList()));
          } else {
            materialList = List<SCMaterialListModel>.from(
                list.map((e) => SCMaterialListModel.fromJson(e)).toList());
          }
          for (SCMaterialListModel model in materialList) {
            for (SCMaterialListModel subModel in originalList) {
              if (model.id == subModel.id) {
                model.localNum = subModel.localNum;
                model.isSelect = true;
              }
            }
          }
          if (materialList.isNotEmpty) {
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

  /// 新增入库搜索资产列表数据
  searchAddEntryPropertyData({bool? isMore, Function(bool success, bool last)? completeHandler}) {
    bool isLoadMore = isMore ?? false;
    if (isLoadMore == true) {
      pageNum++;
    } else {
      pageNum = 1;
      SCLoadingUtils.show();
    }
    var params = {
      "conditions": {
        "deleted": false,
        "enabled": true,
        "fields": [],
        "assetName": searchString  /// 物资名称
      },
      "count": false,
      "last": false,
      "orderBy": [],
      "pageNum": pageNum,
      "pageSize": 20
    };
    SCHttpManager.instance.post(
        url: SCUrl.kAddEntryPropertyListUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          if ((value['records'] is List) == false) {
            bool last = false;
            if (isLoadMore) {
              last = value['last'];
            }
            completeHandler?.call(false, last);
            update();
            return;
          }
          List list = value['records'];
          if (isLoadMore == true) {
            propertyList.addAll(List<SCMaterialListModel>.from(
                list.map((e) => SCMaterialListModel.fromJson(e)).toList()));
          } else {
            propertyList = List<SCMaterialListModel>.from(
                list.map((e) => SCMaterialListModel.fromJson(e)).toList());
          }
          for (SCMaterialListModel model in propertyList) {
            model.materialType = 1;
            model.materialName = model.assetName;
            model.assetId = model.id;
            for (SCMaterialListModel subModel in originalPropertyList) {
              if (model.id == subModel.id) {
                model.isSelect = true;
              }
            }
          }
          if (materialList.isNotEmpty) {
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


  /// 搜索资产报损资产列表数据
  searchPropertyData({bool? isMore, Function(bool success, bool last)? completeHandler}) {
    bool isLoadMore = isMore ?? false;
    if (isLoadMore == true) {
      pageNum++;
    } else {
      pageNum = 1;
      SCLoadingUtils.show();
    }
    var params = {"fetchOrgId": orgId, "assetName": searchString, "state": 0};
    SCHttpManager.instance.post(
        url: SCUrl.kAddFrmLossPropertyListUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          if (isLoadMore == true) {
            propertyList.addAll(List<SCMaterialListModel>.from(
                value.map((e) => SCMaterialListModel.fromJson(e)).toList()));
          } else {
            propertyList = List<SCMaterialListModel>.from(
                value.map((e) => SCMaterialListModel.fromJson(e)).toList());
          }
          for (SCMaterialListModel model in propertyList) {
            model.materialType = 1;
            model.materialName = model.assetName;
            for (SCMaterialListModel subModel in originalPropertyList) {
              if (model.id == subModel.assetId) {
                model.isSelect = true;
              }
            }
          }
          if (propertyList.isNotEmpty) {
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