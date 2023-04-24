
import 'dart:convert';
import 'dart:developer';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/Patrol/Model/sc_patrol_type_model.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../../WarningCenter/Model/sc_warning_dealresult_model.dart';
import '../Model/sc_patrol_task_model.dart';

/// 巡查controller

class SCPatrolController extends GetxController {

  int pageNum = 1;

  /// 选中的状态index
  int selectStatusIndex = 0;

  /// 排序，true操作时间正序，false操作时间倒序
  bool sort = false;

  /// 选中的排序index
  int selectSortIndex = 0;

  /// 类型第一列的index
  int typeIndex1 = -1;

  /// 类型第二列的index
  int typeIndex2 = -1;

  /// 类型列表
  List<SCWarningDealResultModel> typeList = [];

  List siftList = ['分类', '状态', '排序'];

  List<SCWarningDealResultModel> statusList = [];

  /// 项目id
  String communityId = "";

  /// 已选的项目index
  int currentCommunityIndex = 0;

  /// RefreshController
  RefreshController refreshController = RefreshController(initialRefresh: false);

  /// 数据是否加载成功
  bool loadDataSuccess = false;

  List<SCPatrolTaskModel> dataList = [];

  @override
  onInit() {
    super.onInit();
    getTaskStatusData();
    getTypeData();
  }

  /// 更新项目id
  updateCommunityId(String value, int index) {
    communityId = value;
    currentCommunityIndex = index;
    update();
    loadData(isMore: false);
  }

  /// 选择状态，刷新页面数据
  updateStatusIndex(int value) {
    selectStatusIndex = value;
    pageNum = 1;

    /// 重新获取数据
    loadData(isMore: false);
  }

  /// 更新排序，刷新页面数据
  updateSort(bool value) {
    sort = value;
    pageNum = 1;

    /// 重新获取数据
    loadData(isMore: false);
  }

  /// 巡查列表数据
  loadData({bool? isMore, Function(bool success, bool last)? completeHandler}) {
    bool isLoadMore = isMore ?? false;
    if (isLoadMore == true) {
      pageNum++;
    } else {
      pageNum = 1;
      SCLoadingUtils.show();
    }
    List fields = [];
    if (typeIndex1 >= 0) {// 类型
      SCWarningDealResultModel model1 = typeList[typeIndex1];
      if (typeIndex2 >= 0) {
        SCWarningDealResultModel model2 = model1.pdictionary![typeIndex2];
        var dic = {
          "map": {},
          "method": 1,
          "name": "childrenIdList",
          "value": [model2.id]
        };
        fields.add(dic);
      } else {
        List idList = [];
        for (SCWarningDealResultModel model3 in (model1.pdictionary ?? [])) {
          idList.add(model3.id);
        }
        var dic = {
          "map": {},
          "method": 1,
          "name": "childrenIdList",
          "value": idList
        };
        fields.add(dic);
      }
    }
    if (selectStatusIndex > 0) {// 状态
      SCWarningDealResultModel model = statusList[selectStatusIndex];
      var dic = {
        "map": {},
        "method": 1,
        "name": "a.status",
        "value": model.code
      };
      fields.add(dic);
    }
    var params = {
      "conditions": {"fields": fields, "specialMap": {}},
      "count": false,
      "last": false,
      "orderBy": [
        {"asc": sort, "field": "gmtModify"}
      ],
      "pageNum": pageNum,
      "pageSize": 20
    };
    SCHttpManager.instance.post(
        url: SCUrl.kPatrolListUrl,
        params: params,
        success: (value) {
          loadDataSuccess = true;
          SCLoadingUtils.hide();
          if (value is Map) {
            List list = value['records'];
            if (isLoadMore == true) {
              dataList.addAll(List<SCPatrolTaskModel>.from(list.map((e) => SCPatrolTaskModel.fromJson(e)).toList()));
            } else {
              dataList = List<SCPatrolTaskModel>.from(list.map((e) => SCPatrolTaskModel.fromJson(e)).toList());
            }
          } else {
            if (isLoadMore == false) {
              dataList = [];
            }
          }
          update();
          bool last = false;
          if (isLoadMore) {
            last = value['last'];
          }
          completeHandler?.call(true, last);
        },
        failure: (value) {
          if (isLoadMore) {
            pageNum--;
          }
          SCToast.showTip(value['message']);
          completeHandler?.call(false, false);
        });
  }


  /// 任务状态
  getTaskStatusData() {
    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: SCUrl.kConfigDictionaryPidCodeUrl,
        params: {'dictionaryCode': 'CUSTOM_STATUS'},
        success: (value) {
          SCLoadingUtils.hide();
          List<SCWarningDealResultModel> list = List<
              SCWarningDealResultModel>.from(
              value.map((e) => SCWarningDealResultModel.fromJson(e)).toList());
          SCWarningDealResultModel model = SCWarningDealResultModel.fromJson({'name': '全部', 'code': -1});
          list.insert(0, model);
          statusList = list;
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }

  /// 获取分类
  getTypeData() {
    SCHttpManager.instance.post(url: SCUrl.kPatrolTypeUrl, params: {"appCode": "POLICED_POINT"},success: (value) {
      List<SCPatrolTypeModel> list = List<SCPatrolTypeModel>.from(value.map((e) => SCPatrolTypeModel.fromJson(e)).toList());
      for (SCPatrolTypeModel model in list) {
        List children = [];
        for (SCPatrolTypeModel subModel in (model.children ?? [])) {
          var subParams = {"id": subModel.id.toString(), "name": subModel.categoryName, };
          children.add(subParams);
        }
        var params = {"id": model.id.toString(), "name": model.categoryName, "pdictionary": children};
        SCWarningDealResultModel subModel = SCWarningDealResultModel.fromJson(params);
        typeList.add(subModel);
      }
      log('分类===${jsonEncode(value)}');
    }, failure: (value) {});
  }

  /// 更新类型的index
  updateTypeIndex(int value1, int value2) {
    typeIndex1 = value1;
    typeIndex2 = value2;
    update();
    loadData(isMore: false);
  }

  /// 重置预警类型
  resetAction() {
    typeIndex1 = -1;
    typeIndex2 = -1;
    update();
    loadData(isMore: false);
  }
}