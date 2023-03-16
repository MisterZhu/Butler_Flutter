import 'package:date_format/date_format.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_key.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../../../Login/Home/Model/sc_user_model.dart';
import '../../MaterialEntry/Model/sc_entry_type_model.dart';
import '../../MaterialEntry/Model/sc_material_list_model.dart';
import '../../MaterialEntry/Model/sc_material_task_detail_model.dart';
import '../../MaterialEntry/Model/sc_wareHouse_model.dart';

/// 新增资产报损controller

class SCAddPropertyFrmLossController extends GetxController {
  /// 仓库列表数组
  List<SCWareHouseModel> wareHouseList = [];

  /// 入库类型数组
  List<SCEntryTypeModel> typeList = [];

  /// 已选择的资产数据
  List<SCMaterialListModel> selectedList = [];

  /// 是否是编辑
  bool isEdit = false;

  /// 编辑的参数
  Map<String, dynamic> editParams = {};

  /// 类型
  String type = '';

  /// 类型id
  int typeID = 0;

  /// 类型index
  int typeIndex = -1;

  /// 使用组织(或部门)
  String fetchOrgName = '';

  /// 使用组织(或部门)ID
  String fetchOrgId = '';

  /// 报损人
  String reportUserName = '';

  /// 报损人ID
  String reportUserId = '';

  /// 报损组织(或部门)
  String reportOrgName = '';

  /// 报损组织(或部门)ID
  String reportOrgId = '';

  /// 报损日期，页面上显示，格式yyyy-mm-dd HH:nn
  String reportTimeStr = '';

  /// 报损日期，接口使用，格式yyyy-mm-dd HH:nn:ss
  String reportTime = '';

  /// 备注
  String remark = '';

  /// 主键id
  String editId = '';

  /// 报损单号
  String number = '';

  /// 上传的图片文件数组
  List files = [];

  @override
  onInit() {
    super.onInit();
    reportOrgId =
        SCScaffoldManager.instance.user.orgIds?.first.toString() ?? '';
    reportOrgName =
        SCScaffoldManager.instance.user.orgNames?.first.toString() ?? '';
    reportUserId = SCScaffoldManager.instance.user.id ?? '';
    reportUserName = SCScaffoldManager.instance.user.userName ?? '';
    loadUserOrg();
    loadFrmLossType();
  }

  /// 初始化编辑的参数
  initEditParams() {
    if (isEdit && editParams.isNotEmpty) {
      Map<String, dynamic> params = editParams;

      /// 上传的图片文件数组
      files = params['files'];

      /// 类型
      type = params['typeName'];

      /// 类型id
      typeID = params['type'];

      /// 使用组织(或部门)
      fetchOrgName = params['fetchOrgName'];

      /// 使用组织(或部门)ID
      fetchOrgId = params['fetchOrgId'];

      /// 报损人
      reportUserName = params['reportUserName'];

      /// 报损人ID
      reportUserId = params['reportUserId'];

      /// 报损组织(或部门)
      reportOrgName = params['reportOrgName'];

      /// 报损组织(或部门)ID
      reportOrgId = params['reportOrgId'];

      /// 报损日期
      reportTime = params['reportTime'];

      if (reportTime != '') {
        /// 报损日期Str
        reportTimeStr = formatDate(DateTime.parse(reportTime),
            [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn]);
      }

      /// 备注
      remark = params['remark'];

      /// 主键id
      editId = params['id'];

      /// 报损单号
      number = params['number'];

      for (int i = 0; i < typeList.length; i++) {
        SCEntryTypeModel model = typeList[i];
        if (model.code == typeID) {
          typeIndex = i;
          break;
        }
      }
    }
  }

  /// 新增报损, status=0暂存，1提交
  addFrmLoss({required int status, required dynamic data}) {
    var params = {
      "files": data['files'],
      "materials": data['materialList'],
      "remark": data['remark'],
      "status": status,
      "type": data['typeId'],
      "typeName": data['typeName'],
      "fetchOrgName": data['fetchOrgName'],
      "fetchOrgId": data['fetchOrgId'],
      "reportUserName": data['reportUserName'],
      "reportUserId": data['reportUserId'],
      "reportOrgName": data['reportOrgName'],
      "reportOrgId": data['reportOrgId'],
      "reportTime": data['reportTime'],
    };
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kAddPropertyFrmLossUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          SCScaffoldManager.instance.eventBus
              .fire({'key': SCKey.kRefreshPropertyFrmLossPage});
          SCRouterHelper.back(null);
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }

  /// 编辑报损基础信息
  editMaterialBaseInfo({required dynamic data}) {
    print('编辑基础信息=========$data');
    //List materialList = data['materialList'];
    var params = {
      "id": editId,
      'number': number,
      "remark": data['remark'],
      "type": data['typeId'],
      "typeName": data['typeName'],
      "fetchOrgName": data['fetchOrgName'],
      "fetchOrgId": data['fetchOrgId'],
      "reportUserName": data['reportUserName'],
      "reportUserId": data['reportUserId'],
      "reportOrgName": data['reportOrgName'],
      "reportOrgId": data['reportOrgId'],
      "reportTime": data['reportTime'],
      "status": 0,
    };
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kEditAddPropertyFrmLossBaseInfoUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          SCScaffoldManager.instance.eventBus
              .fire({'key': SCKey.kRefreshPropertyFrmLossPage});
          SCRouterHelper.back(null);
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }

  /// 编辑-新增物资
  editAddMaterial(
      {required List list, Function(bool success)? completeHandler}) {
    print('编辑-新增物资=========$list');
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kEditAddFrmLossPropertyUrl,
        params: list,
        success: (value) {
          loadMaterialEntryDetail();
        },
        failure: (value) {
          SCLoadingUtils.hide();
          completeHandler?.call(false);
        });
  }

  /// 编辑-删除物资
  editDeleteMaterial(
      {required String reportId,
        Function(bool success)? completeHandler}) {
    var params = {"reportId": reportId};
    print("删除报损参数：$params");
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        isQuery: true,
        url: SCUrl.kEditDeleteFrmLossPropertyUrl,
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

  /// 报损类型
  loadFrmLossType() {
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kWareHouseTypeUrl,
        params: {'dictionaryCode': 'REPORTLOSS_TYPE'},
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

  /// 报损详情
  loadMaterialEntryDetail() {
    SCHttpManager.instance.get(
        url: SCUrl.kPropertyFrmLossDetailUrl,
        params: {'id': editId},
        success: (value) {
          SCLoadingUtils.hide();
          SCMaterialTaskDetailModel model =
          SCMaterialTaskDetailModel.fromJson(value);
          // List<SCPropertyListModel> materials = model.materials ?? [];
          // for (SCMaterialListModel subModel in materials) {
          //   subModel.localNum = subModel.number ?? 1;
          //   subModel.isSelect = true;
          //   subModel.name = subModel.materialName ?? '';
          // }
          //updateSelectedMaterial(materials);
        },
        failure: (value) {
          SCToast.showTip(value['message']);
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

  /// 获取当前用户默认组织信息
  loadUserOrg() {
    String token = SCScaffoldManager.instance.user.token ?? '';
    var params = {'id': SCScaffoldManager.instance.user.id};
    return SCHttpManager.instance.get(
        url: SCUrl.kUserInfoUrl,
        params: params,
        success: (value) {
          value['token'] = token;
          SCUserModel userModel = SCUserModel.fromJson(value);
          SCScaffoldManager.instance.user = userModel;
          reportOrgId =
              SCScaffoldManager.instance.user.orgIds?.first.toString() ?? '';
          reportOrgName =
              SCScaffoldManager.instance.user.orgNames?.first.toString() ?? '';
          update();
        });
  }
}
