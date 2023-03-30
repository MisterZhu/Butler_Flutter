
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

/// 在线监控controller

class SCOnlineMonitorController extends GetxController {

  int pageNum = 1;

  /// 选中的状态，默认显示全部
  int selectStatus = 0;


  List dataList = [1];

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
      //SCLoadingUtils.show();
    }
  }

}