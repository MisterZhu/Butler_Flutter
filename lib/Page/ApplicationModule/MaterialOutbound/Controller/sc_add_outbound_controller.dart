
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Utils/Router/sc_router_path.dart';
import '../../../../Constants/sc_key.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Utils/Router/sc_router_helper.dart';
import '../../MaterialEntry/Model/sc_entry_type_model.dart';
import '../../MaterialEntry/Model/sc_material_entry_detail_model.dart';
import '../../MaterialEntry/Model/sc_material_list_model.dart';
import '../../MaterialEntry/Model/sc_wareHouse_model.dart';


/// 新增出库controller

class SCAddOutboundController extends GetxController {

  /// 仓库列表数组
  List<SCWareHouseModel> wareHouseList = [];

  /// 出库类型数组
  List<SCEntryTypeModel> typeList = [];

  /// 已选择的物资数据
  List<SCMaterialListModel> selectedList = [];

  /// 是否是编辑
  bool isEdit = false;

  /// 是否是领料
  bool isLL = false;

  /// 领料数据
  Map<String, dynamic> llMap = {};

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

  /// 仓库类型id
  int typeID = 0;

  /// 类型index
  int typeIndex = -1;

  /// 备注
  String remark = '';

  /// 领用人（只有出库类型为领料出库时才传）
  String fetchUserName = '';

  /// 领用人ID（只有出库类型为领料出库时才传）
  String fetchUserId = '';

  /// 领用组织(或部门)（只有出库类型为领料出库时才传）
  String fetchOrgName = '';

  /// 领用组织(或部门)ID（只有出库类型为领料出库时才传）
  String fetchOrgId = '';

  /// 主键id
  String editId = '';

  /// 上传的图片文件数组
  List files = [];

  @override
  onInit() {
    super.onInit();
    loadWareHouseList();
    loadOutboundType();
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
      fetchOrgId = params['fetchOrgId'];
      fetchOrgName = params['fetchOrgName'];
      fetchUserId = params['fetchUserId'];
      fetchUserName = params['fetchUserName'];
      editId = params['id'];
      for (int i=0; i<wareHouseList.length; i++) {
        SCWareHouseModel model = wareHouseList[i];
        if (model.id == wareHouseId) {
          nameIndex = i;
          break;
        }
      }
      for (int i=0; i<typeList.length; i++) {
        SCEntryTypeModel model = typeList[i];
        if (model.code == typeID) {
          typeIndex = i;
          break;
        }
      }
    }
  }

  /// 新增出库, status=0暂存，1提交
  addEntry({required int status, required dynamic data}) {

    var params = {
      "files": data['files'],
      "materials": data['materialList'],
      "remark": data['remark'],
      "status": status,
      "type": data['typeId'],
      "typeName": data['typeName'],
      "wareHouseId": data['wareHouseId'],
      "wareHouseName": data['wareHouseName']
    };
    if (fetchOrgId.isNotEmpty && data['typeName'] == '领料出库') {
      params.addAll({"fetchOrgId": fetchOrgId});
    }
    if (fetchUserId.isNotEmpty && data['typeName'] == '领料出库') {
      params.addAll({"fetchUserId": fetchUserId});
    }
    if (isLL) {
      params.addAll({"workOrderId" : llMap['orderId']});
    }

    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kAddOutboundUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          if (isLL) {
            SCRouterHelper.pathOffPage(SCRouterPath.materialRequisitionPage, null);
          } else {
            SCScaffoldManager.instance.eventBus
                .fire({'key': SCKey.kRefreshMaterialOutboundPage});
            SCRouterHelper.back(null);
          }
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }

  /// 编辑出库基础信息
  editMaterialBaseInfo({required dynamic data}) {
    var params = {
      "id": editId,
      "remark": data['remark'],
      "status": 0,
      "type": data['typeId'],
      "typeName": data['typeName'],
      "wareHouseId": data['wareHouseId'],
      "wareHouseName": data['wareHouseName']
    };
    if (fetchOrgId.isNotEmpty && data['typeName'] == '领料出库') {
      params.addAll({"fetchOrgId": fetchOrgId});
    }
    if (fetchUserId.isNotEmpty && data['typeName'] == '领料出库') {
      params.addAll({"fetchUserId": fetchUserId});
    }
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kEditOutboundBaseInfoUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          SCScaffoldManager.instance.eventBus
              .fire({'key': SCKey.kRefreshMaterialOutboundPage});
          SCRouterHelper.back(null);
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }


  /// 仓库列表
  loadWareHouseList() {
    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: SCUrl.kWareHouseListUrl,
        params: null,
        success: (value) {
          SCLoadingUtils.hide();
          wareHouseList = List<SCWareHouseModel>.from(value.map((e) => SCWareHouseModel.fromJson(e)).toList());
          initEditParams();
          update();
        },
        failure: (value) {
          SCLoadingUtils.hide();
        });
  }

  /// 出库类型
  loadOutboundType() {
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kWareHouseTypeUrl,
        params: {'dictionaryCode' : 'OUTBOUND'},
        success: (value) {
          SCLoadingUtils.hide();
          typeList = List<SCEntryTypeModel>.from(value.map((e) => SCEntryTypeModel.fromJson(e)).toList());
          initEditParams();
          update();
        },
        failure: (value) {
          SCLoadingUtils.hide();
        });
  }


  /// 更新已选的物资数据
  updateSelectedMaterial(List<SCMaterialListModel> list) {
    selectedList = list;
    update();
  }

  /// 删除物资
  deleteMaterial(int index) {
    if (index < selectedList.length) {
      selectedList.removeAt(index);
      update();
    }
  }

  /// 编辑-编辑物资
  editMaterial({required List list, Function(bool success)? completeHandler}) {
    for(SCMaterialListModel model in list) {
      print("物资数据===${model.toJson()}");
      var params = model.toJson();
      params['num'] = model.localNum;
      params['materialName'] = model.materialName;
      SCLoadingUtils.show();
      SCHttpManager.instance.post(
          url: SCUrl.kEditOutEntryUrl,
          params: params,
          success: (value) {
            SCLoadingUtils.hide();
            SCScaffoldManager.instance.eventBus.fire({"key" : SCKey.kRefreshMaterialOutboundPage});
          },
          failure: (value) {
            SCLoadingUtils.hide();
          });
    }
  }

  /// 编辑-新增物资
  editAddMaterial({required List list, Function(bool success)? completeHandler}) {
    var params = {"outId": editId, "materialOutRelations": list};
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kEditOutMaterialUrl,
        params: params,
        success: (value) {
          loadMaterialDetail();
        },
        failure: (value) {
          SCLoadingUtils.hide();
        });
  }

  /// 编辑-删除物资
  editDeleteMaterial({required String materialInRelationId, Function(bool success)? completeHandler}) {
    var params = {"materialOutRelationId": materialInRelationId};
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kEditDeleteOutEntryUrl,
        isQuery: true,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          SCScaffoldManager.instance.eventBus.fire({"key" : SCKey.kRefreshMaterialOutboundPage});
          completeHandler?.call(true);
        },
        failure: (value) {
          SCLoadingUtils.hide();
          completeHandler?.call(false);
        });
  }

  /// 出库详情
  loadMaterialDetail() {
    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: SCUrl.kMaterialOutboundDetailUrl,
        params: {'wareHouseOutId': editId},
        success: (value) {
          SCLoadingUtils.hide();
          SCMaterialEntryDetailModel model = SCMaterialEntryDetailModel.fromJson(value);
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

}

