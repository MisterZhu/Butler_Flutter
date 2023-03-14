import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_key.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialCheck/Model/sc_check_type_model.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../../MaterialEntry/Model/sc_entry_type_model.dart';
import '../../MaterialEntry/Model/sc_material_list_model.dart';
import '../../MaterialEntry/Model/sc_wareHouse_model.dart';


/// 新增固定资产盘点任务controller

class SCAddFixedCheckController extends GetxController {
  /// 仓库列表数组
  List<SCWareHouseModel> wareHouseList = [];

  /// 盘点类型数组
  List<SCEntryTypeModel> typeList = [];

  /// 已选择的物资数据
  List<SCMaterialListModel> selectedList = [];

  /// 已选择的物资分类数据
  List<SCCheckTypeModel> selectedCategoryList = [];

  /// 是否是编辑
  bool isEdit = false;

  /// 编辑的参数
  Map<String, dynamic> editParams = {};

  /// 仓库名称
  String wareHouseName = '';

  /// 仓库id
  String wareHouseId = '';

  /// 仓库index
  int nameIndex = -1;

  /// 任务名称
  String taskName = '';

  /// 类型名称
  String typeName = '';

  /// 盘点类型id
  int type = 0;

  /// 盘点类型index
  int typeIndex = -1;

  /// 开始时间，接口使用
  String startTime = '';

  /// 开始时间，页面显示使用
  String startTimeStr = '';

  /// 结束时间
  String endTime = '';

  /// 结束时间，页面显示使用
  String endTimeStr = '';

  /// 部门
  String dealOrgName = '';

  /// 部门id
  String dealOrgId = '';

  /// 处理人名称
  String dealUserName = '';

  /// 处理人id
  String dealUserId = '';

  /// 范围,1-全部，2-物资分类，3-物品名称
  int rangeValue = 1;

  /// 主键id
  String editId = '';

  @override
  onInit() {
    super.onInit();
    loadWareHouseList();
    loadTypeData();
    loadRangeData();
    loadMaterialClassTree();
  }

  /// 初始化编辑的参数
  initEditParams() {
    if (isEdit && editParams.isNotEmpty) {
      Map<String, dynamic> params = editParams;

      /// 仓库名称
      wareHouseName = params['wareHouseName'];

      /// 仓库id
      wareHouseId = params['wareHouseId'];

      /// 任务名称
      taskName = params['taskName'];

      /// 开始时间
      startTime = params['startTime'];
      startTimeStr = params['startTime'];

      /// 结束时间
      endTime = params['endTime'];
      endTimeStr = params['endTime'];

      /// 部门名称
      dealOrgName = params['dealOrgName'];

      /// 部门id
      dealOrgId = params['dealOrgId'];

      /// 处理人名称
      dealUserName = params['dealUserName'];

      /// 处理人id
      dealUserId = params['dealUserId'];

      /// 范围
      rangeValue = params['rangeValue'];

      typeIndex = params['type'];

      typeName = params['typeName'];

      /// 主键id
      editId = params['id'];
      for (int i = 0; i < wareHouseList.length; i++) {
        SCWareHouseModel model = wareHouseList[i];
        if (model.id == wareHouseId) {
          nameIndex = i;
          break;
        }
      }
      for (int i = 0; i < typeList.length; i++) {
        SCEntryTypeModel model = typeList[i];
        if (model.code == type) {
          typeIndex = i;
          break;
        }
      }
    }
  }

  /// 新增盘点
  addCheck({required int status, required dynamic data}) {
    var params = {
      "dealOrgId": data['dealOrgId'],
      "dealUserId": data['dealUserId'],
      "materialIdList": data['materialIdList'],
      "classifyIdList": data['categoryIDList'],
      "rangeValue": data['rangeValue'],
      "taskEndTime": data['endTime'],
      "taskName": data['taskName'],
      "taskStartTime": data['startTime'],
      "type": data['type'],
      "wareHouseId": data['wareHouseId'],
      "taskTime":[data['startTime'], data['endTime']],
    };
    print("新增盘点参数:$params");
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kAddMaterialCheckUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          SCScaffoldManager.instance.eventBus
              .fire({'key': SCKey.kRefreshMaterialCheckPage});
          SCRouterHelper.back(null);
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }

  /// 编辑盘点基础信息
  editMaterialBaseInfo({required dynamic data}) {
    //List materialList = data['materialList'];
    var params = {
      "id": editId,
      "wareHouseId": data['wareHouseId'],
      "wareHouseName": data['wareHouseName'],
      "taskId": data['taskId'],
      "taskName": data['taskName'],
      "rangeValue": data['rangeValue'],
      "taskEndTime": data['endTime'],
      "taskStartTime": data['startTime'],
      "type": data['type'],
      "typeName": data['typeName'],
      "dealOrgId": data['dealOrgId'],
      "dealUserId": data['dealUserId'],
      "status": 0
    };
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kEditCheckBaseInfoUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          SCScaffoldManager.instance.eventBus
              .fire({'key': SCKey.kRefreshMaterialCheckPage});
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
          if (wareHouseList.length == 1) {
            SCWareHouseModel model = wareHouseList.first;
            wareHouseId = model.id!;
            wareHouseName = model.name!;
          }
          initEditParams();
          update();
        },
        failure: (value) {
          SCLoadingUtils.hide();
        });
  }

  /// 类型
  loadTypeData() {
    SCHttpManager.instance.post(
        url: SCUrl.kWareHouseTypeUrl,
        params: {'dictionaryCode' : 'CHECK_TASK_TYPE'},
        success: (value) {
          typeList = List<SCEntryTypeModel>.from(value.map((e) => SCEntryTypeModel.fromJson(e)).toList());
          initEditParams();
          update();
        },
        failure: (value) {
        });
  }

  /// 盘点范围
  loadRangeData() {
    SCHttpManager.instance.post(
        url: SCUrl.kWareHouseTypeUrl,
        params: {'dictionaryCode' : 'CHECK_TASK_RANGE'},
        success: (value) {
          print('盘点范围===============$value');
          //typeList = List<SCEntryTypeModel>.from(value.map((e) => SCEntryTypeModel.fromJson(e)).toList());
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

  /// 更新已选的物资分类数据
  updateSelectedMaterialCategory(List list) {
    List<SCCheckTypeModel> newList = [];
    for (SCCheckTypeModel model in list) {
      newList.add(model);
    }
    selectedCategoryList = newList;
    update();
  }

  /// 删除物资
  deleteMaterial(int index) {
    if (index < selectedList.length) {
      selectedList.removeAt(index);
      update();
    }
  }

  /// 删除物资分类
  deleteMaterialCategory(int index) {
    if (index < selectedCategoryList.length) {
      selectedCategoryList.removeAt(index);
      update();
    }
  }

  /// 获取物资idList
  List<String> getMaterialIDList() {
    List<String> list = [];
    for (SCMaterialListModel model in selectedList) {
      list.add(model.materialId ?? '');
    }
    return list;
  }

  /// 获取物资分类idList
  List<String> getMaterialCategoryIDList() {
    List<String> list = [];
    for (SCCheckTypeModel model in selectedCategoryList) {
      list.add(model.id ?? '');
    }
    return list;
  }

  /// 查询物资分类树
  loadMaterialClassTree() {
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kMaterialClassTreeUrl,
        params: null,
        success: (value) {
          SCLoadingUtils.hide();
          print('物资分类树============$value');

          update();
        },
        failure: (value) {
          SCLoadingUtils.hide();
        });
  }

}
