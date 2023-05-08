
import 'dart:developer';

import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Constants/sc_enum.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../../PropertyFrmLoss/Model/sc_property_list_model.dart';
import '../Model/sc_material_list_model.dart';

/// 新增物资controller

class SCAddMaterialController extends GetxController {
  int pageNum = 1;

  /// 仓库名称
  String wareHouseName = '';

  /// 仓库ID
  String wareHouseId = '';

  /// 出库类型
  int outType = 0;

  /// 分类ID
  String classifyId = '';

  /// 分类名称
  String classifyName = '';

  /// 是否是编辑
  bool isEdit = false;

  /// 是否隐藏数量输入框
  bool hideNumTextField = false;

  /// 是否是盘点物资
  bool check = false;

  /// 是否是资产
  bool isProperty = false;

  /// 是否是领料
  bool isLL = false;

  /// 部门id
  String orgId = '';

  /// 物资类型，1-入库，2-出库，3-报损，4-调拨，5-盘点
  SCWarehouseManageType materialType = SCWarehouseManageType.entry;

  /// 数据源
  List<SCMaterialListModel> materialList = [];

  /// 默认已选的数据
  List<SCMaterialListModel> originalList = [];

  /// 数据源
  List<SCMaterialListModel> propertyList = [];

  /// 默认已选的数据
  List<SCMaterialListModel> originalPropertyList = [];

  @override
  onInit() {
    super.onInit();
  }

  /// 新增物资-物资列表数据
  loadMaterialListData(
      {bool? isMore, Function(bool success, bool last)? completeHandler}) {
    bool isLoadMore = isMore ?? false;
    if (isLoadMore == true) {
      pageNum++;
    } else {
      pageNum = 1;
      SCLoadingUtils.show();
    }
    var params = {
      "conditions": {
        "classifyId": classifyId,

        /// 分类id
        "deleted": false,
        "enabled": true,
        "fields": [],
        "wareHouseId": wareHouseId,
        "outType": outType,
        /// 仓库ID
      },
      "count": false,
      "last": false,
      "orderBy": [],
    };
    String url = '';
    if (materialType == SCWarehouseManageType.entry) {
      url = SCUrl.kAllMaterialListUrl;
      SCHttpManager.instance.get(
          url: url,
          params: params,
          success: (value) {
            SCLoadingUtils.hide();
            if (isLoadMore == true) {
              materialList.addAll(List<SCMaterialListModel>.from(
                  value.map((e) => SCMaterialListModel.fromJson(e)).toList()));
            } else {
              materialList = List<SCMaterialListModel>.from(
                  value.map((e) => SCMaterialListModel.fromJson(e)).toList());
            }
            for (SCMaterialListModel model in materialList) {
              for (SCMaterialListModel subModel in originalList) {
                if (isEdit) {
                  if (materialType == SCWarehouseManageType.entry) {
                    if (model.id == subModel.materialId) {
                      model.localNum = subModel.localNum;
                      model.isSelect = true;
                      model.materialId = subModel.materialId;
                      model.reportId = subModel.reportId;
                    }
                  } else {
                    if (model.materialId == subModel.materialId) {
                      model.localNum = subModel.localNum;
                      model.isSelect = true;
                      model.materialId = subModel.materialId;
                      model.reportId = subModel.reportId;
                    }
                  }
                } else {
                  if (materialType == SCWarehouseManageType.entry) {
                    if (model.id == subModel.id) {
                      model.localNum = subModel.localNum;
                      model.isSelect = true;
                    }
                  } else {
                    if (model.materialId == subModel.materialId) {
                      model.localNum = subModel.localNum;
                      model.isSelect = true;
                    }
                  }
                }
              }
            }
            update();
            completeHandler?.call(true, true);
          },
          failure: (value) {
            SCToast.showTip(value['message']);
            completeHandler?.call(false, false);
          });
    } else {
      url = SCUrl.kAllOtherMaterialListUrl;
      SCHttpManager.instance.post(
          url: url,
          params: params,
          success: (value) {
            SCLoadingUtils.hide();
            if (isLoadMore == true) {
              materialList.addAll(List<SCMaterialListModel>.from(
                  value.map((e) => SCMaterialListModel.fromJson(e)).toList()));
            } else {
              materialList = List<SCMaterialListModel>.from(
                  value.map((e) => SCMaterialListModel.fromJson(e)).toList());
            }
            for (SCMaterialListModel model in materialList) {
              for (SCMaterialListModel subModel in originalList) {
                if (isEdit) {
                  if (materialType == SCWarehouseManageType.entry) {
                    if (model.id == subModel.materialId) {
                      model.localNum = subModel.localNum;
                      model.isSelect = true;
                      model.materialId = subModel.materialId;
                      model.reportId = subModel.reportId;
                    }
                  } else {
                    if (model.materialId == subModel.materialId) {
                      model.localNum = subModel.localNum;
                      model.isSelect = true;
                      model.materialId = subModel.materialId;
                      model.reportId = subModel.reportId;
                    }
                  }
                } else {
                  if (materialType == SCWarehouseManageType.entry) {
                    if (model.id == subModel.id) {
                      model.localNum = subModel.localNum;
                      model.isSelect = true;
                    }
                  } else {
                    if (model.materialId == subModel.materialId) {
                      model.localNum = subModel.localNum;
                      model.isSelect = true;
                    }
                  }
                }
              }
            }
            update();
            completeHandler?.call(true, true);
          },
          failure: (value) {
            SCToast.showTip(value['message']);
            completeHandler?.call(false, false);
          });
    }
  }

  /// 新增入库-资产列表数据
  loadEntryPropertyListData(
      {bool? isMore, Function(bool success, bool last)? completeHandler}) {
    bool isLoadMore = isMore ?? false;
    if (isLoadMore == true) {
      pageNum++;
    } else {
      pageNum = 1;
      SCLoadingUtils.show();
    }
    var params = {
      "conditions": {
        "classifyId": classifyId,

        /// 分类id
        "deleted": false,
        "enabled": true,
        "fields": [],
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
              if (isEdit) {
                if (model.id == subModel.assetId) {
                  model.isSelect = true;
                }
              } else {
                if (model.id == subModel.id) {
                  model.isSelect = true;
                }
              }
            }
          }
          update();
          completeHandler?.call(false, true);
        },
        failure: (value) {
          SCToast.showTip(value['message']);
          completeHandler?.call(false, false);
        });
  }

  /// 新增资产报损-资产列表数据
  loadPropertyFrmLossListData(
      {Function(bool success, bool last)? completeHandler}) {
    var params = {"fetchOrgId": orgId, "state": 0};
    if (classifyId != '') {
      params.addAll({"classifyId": classifyId});
    }
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kAddFrmLossPropertyListUrl,
        params: params,
        isQuery: true,
        success: (value) {
          SCLoadingUtils.hide();
          propertyList = List<SCMaterialListModel>.from(
              value.map((e) => SCMaterialListModel.fromJson(e)).toList());
          for (SCMaterialListModel model in propertyList) {
            model.materialType = 1;
            model.materialName = model.assetName;
            for (SCMaterialListModel subModel in originalPropertyList) {
              log('bbb===${subModel.toJson()}');
              if (model.id == subModel.assetId) {
                model.isSelect = true;
              }
            }
          }
          update();
          completeHandler?.call(false, true);
        },
        failure: (value) {
          SCToast.showTip(value['message']);
          completeHandler?.call(false, false);
        });
  }

  /// 处理搜索的数据
  dealSearchData(List<SCMaterialListModel> list) {
    for (SCMaterialListModel model in list) {
      for (SCMaterialListModel subModel in materialList) {
        if (model.id == subModel.id) {
          subModel.localNum = model.localNum;
          subModel.isSelect = true;
        }
      }
    }
    update();
  }

  /// 处理搜索的数据
  dealSearchPropertyData(List<SCMaterialListModel> list) {
    for (SCMaterialListModel model in list) {
      for (SCMaterialListModel subModel in propertyList) {
        if (model.id == subModel.id) {
          subModel.isSelect = true;
        }
      }
    }
    update();
  }

  /// 物资分类数据
  loadMaterialSortData() {
    SCHttpManager.instance.post(
        url: SCUrl.kMaterialSortUrl,
        params: null,
        isQuery: isLL ? true : false,
        success: (value) {
          update();
        },
        failure: (value) {
          SCLoadingUtils.hide();
        });
  }
}
