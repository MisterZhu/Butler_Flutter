
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../Model/sc_entry_type_model.dart';
import '../Model/sc_wareHouse_model.dart';


/// 新增入库controller

class SCAddEntryController extends GetxController {

  String wareHouseName = '';
  /// 仓库列表数组
  List<SCWareHouseModel> wareHouseList = [];

  /// 入库类型数组
  List<SCEntryTypeModel> entryList = [];

  @override
  onInit() {
    super.onInit();
    loadWareHouseList();
    loadWareHouseType();
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

}

