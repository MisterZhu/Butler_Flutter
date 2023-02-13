
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../../MaterialEntry/Model/sc_entry_type_model.dart';
import '../../MaterialEntry/Model/sc_wareHouse_model.dart';


/// 新增出库controller

class SCAddOutboundController extends GetxController {

  String wareHouseName = '';

  /// 仓库列表数组
  List<SCWareHouseModel> wareHouseList = [];

  /// 出库类型数组
  List<SCEntryTypeModel> outboundList = [];

  @override
  onInit() {
    super.onInit();
    loadWareHouseList();
    loadOutboundType();
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

  /// 出库类型
  loadOutboundType() {
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kWareHouseTypeUrl,
        params: {'dictionaryCode' : 'OUTBOUND'},
        success: (value) {
          SCLoadingUtils.hide();
          print('出库类型======================================$value');
          outboundList = List<SCEntryTypeModel>.from(value.map((e) => SCEntryTypeModel.fromJson(e)).toList());
          update();
        },
        failure: (value) {
          print('出库类型=====================================$value');
        });
  }

}

