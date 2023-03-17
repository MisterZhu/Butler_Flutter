
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../../../../Utils/Router/sc_router_helper.dart';
import '../../MaterialEntry/Controller/sc_material_entry_detail_controller.dart';
import '../../MaterialEntry/Model/sc_entry_type_model.dart';
import '../../MaterialEntry/Model/sc_material_assets_details_model.dart';
import '../../MaterialEntry/Model/sc_material_list_model.dart';

/// 固定资产盘点-物资详情controller

class SCFixedCheckMaterialDetailController extends GetxController {

  /// 报损类型数组
  List<SCEntryTypeModel> typeList = [];

  /// 报损原因数组
  List reasonList = [];

  /// 详情model
  SCMaterialAssetsDetailsModel detailModel = SCMaterialAssetsDetailsModel();

  /// normalList
  List<SCMaterialListModel> normalList = [];

  /// doneList
  List<SCMaterialListModel> doneList = [];

  /// 盘点Id
  String checkId = '';

  /// 名称
  String name = '';

  /// 单位
  String unit = '';

  /// 规格
  String norms = '';

  @override
  onInit() {
    super.onInit();
    loadFrmLossType();
  }

  /// initData
  initData() {
    normalList = getNormalData();
    doneList = getDoneData();
  }

  /// 获取未处理的数据
  List<SCMaterialListModel> getNormalData() {
    List list = List.from(detailModel.assetsDetails ?? []);
    List<SCMaterialListModel> newList = [];
    for (SCMaterialListModel model in list) {
      int status = model.status ?? 2;
      if (status == 2) {
        newList.add(model);
      }
    }
    return newList;
  }

  /// 获取已处理的数据
  List<SCMaterialListModel> getDoneData() {
    List list = detailModel.assetsDetails ?? [];
    List<SCMaterialListModel> newList = [];
    for (SCMaterialListModel model in list) {
      int status = model.status ?? 2;
      if (status != 2) {
        newList.add(model);
      }
    }
    return newList;
  }

  /// 报损类型
  loadFrmLossType() {
    SCHttpManager.instance.post(
        url: SCUrl.kWareHouseTypeUrl,
        params: {'dictionaryCode': 'REPORTLOSS_TYPE'},
        success: (value) {
          typeList = List<SCEntryTypeModel>.from(
              value.map((e) => SCEntryTypeModel.fromJson(e)).toList());
          reasonList = typeList.map((e) => e.name).toList();
          update();
        },
        failure: (value) {

        });
  }

  /// 确定
  submit() {
    List list = [];
    for (SCMaterialListModel model in normalList) {
      print("aaa===${model.toJson()}");
      var params = {
        "id" : model.id,
        "status" : 2,
      };
      print("ccc===${params}");
      list.add(params);
    }

    for (SCMaterialListModel model in doneList) {
      print("bbb===${model.toJson()}");
      var params = {
        "id" : model.id,
        "status" : 1,
        "reportReason": model.reportReason
      };
      print("ddd===${params}");
      list.add(params);
    }
    SCMaterialEntryDetailController controller = SCMaterialEntryDetailController();
    controller.fixedCheckSubmit(action: 0, checkId: checkId, materials: list,successHandler: (){
      SCRouterHelper.back({"data" : list});
    });
  }

}