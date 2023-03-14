import 'dart:developer';

import 'package:date_format/date_format.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_key.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../../PropertyFrmLoss/Model/sc_property_list_model.dart';
import '../Model/sc_entry_type_model.dart';
import '../Model/sc_material_list_model.dart';
import '../Model/sc_material_task_detail_model.dart';
import '../Model/sc_wareHouse_model.dart';

/// 新增入库controller

class SCAddEntryController extends GetxController {
  /// 仓库列表数组
  List<SCWareHouseModel> wareHouseList = [];

  /// 入库类型数组
  List<SCEntryTypeModel> typeList = [];

  /// 物资类型数组
  List materialTypeList = [];

  /// 已选择的物资数据
  List<SCMaterialListModel> selectedList = [];

  /// 已选择的物资数据
  List<SCPropertyListModel> selectedPropertyList = [];

  /// 是否是编辑
  bool isEdit = false;

  /// 编辑的参数
  Map<String, dynamic> editParams = {};

  /// 仓库名称
  String wareHouseName = '';

  /// 仓库id
  String wareHouseId = '';

  /// 仓库index
  int nameIndex = -1;

  /// 类型
  String type = '';

  /// 入库类型id
  int typeID = 0;

  /// 类型index
  int typeIndex = -1;

  /// 备注
  String remark = '';

  /// 主键id
  String editId = '';

  /// 上传的图片文件数组
  List files = [];

  /// 工单id
  String orderId = '';

  /// 是否是归还入库，默认false，只有物资出入库里点击归还才=true
  bool isReturnEntry = false;

  /// 入库日期
  String inDate = '';

  /// 出库单ID
  String outId = '';

  /// 物资类型名称 1：固定资产；2：损耗品
  String materialTypeName = '';

  /// 物资类型 1：固定资产；2：损耗品
  int materialType = -1;

  /// 物资类型index
  int materialTypeIndex = -1;

  /// 采购需求单
  String purchaseId = '';

  /// 是否是资产
  bool isProperty = false;

  @override
  onInit() {
    super.onInit();
    inDate = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);
    materialTypeList = ['固定资产', '易耗品'];
    loadWareHouseList();
    loadWareHouseType();
  }

  /// 初始化编辑的参数
  initEditParams() {
    if (isEdit && editParams.isNotEmpty) {
      Map<String, dynamic> params = editParams;

      /// 仓库名称
      wareHouseName = params['wareHouseName'];

      /// 仓库id
      wareHouseId = params['wareHouseId'];

      /// 类型
      type = params['typeName'];

      /// 仓库类型id
      typeID = params['type'];

      /// 备注
      remark = params['remark'];

      if (params['materialType'] != null) {
        /// 物资类型
        materialType = params['materialType'];
      }

      if (params['purchaseId'] != null) {
        /// 采购需求单
        purchaseId = params['purchaseId'];
      }

      if (params['inDate'] != null) {
        /// 入库日期
        inDate = params['inDate'];
      }

      /// 主键id
      editId = params['id'];
      for (int i = 0; i < wareHouseList.length; i++) {
        SCWareHouseModel model = wareHouseList[i];
        if (model.id == wareHouseId) {
          nameIndex = i;
          break;
        }
      }
      for (int i = 0; i < typeList.length; i++) {
        SCEntryTypeModel model = typeList[i];
        if (model.code == typeID) {
          typeIndex = i;
          break;
        }
      }
    }
  }

  /// 新增入库, status=0暂存，1提交
  addEntry({required int status, required dynamic data}) {
    var params = {
      "files": data['files'],
      "remark": data['remark'],
      "status": status,
      "type": data['typeId'],
      "typeName": data['typeName'],
      "wareHouseId": data['wareHouseId'],
      "wareHouseName": data['wareHouseName'],
      "workOrderId": orderId,
      "outId": outId,
      "inDate": data['inDate'],
    };
    if (data['typeId'] == 1) {
      params.addAll({"purchaseId": data['purchaseId'],});
    }
    if (isProperty == true) {
      params.addAll({"assets": data['assets'],});
    } else {
      params.addAll({"materials": data['materialList'],});
    }
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kAddEntryUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          if (isReturnEntry == true) {
            SCScaffoldManager.instance.eventBus
                .fire({'key': SCKey.kRefreshMaterialRequisitionPage});
          } else {
            SCScaffoldManager.instance.eventBus
                .fire({'key': SCKey.kRefreshMaterialEntryPage});
          }
          SCRouterHelper.back(null);
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }

  /// 编辑入库基础信息
  editMaterialBaseInfo({required dynamic data}) {
    var params = {
      "id": editId,
      "remark": data['remark'],
      "type": data['typeId'],
      "typeName": data['typeName'],
      "wareHouseId": data['wareHouseId'],
      "wareHouseName": data['wareHouseName'],
      "inDate": data['inDate'],
      "status": 0
    };
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kEditAddEntryBaseInfoUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          SCScaffoldManager.instance.eventBus
                .fire({'key': SCKey.kRefreshMaterialEntryPage});
          SCRouterHelper.back(null);
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }

  /// 编辑-新增物资
  editAddMaterial(
      {required List list, Function(bool success)? completeHandler}) {
    var params = {"inId": editId, "materialInRelations": list};
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kEditAddEntryMaterialUrl,
        params: params,
        success: (value) {
          loadMaterialEntryDetail();
        },
        failure: (value) {
          SCLoadingUtils.hide();
        });
  }

  /// 编辑-新增资产
  editAddProperty(
      {required List list, Function(bool success)? completeHandler}) {
    var params = {"inId": editId, "materialInRelations": list};
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kEditAddEntryPropertyUrl,
        params: params,
        success: (value) {
          loadMaterialEntryDetail();
        },
        failure: (value) {
          SCLoadingUtils.hide();
        });
  }

  /// 编辑-删除资产
  editDeleteProperty({required String materialInRelationId,
    Function(bool success)? completeHandler}) {
    var params = {"materialInRelationId": materialInRelationId};
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kEditDeleteEntryPropertyUrl,
        isQuery: true,
        params: params,
        success: (value) {
          loadMaterialEntryDetail();
        },
        failure: (value) {
          SCLoadingUtils.hide();
        });
  }

  /// 编辑-删除物资
  editDeleteMaterial(
      {required String materialInRelationId,
      Function(bool success)? completeHandler}) {
    var params = {"materialInRelationId": materialInRelationId};
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kEditDeleteEntryMaterialUrl,
        isQuery: true,
        params: params,
        success: (value) {
          loadMaterialEntryDetail();
        },
        failure: (value) {
          SCLoadingUtils.hide();
        });
  }

  /// 编辑-编辑物资
  editMaterial({required List list, Function(bool success)? completeHandler}) {
    for (SCMaterialListModel model in list) {
      var params = model.toJson();
      params['num'] = model.localNum;
      params['materialName'] = model.name;
      SCLoadingUtils.show();
      SCHttpManager.instance.post(
          url: SCUrl.kEditEntryMaterialUrl,
          params: params,
          success: (value) {
            loadMaterialEntryDetail();
          },
          failure: (value) {
            SCLoadingUtils.hide();
          });
    }
  }

  /// 仓库列表
  loadWareHouseList() {
    SCHttpManager.instance.get(
        url: SCUrl.kWareHouseListUrl,
        params: null,
        success: (value) {
          SCLoadingUtils.hide();
          wareHouseList = List<SCWareHouseModel>.from(
              value.map((e) => SCWareHouseModel.fromJson(e)).toList());
          if (isReturnEntry == false && wareHouseList.length == 1) {
            SCWareHouseModel model = wareHouseList.first;
            wareHouseId = model.id!;
            wareHouseName = model.name!;
          }
          initEditParams();
          update();
        },
        failure: (value) {
          SCLoadingUtils.hide();
        });
  }

  /// 入库类型
  loadWareHouseType() {
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kWareHouseTypeUrl,
        params: {'dictionaryCode': 'WAREHOUSING'},
        success: (value) {
          SCLoadingUtils.hide();
          typeList = List<SCEntryTypeModel>.from(
              value.map((e) => SCEntryTypeModel.fromJson(e)).toList());
          initEditParams();
          if (isReturnEntry == true) {
            for (int i = 0; i < typeList.length; i++) {
              SCEntryTypeModel typeModel = typeList[i];
              if (typeModel.code == 4) {
                type = typeModel.name ?? '';
              }
            }
          }
          update();
        },
        failure: (value) {
          SCLoadingUtils.hide();
        });
  }

  /// 入库详情
  loadMaterialEntryDetail() {
    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: SCUrl.kMaterialEntryDetailUrl,
        params: {'wareHouseInId': editId},
        success: (value) {
          SCLoadingUtils.hide();
          SCMaterialTaskDetailModel model =
          SCMaterialTaskDetailModel.fromJson(value);
          List<SCMaterialListModel> materials = model.materials ?? [];
          for (SCMaterialListModel subModel in materials) {
            subModel.localNum = subModel.number ?? 1;
            subModel.isSelect = true;
            subModel.name = subModel.materialName ?? '';
          }
          updateSelectedMaterial(materials);
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }

  /// 更新已选的物资数据
  updateSelectedMaterial(List<SCMaterialListModel> list) {
    selectedList = list;
    update();
  }

  /// 更新已选的资产数据
  updateSelectedProperty(List<SCPropertyListModel> list) {
    selectedPropertyList = list;
    update();
  }

  /// 删除物资
  deleteMaterial(int index) {
    if (index < selectedList.length) {
      selectedList.removeAt(index);
      update();
    }
  }

  /// 删除资产
  deleteProperty(int index) {
    if (index < selectedPropertyList.length) {
      selectedPropertyList.removeAt(index);
      update();
    }
  }

  /// 不分页查询物资出库列表
  loadMaterialOutList() {
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kMaterialOutListUrl,
        params: {'outId': outId},
        isQuery: true,
        success: (value) {
          SCLoadingUtils.hide();
          List<SCMaterialListModel> materials = List<SCMaterialListModel>.from(
              value.map((e) => SCMaterialListModel.fromJson(e)).toList());
          for (SCMaterialListModel subModel in materials) {
            subModel.localNum = subModel.number ?? 1;
            subModel.isSelect = true;
            subModel.name = subModel.materialName ?? '';
          }
          updateSelectedMaterial(materials);
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }
}
