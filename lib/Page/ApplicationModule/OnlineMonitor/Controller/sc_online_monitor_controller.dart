
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../Model/sc_monitor_list_model.dart';
import '../Model/sc_select_model.dart';

/// 在线监控controller

class SCOnlineMonitorController extends GetxController {

  int pageNum = 1;

  /// 选中的状态，默认显示全部
  int selectStatus = 0;

  /// 选中的空间id
  int selectSpaceId = 0;

  List<SCMonitorListModel> dataList = [];

  List<SCSelectModel> spaceList = [];

  /// 是否加载完成
  bool loadDone = false;

  /// 原始数据数量，记录下来用来固定弹窗的高度
  int originalLength = 0;

  @override
  onInit() {
    super.onInit();
  }

  /// 更新状态，刷新页面数据
  updateStatus(int value) {
    selectStatus = value;
    pageNum = 1;

    /// 重新获取数据
    loadData(isMore: false);
  }


  loadData({bool? isMore, Function(bool success, bool last)? completeHandler}) {
    bool isLoadMore = isMore ?? false;
    if (isLoadMore == true) {
      pageNum++;
    } else {
      pageNum = 1;
      SCLoadingUtils.show();
    }
    var conditions = {};
    if (selectStatus == 1) {// 在线
      conditions = {"status": 1};
    } else if (selectStatus == 2) { // 离线
      conditions = {"status": 0};
    }
    if (selectSpaceId != 0) {
      conditions.addAll({"communityId": selectSpaceId});
    }
    var params = {
      "conditions": conditions,
      "count": false,
      "last": false,
      "orderBy": [
        {"asc": true, "field": ""}
      ],
      "pageNum": pageNum,
      "pageSize": 20
    };
    SCHttpManager.instance.post(
        url: SCUrl.kMonitorListUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          loadDone = true;
          if (value is Map) {
            List list = value['records'];
            if (isLoadMore == true) {
              dataList.addAll(List<SCMonitorListModel>.from(list.map((e) => SCMonitorListModel.fromJson(e)).toList()));
            } else {
              dataList = List<SCMonitorListModel>.from(list.map((e) => SCMonitorListModel.fromJson(e)).toList());
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
          loadDone = true;
          SCToast.showTip(value['message']);
          completeHandler?.call(false, false);
        });
  }

  /// 根据视频监控设备ID获取视频监控播放地址
  getMonitorPlayUrl({required String id, required Function(String url) completeHandler}) {
    SCHttpManager.instance.get(
        url: SCUrl.kMonitorPlayUrl+id,
        params: null,
        success: (value) {
          String url = value['hls'];
          completeHandler(url);
        },
        failure: (value) {
          SCToast.showTip(value['message']);
          completeHandler('');
        });
  }

  /// 空间搜索
  getSpaceData({required bool isSearch, String? name, Function(bool status)? completeHandler}) {
    SCLoadingUtils.show();
    var params = {
      "name": name ?? '',
    };
    SCHttpManager.instance.post(
        url: SCUrl.kSpaceListUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          spaceList = List<SCSelectModel>.from(value.map((e) => SCSelectModel.fromJson(e)).toList());
          if (isSearch == true) {
            /// 搜索结果页面不显示不限
          } else {
            var dic = {'id': 0, 'name': '不限'};
            spaceList.insert(0, SCSelectModel.fromJson(dic));
            originalLength = spaceList.length;
          }
          update();
          completeHandler?.call(true);
        },
        failure: (value) {
          SCLoadingUtils.hide();
          SCToast.showTip(value['message']);
          completeHandler?.call(false);
        });
  }

}