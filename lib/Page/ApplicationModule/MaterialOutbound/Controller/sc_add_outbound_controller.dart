
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Constants/sc_key.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Utils/Router/sc_router_helper.dart';
import '../../MaterialEntry/Model/sc_entry_type_model.dart';
import '../../MaterialEntry/Model/sc_material_list_model.dart';
import '../../MaterialEntry/Model/sc_wareHouse_model.dart';


/// 新增出库controller

class SCAddOutboundController extends GetxController {

  String wareHouseName = '';

  /// 仓库列表数组
  List<SCWareHouseModel> wareHouseList = [];

  /// 出库类型数组
  List<SCEntryTypeModel> outboundList = [];

  /// 已选择的物资数据
  List<SCMaterialListModel> selectedList = [];

  /// 是否是编辑
  bool isEdit = false;

  /// 编辑的参数
  Map<String, dynamic> editParams = {};

  /// 仓库名称
  String warehouseName = '';

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
      warehouseName = params['wareHouseName'];
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
      for (int i=0; i<wareHouseList.length; i++) {
        SCWareHouseModel model = wareHouseList[i];
        if (model.id == wareHouseId) {
          nameIndex = i;
          break;
        }
      }
      for (int i=0; i<outboundList.length; i++) {
        SCEntryTypeModel model = outboundList[i];
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
      "materials": data['materialList'],
      "remark": data['remark'],
      "status": status,
      "type": data['typeId'],
      "typeName": data['typeName'],
      "wareHouseId": data['wareHouseId'],
      "wareHouseName": data['wareHouseName']
    };
    if (fetchOrgId.isNotEmpty) {
      params.addAll({"fetchOrgId": fetchOrgId});
    }
    if (fetchUserId.isNotEmpty) {
      params.addAll({"fetchUserId": fetchUserId});
    }

    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kAddOutboundUrl,
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
          outboundList = List<SCEntryTypeModel>.from(value.map((e) => SCEntryTypeModel.fromJson(e)).toList());
          initEditParams();
          update();
        },
        failure: (value) {
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

