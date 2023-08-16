import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_enum.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/Model/sc_selectcategory_model.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../../MaterialEntry/Model/sc_selectcategory_tree_model.dart';
import '../../MaterialOutbound/Model/sc_receiver_model.dart';

/// 新增物资alert-controller

class SCCategoryAlertController extends GetxController {

  /// 领用人列表数组
  List<SCReceiverModel> dataList = [];

  /// tag
  String tag = '';

  /// 选择类型tree-model
  List<SCSelectCategoryTreeModel> treeList = [];

  /// 选择类型children-model
  List<SCSelectCategoryTreeModel> childrenList = [];

  /// 弹窗header数据源
  List<SCSelectCategoryModel> headerList = [];

  /// 弹窗footer数据源
  List<SCSelectCategoryModel> footerList = [];

  /// 当前部门model
  SCSelectCategoryModel currentDepartmentModel = SCSelectCategoryModel();

  /// 当前parent数据源
  List<SCSelectCategoryModel> currentParentList = [];

  /// 物资类型
  SCWarehouseManageType materialType = SCWarehouseManageType.entry;

  /// 是否是领料
  bool isLL = false;

  /// 仓库id
  String wareHouseId = '';

  @override
  onInit() {
    super.onInit();
    //loadDataList();
  }

  /// 物资分类数据
  loadMaterialSortData({Function(bool success, List<SCSelectCategoryModel> list)? completeHandler}) {
    SCLoadingUtils.show();
    String url = '';
    var params = {};
    bool isQuery = false;
    if (isLL && materialType == SCWarehouseManageType.outbound) {
      url = SCUrl.kMaterialSortWithWareHouseUrl;
      params = {'wareHouseId' : wareHouseId};
      isQuery = true;
    } else {
      url = SCUrl.kMaterialSortUrl;
      params = {};
      isQuery = false;
    }
    SCHttpManager.instance.post(
        url: url,
        params: params,
        isQuery: isQuery,
        success: (value) {
          SCLoadingUtils.hide();
          treeList = (List<SCSelectCategoryTreeModel>.from(
              value.map((e) => SCSelectCategoryTreeModel.fromJson(e))));
          childrenList = treeList;
          List<SCSelectCategoryModel> list = [];
          for(SCSelectCategoryTreeModel model in treeList) {
            String orgName = model.name ?? '';
            String subId = model.id.toString();
            var subParams = {
              "enable" : true,
              "title" : orgName,
              "id" : subId,
              "parentList" : [],
              "childList" :model.children
            };
            SCSelectCategoryModel selectCategoryModel = SCSelectCategoryModel.fromJson(subParams);
            list.add(selectCategoryModel);
          }
          completeHandler?.call(true, list);
          update();
        },
        failure: (value) {
          completeHandler?.call(false, []);
          SCToast.showTip(value['message']);
        });
  }

  /// 更新footer数据源
  updateFooterData(List<SCSelectCategoryModel> list) {
    footerList = list;
    update();
  }

  /// 更新header数据源
  updateHeaderData(SCSelectCategoryModel model) {
    headerList.insert(headerList.length - 1, model);
    if (childrenList.isEmpty) {
      headerList.removeLast();
    }
    currentDepartmentModel = model;
    update();
  }

  /// 初始化header数据源
  initHeaderData() {
    headerList.clear();
    SCSelectCategoryModel model = SCSelectCategoryModel.fromJson({"enable" : false, "title" : "请选择", "id" : ""});
    headerList.add(model);
  }

}

