
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../Model/sc_entry_type_model.dart';
import '../Model/sc_material_list_model.dart';
import '../Model/sc_wareHouse_model.dart';


/// 新增入库controller

class SCAddEntryController extends GetxController {

  String wareHouseName = '';
  /// 仓库列表数组
  List<SCWareHouseModel> wareHouseList = [];

  /// 入库类型数组
  List<SCEntryTypeModel> entryList = [];

  /// 已选择的物资数据
  List<SCMaterialListModel> selectedList = [];

  @override
  onInit() {
    super.onInit();
    loadWareHouseList();
    loadWareHouseType();
  }


  /// 新增入库, status=0暂存，1提交
  addEntry({required int status}) {
    var params = {
      "materials": [{
        "barCode": "",
        "code": "",
        "locations": "",
        "materialId": "",
        "materialName": "",
        "norms": "",
        "num": 0,
        "referPrice": 0,
        "thirdCode": "",
        "totalPrice": 0,
        "unitId": "",
        "unitName": ""
        }
      ],
      "remark": "",
      "status": status,
      "type": 0,
      "typeName": "",
      "wareHouseId": "",
      "wareHouseName": ""
    };
    print('params===========$params');
    SCHttpManager.instance.post(
        url: SCUrl.kAddEntryUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();

          update();
        },
        failure: (value) {
        });
  }


  /// 仓库列表
  loadWareHouseList() {
    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: SCUrl.kWareHouseListUrl,
        params: {'wareHouseName' : wareHouseName},
        success: (value) {
          SCLoadingUtils.hide();
          wareHouseList = List<SCWareHouseModel>.from(value.map((e) => SCWareHouseModel.fromJson(e)).toList());
          update();
        },
        failure: (value) {
        });
  }


  /// 入库类型
  loadWareHouseType() {
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kWareHouseTypeUrl,
        params: {'dictionaryCode' : 'WAREHOUSING'},
        success: (value) {
          SCLoadingUtils.hide();
          entryList = List<SCEntryTypeModel>.from(value.map((e) => SCEntryTypeModel.fromJson(e)).toList());
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

