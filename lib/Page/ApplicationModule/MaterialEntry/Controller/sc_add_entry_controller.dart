import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_key.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../Model/sc_entry_type_model.dart';
import '../Model/sc_material_list_model.dart';
import '../Model/sc_wareHouse_model.dart';

/// 新增入库controller

class SCAddEntryController extends GetxController {

  /// 仓库列表数组
  List<SCWareHouseModel> wareHouseList = [];

  /// 入库类型数组
  List<SCEntryTypeModel> entryList = [];

  /// 已选择的物资数据
  List<SCMaterialListModel> selectedList = [];

  /// 是否是编辑
  bool isEdit = false;

  /// 编辑的参数
  Map<String, dynamic> editParams = {};

  /// 仓库名称
  String warehouseName = '';

  /// 仓库id
  String warehouseID = '';

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
      /// 仓库名称
      warehouseName = params['wareHouseName'];
      /// 仓库id
      warehouseID = params['wareHouseId'];
      /// 类型
      type = params['typeName'];
      /// 仓库类型id
      typeID = params['type'];
      /// 备注
      remark = params['remark'];
      for (int i=0; i<wareHouseList.length; i++) {
        SCWareHouseModel model = wareHouseList[i];
        if (model.id == warehouseID) {
          nameIndex = i;
          break;
        }
      }
      for (int i=0; i<entryList.length; i++) {
        SCEntryTypeModel model = entryList[i];
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
      "materials": data['materialList'],
      "remark": data['remark'],
      "status": status,
      "type": data['typeId'],
      "typeName": data['typeName'],
      "wareHouseId": data['wareHouseId'],
      "wareHouseName": data['wareHouseName']
    };
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kAddEntryUrl,
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
        failure: (value) {});
  }

  /// 入库类型
  loadWareHouseType() {
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kWareHouseTypeUrl,
        params: {'dictionaryCode': 'WAREHOUSING'},
        success: (value) {
          SCLoadingUtils.hide();
          entryList = List<SCEntryTypeModel>.from(
              value.map((e) => SCEntryTypeModel.fromJson(e)).toList());
          initEditParams();
          update();
        },
        failure: (value) {});
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
