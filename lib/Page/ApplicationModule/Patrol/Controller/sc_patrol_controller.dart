
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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

  List siftList = ['分类', '状态', '排序'];

  List statusList = [
    {'name': '全部', 'code': -1},
    {'name': '待处理', 'code': 0},
    {'name': '处理中', 'code': 1},
    {'name': '已处理', 'code': 2},
    {'name': '已拒绝', 'code': 3},
  ];

  List typeList = [];

  /// 项目id
  String communityId = "";

  /// 已选的项目index
  int currentCommunityIndex = 0;

  /// RefreshController
  RefreshController refreshController = RefreshController(initialRefresh: false);

  /// 数据是否加载成功
  bool loadDataSuccess = false;

  List dataList = ['', '', ''];

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
      //SCLoadingUtils.show();
    }


    loadDataSuccess = true;
  }
}