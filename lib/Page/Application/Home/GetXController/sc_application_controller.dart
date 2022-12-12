
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Constants/sc_asset.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../../../../Skin/Model/sc_user.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../Model/sc_application_module_model.dart';


class SCApplicationController extends GetxController {

  /// 是否正在编辑，默认不编辑
  bool isEditing = false;

  /// 常用应用列表
  late SCApplicationModuleModel regularModuleModel;
  /// 数据
  List<SCApplicationModuleModel> moduleList = [];


  @override
  onInit() {
    super.onInit();
  }

  loadTestData() {
    testData();
  }

  addRegularAppData() {
    var homeTestList = [
      {"icon": {"fileKey": "", "name": SCAsset.iconApplicationWorkOrder}, "id": "1", "name": "工单调度"},
      {"icon": {"fileKey": "", "name": SCAsset.iconApplicationVehicleRegistration}, "id": "2", "name": "车访登记"},
      {"icon": {"fileKey": "", "name": SCAsset.iconApplicationReportRepair}, "id": "3", "name": "报事报修"},
    ];
    var regularData = {"module": {"id": "0", "name": "快捷应用"}, "applets": homeTestList};
    regularModuleModel = SCApplicationModuleModel.fromJson(regularData);
    moduleList.insert(0, regularModuleModel);
  }

  testData() {
    moduleList = [];

    var testList = [
      {"applets": [
        {"icon": {"fileKey": "", "name": SCAsset.iconApplicationWorkOrder},"id": "1","name": "工单调度"},
        {"icon": {"fileKey": "","name": SCAsset.iconApplicationVehicleRegistration},"id": "2","name": "车访登记"},
        {"icon": {"fileKey": "","name": SCAsset.iconApplicationReportRepair,},"id": "3","name": "报事报修"},
        {"icon": {"fileKey": "", "name": SCAsset.iconApplicationDepositRegistration},"id": "4","name": "寄存登记"},
        {"icon": {"fileKey": "","name": SCAsset.iconApplicationVisitorRegistration},"id": "14","name": "人行登记"},
        {"icon": {"fileKey": "","name": SCAsset.iconApplicationDecorationRegistration,},"id": "15","name": "装修登记"},
      ],"module": {"id": "1", "name": "业主服务"}
      },
      {"applets": [
        {"icon": {"fileKey": "","name": SCAsset.iconApplicationWorkOrder},"id": "21","name": "业主二维码"},
        {"icon": {"fileKey": "","name": SCAsset.iconApplicationVehicleRegistration},"id": "22","name": "公务用车"},
        {"icon": {"fileKey": "","name": SCAsset.iconApplicationReportRepair},"id": "23","name": "小区缴费"},
        {"icon": {"fileKey": "","name": SCAsset.iconApplicationDepositRegistration},"id": "24","name": "家庭理财"},
        {"icon": {"fileKey": "","name": SCAsset.iconApplicationDecorationRegistration},"id": "25","name": "社区社群"},
        {"icon": {"fileKey": "","name": SCAsset.iconApplicationVisitorRegistration},"id": "26","name": "智慧社区"},
        {"icon": {"fileKey": "","name": SCAsset.iconApplicationVisitorRegistration},"id": "27","name": "智慧街道"},
        {"icon": {"fileKey": "","name": SCAsset.iconApplicationVisitorRegistration},"id": "28","name": "社区游玩"},
        {"icon": {"fileKey": "","name": SCAsset.iconApplicationVisitorRegistration},"id": "29","name": "智慧出行"},
        {"icon": {"fileKey": "","name": SCAsset.iconApplicationVisitorRegistration},"id": "20","name": "智慧预约"},
      ],"module": {"id": "2","name": "智慧应用"}
      },
    ];
    moduleList = testList.map((e) => SCApplicationModuleModel.fromJson(e)).toList();
    addRegularAppData();
  }

  /// 获取应用列表数据
  loadAppListData() {
    moduleList = [];
    SCUser user = SCScaffoldManager.instance.getUserData();
    String? housingId = user.housingId;
    SCHttpManager.instance.get(
        url: SCUrl.kServiceAppListUrl,
        params: {
          'housingId' : housingId,
        },
        success: (value) {
          List<SCApplicationModuleModel> dataList = List<SCApplicationModuleModel>.from(value.map((e) => SCApplicationModuleModel.fromJson(e)).toList());
          updateModuleList(list: dataList);
        },
        failure: (value) {
          log('appList失败===$value');

        });
  }

  /// 更新数据源
  updateModuleList({required List<SCApplicationModuleModel> list}) {
    moduleList = list;
    update();
  }

  /// 更新编辑状态
  updateEditStatus() {
    isEditing = !isEditing;
    update();
  }

  /// 移除首页应用
  deleteRegularApp(Applets model) {
    regularModuleModel.applets?.remove(model);
    update();
  }

  /// 添加常用应用
  addRegularApp(Applets model) {
    if (regularModuleModel.applets?.length == 9) {
      SCToast.showTip('首页最多添加9个应用\n请先移除再添加');
    } else {
      regularModuleModel.applets?.add(model);
      update();
    }
  }
}
