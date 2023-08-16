import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../Model/sc_monitor_list_model.dart';

/// 监控搜索controller

class SCMonitorSearchController extends GetxController {

  int pageNum = 1;

  List<SCMonitorListModel> dataList = [];

  /// 搜索内容
  String searchString = '';

  String tips = '';

  /// 更新搜索内容
  updateSearchString(String value) {
    searchString = value;
    update();
  }

  /// 列表数据
  searchData({bool? isMore, Function(bool success, bool last)? completeHandler}) {
    bool isLoadMore = isMore ?? false;
    if (isLoadMore == true) {
      pageNum++;
    } else {
      pageNum = 1;
      SCLoadingUtils.show();
    }
    var params = {
      "conditions": {"cameraName": searchString},
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

}