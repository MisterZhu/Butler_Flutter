import 'dart:developer';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_key.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../../MaterialEntry/Model/sc_entry_type_model.dart';
import '../../MaterialEntry/Model/sc_material_list_model.dart';
import '../../MaterialEntry/Model/sc_material_task_detail_model.dart';
import '../../MaterialEntry/Model/sc_wareHouse_model.dart';


/// 新增调拨controller

class SCAddTransferController extends GetxController {
  /// 调入仓库列表数组
  List<SCWareHouseModel> inWareHouseList = [];

  /// 调出仓库列表数组
  List<SCWareHouseModel> outWareHouseList = [];

  /// 类型数组
  List<SCEntryTypeModel> typeList = [];

  /// 已选择的物资数据
  List<SCMaterialListModel> selectedList = [];

  /// 是否是编辑
  bool isEdit = false;

  /// 编辑的参数
  Map<String, dynamic> editParams = {};

  /// 调入仓库名称
  String inWareHouseName = '';

  /// 调入仓库id
  String inWareHouseId = '';

  /// 调入仓库index
  int inNameIndex = -1;

  /// 调出仓库名称
  String outWareHouseName = '';

  /// 调出仓库id
  String outWareHouseId = '';

  /// 调出仓库index
  int outNameIndex = -1;

  /// 类型
  String type = '';

  /// 仓库类型id
  int typeID = 0;

  /// 类型index
  int typeIndex = -1;

  /// 备注
  String remark = '';

  /// 主键id
  String editId = '';

  /// 上传的图片文件数组
  List files = [];

  @override
  onInit() {
    super.onInit();
    loadInWareHouseList();
    loadOutWareHouseList();
    loadTransferType();
  }

  /// 初始化编辑的参数
  initEditParams() {
    if (isEdit && editParams.isNotEmpty) {
      Map<String, dynamic> params = editParams;

      /// 调入仓库名称
      inWareHouseName = params['inWareHouseName'];

      /// 调入仓库id
      inWareHouseId = params['inWareHouseId'];

      /// 调出仓库名称
      outWareHouseName = params['outWareHouseName'];

      /// 调出仓库id
      outWareHouseId = params['outWareHouseId'];

      /// 类型
      type = params['typeName'];

      /// 类型id
      typeID = params['type'];

      /// 备注
      remark = params['remark'];

      /// 主键id
      editId = params['id'];
      for (int i = 0; i < inWareHouseList.length; i++) {
        SCWareHouseModel model = inWareHouseList[i];
        if (model.id == inWareHouseId) {
          inNameIndex = i;
          break;
        }
      }
      for (int i = 0; i < outWareHouseList.length; i++) {
        SCWareHouseModel model = outWareHouseList[i];
        if (model.id == outWareHouseId) {
          outNameIndex = i;
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

  /// 新增调拨, status=0暂存，1提交
  addTransfer({required int status, required dynamic data}) {
    var params = {
      "files": data['files'],
      "materials": data['materialList'],
      "remark": data['remark'],
      "status": status,
      "type": data['typeId'],
      "typeName": data['typeName'],
      "inWareHouseId": data['inWareHouseId'],
      "inWareHouseName": data['inWareHouseName'],
      "outWareHouseId": data['outWareHouseId'],
      "outWareHouseName": data['outWareHouseName']
    };
    SCLoadingUtils.show();
    log("调拨参数===$params");
    SCHttpManager.instance.post(
        url: SCUrl.kAddTransferUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          SCScaffoldManager.instance.eventBus
              .fire({'key': SCKey.kRefreshMaterialTransferPage});
          SCRouterHelper.back(null);
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }

  /// 编辑入库基础信息
  editMaterialBaseInfo({required dynamic data}) {
    //List materialList = data['materialList'];
    var params = {
      "id": editId,
      "remark": data['remark'],
      "type": data['typeId'],
      "typeName": data['typeName'],
      "inWareHouseId": data['inWareHouseId'],
      "inWareHouseName": data['inWareHouseName'],
      "outWareHouseId": data['outWareHouseId'],
      "outWareHouseName": data['outWareHouseName'],
      "status": 0
    };
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kEditTransferBaseInfoUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          SCScaffoldManager.instance.eventBus
              .fire({'key': SCKey.kRefreshMaterialTransferPage});
          SCRouterHelper.back(null);
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }

  /// 编辑-新增物资
  editAddMaterial({required List list, Function(bool success)? completeHandler}) {
    print("入库物资===${list}");
    var params = {"changeId": editId, "materialChangeRelations": list};
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kEditAddTransferMaterialUrl,
        params: params,
        success: (value) {
          loadMaterialTransferDetail();
        },
        failure: (value) {
          SCLoadingUtils.hide();
          completeHandler?.call(false);
        });
  }

  /// 编辑-删除物资
  editDeleteMaterial({required String materialInRelationId, Function(bool success)? completeHandler}) {
    var params = {"materialChangeRelationId": materialInRelationId};
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kEditDeleteTransferMaterialUrl,
        isQuery: true,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          completeHandler?.call(true);
        },
        failure: (value) {
          SCLoadingUtils.hide();
          completeHandler?.call(false);
        });
  }

  /// 编辑-编辑物资
  editMaterial({required List list, Function(bool success)? completeHandler}) {
    for(SCMaterialListModel model in list) {
      print("物资数据===${model.toJson()}");
      var params = model.toJson();
      params['num'] = model.localNum;
      SCLoadingUtils.show();
      SCHttpManager.instance.post(
          url: SCUrl.kEditTransferMaterialUrl,
          params: params,
          success: (value) {
            SCLoadingUtils.hide();
            print("编辑成功");
          },
          failure: (value) {
            SCLoadingUtils.hide();
            print("编辑失败");
          });
    }
  }

  /// 调入仓库列表，跟入库、出库仓库接口一样
  loadInWareHouseList() {
    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: SCUrl.kWareHouseListUrl,
        params: null,
        success: (value) {
          SCLoadingUtils.hide();
          inWareHouseList = List<SCWareHouseModel>.from(
              value.map((e) => SCWareHouseModel.fromJson(e)).toList());
          if (inWareHouseList.length == 1) {
            SCWareHouseModel model = inWareHouseList.first;
            inWareHouseId = model.id!;
            inWareHouseName = model.name!;
          }
          initEditParams();
          update();
        },
        failure: (value) {
          SCLoadingUtils.hide();
        });
  }

  /// 调出仓库列表
  loadOutWareHouseList() {
    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: SCUrl.kAllWareHouseListUrl,
        params: null,
        success: (value) {
          SCLoadingUtils.hide();
          outWareHouseList = List<SCWareHouseModel>.from(
              value.map((e) => SCWareHouseModel.fromJson(e)).toList());
          if (outWareHouseList.length == 1) {
            SCWareHouseModel model = outWareHouseList.first;
            outWareHouseId = model.id!;
            outWareHouseName = model.name!;
          }
          initEditParams();
          update();
        },
        failure: (value) {
          SCLoadingUtils.hide();
        });
  }

  /// 调拨类型
  loadTransferType() {
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kWareHouseTypeUrl,
        params: {'dictionaryCode': 'TRANSFER_TYPE'},
        success: (value) {
          SCLoadingUtils.hide();
          typeList = List<SCEntryTypeModel>.from(
              value.map((e) => SCEntryTypeModel.fromJson(e)).toList());
          initEditParams();
          update();
        },
        failure: (value) {
          SCLoadingUtils.hide();
        });
  }

  /// 调拨详情
  loadMaterialTransferDetail() {
    SCHttpManager.instance.get(
        url: SCUrl.kMaterialTransferDetailUrl,
        params: {'id': editId},
        success: (value) {
          SCLoadingUtils.hide();
          SCMaterialTaskDetailModel model = SCMaterialTaskDetailModel.fromJson(value);
          List<SCMaterialListModel> materials = model.materials ?? [];
          for (SCMaterialListModel subModel in materials) {
            subModel.localNum = subModel.number ?? 1;
            subModel.isSelect = true;
            subModel.name = subModel.materialName ?? '';
          }
          updateSelectedMaterial(materials);
          update();
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

  /// 删除物资
  deleteMaterial(int index) {
    if (index < selectedList.length) {
      selectedList.removeAt(index);
      update();
    }
  }
}
