
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../../WarningCenter/Model/sc_warning_dealresult_model.dart';
import '../Model/sc_patrol_task_model.dart';

/// 巡查controller

class SCPatrolController extends GetxController {

  int pageNum = 1;

  /// 选中的状态，默认显示全部
  int selectStatusId = -1;

  /// 选中的状态index
  int selectStatusIndex = 0;

  /// 选中的类型，默认显示全部
  int selectTypeId = -1;

  /// 选中的类型index
  int selectTypeIndex = 0;

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

  List statusList = [
    {'name': '全部', 'code': -1},
    {'name': '未开始', 'code': 0},
    {'name': '待处理', 'code': 1},
    {'name': '处理中', 'code': 2},
    {'name': '已完成', 'code': 3},
    {'name': '已关闭', 'code': 4},
  ];

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

  }

  /// 更新项目id
  updateCommunityId(String value, int index) {
    communityId = value;
    currentCommunityIndex = index;
    update();
    loadData(isMore: false);
  }

  /// 选择状态，刷新页面数据
  updateStatus(int value) {
    selectStatusId = value;
    pageNum = 1;

    /// 重新获取数据
    loadData(isMore: false);
  }

  /// 选择类型，刷新页面数据
  updateType(int value) {
    selectTypeId = value;
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
    if (selectTypeId >= 0) {
      var dic = {"map": {}, "method": 1, "name": "type", "value": selectTypeId};
      fields.add(dic);
    }
    if (selectStatusId >= 0) {
      var dic = {
        "map": {},
        "method": 1,
        "name": "status",
        "value": selectStatusId
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

  /// 获取分类
  getTypeData() {
    SCHttpManager.instance.get(url: SCUrl.kPatrolTypeUrl,success: (value) {}, failure: (value) {});
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