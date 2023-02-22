import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_key.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../../MaterialEntry/Model/sc_entry_type_model.dart';
import '../../MaterialEntry/Model/sc_material_list_model.dart';
import '../../MaterialEntry/Model/sc_wareHouse_model.dart';


/// 新增调拨controller

class SCAddTransferController extends GetxController {
  /// 仓库列表数组
  List<SCWareHouseModel> wareHouseList = [];

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

  @override
  onInit() {
    super.onInit();
    loadWareHouseList();
    loadWareHouseType();
  }

  /// 初始化编辑的参数
  initEditParams() {
    if (isEdit && editParams.isNotEmpty) {
      Map<String, dynamic> params = editParams;

      /// 调入仓库名称
      inWareHouseName = params['inWareHouseName'];

      /// 调入仓库id
      inWareHouseId = params['inWarehouseId'];

      /// 调出仓库名称
      outWareHouseName = params['outWarehouseName'];

      /// 调出仓库id
      outWareHouseId = params['outWarehouseId'];

      /// 类型
      type = params['typeName'];

      /// 类型id
      typeID = params['type'];

      /// 备注
      remark = params['remark'];

      /// 主键id
      editId = params['id'];
      for (int i = 0; i < wareHouseList.length; i++) {
        SCWareHouseModel model = wareHouseList[i];
        if (model.id == inWareHouseId) {
          inNameIndex = i;
          break;
        }
      }
      for (int i = 0; i < wareHouseList.length; i++) {
        SCWareHouseModel model = wareHouseList[i];
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
    SCHttpManager.instance.post(
        url: SCUrl.kAddEntryUrl,
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
    List materialList = data['materialList'];
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
        url: SCUrl.kEditAddEntryBaseInfoUrl,
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
    var params = {"inId": editId, "materialInRelations": list};
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kEditAddEntryMaterialUrl,
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

  /// 编辑-删除物资
  editDeleteMaterial({required String materialInRelationId, Function(bool success)? completeHandler}) {
    var params = {"materialInRelationId": materialInRelationId};
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kEditDeleteEntryMaterialUrl,
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
      params['materialName'] = model.name;
      SCLoadingUtils.show();
      SCHttpManager.instance.post(
          url: SCUrl.kEditEntryMaterialUrl,
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

  /// 仓库列表
  loadWareHouseList() {
    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: SCUrl.kWareHouseListUrl,
        params: null,
        success: (value) {
          SCLoadingUtils.hide();
          wareHouseList = List<SCWareHouseModel>.from(
              value.map((e) => SCWareHouseModel.fromJson(e)).toList());
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
}
