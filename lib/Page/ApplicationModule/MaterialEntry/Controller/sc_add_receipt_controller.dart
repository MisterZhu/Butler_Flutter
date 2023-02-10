
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../Model/sc_wareHouse_model.dart';
import '../Model/sc_wareHouse_type_model.dart';


/// 新增入库controller

class SCAddReceiptController extends GetxController {

  String wareHouseName = '';
  List<SCWareHouseModel> wareHouseList = [];

  List<SCWareHouseTypeModel> typeList = [];

  @override
  onInit() {
    super.onInit();
    List list = [{'value': 1, 'label': '采购入库'},
      {'value': 2, 'label': '调拨入库'},
      {'value': 3, 'label': '盘盈入库'},
      {'value': 4, 'label': '领料归还入库'},
      {'value': 5, 'label': '借用归还入库'},
      {'value': 6, 'label': '退货入库'},
      {'value': 99, 'label': '其它入库'},
    ];
    typeList = list.map((e) => SCWareHouseTypeModel.fromJson(e)).toList();
  }

  /// 选择搜索仓库列表
  loadWareHouseList() {
    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: SCUrl.kWareHouseListUrl,
        params: {'wareHouseName' : wareHouseName},
        success: (value) {
          SCLoadingUtils.hide();
          print('仓库列表======================================$value');
          wareHouseList = List<SCWareHouseModel>.from(value.map((e) => SCWareHouseModel.fromJson(e)).toList());
          update();
        },
        failure: (value) {
          print('仓库列表=====================================$value');
        });
  }


  /// 选择搜索仓库类型
  loadWareHouseType() {
    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: SCUrl.kWareHouseTypeUrl,
        params: {'dictionaryCode' : ''},
        success: (value) {
          SCLoadingUtils.hide();
          print('仓库类型======================================$value');
          typeList = List<SCWareHouseTypeModel>.from(value.map((e) => SCWareHouseTypeModel.fromJson(e)).toList());
          update();
        },
        failure: (value) {
          print('仓库类型=====================================$value');
        });
  }

}

