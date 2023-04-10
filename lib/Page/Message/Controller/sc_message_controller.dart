import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../Network/sc_http_manager.dart';
import '../../../Network/sc_url.dart';
import '../Model/sc_message_card_model.dart';

class SCMessageController extends GetxController {

  int pageNum = 1;

  int currentIndex = 0;

  List<SCMessageCardModel> allDataList = [];

  List<SCMessageCardModel> unreadDataList = [];

  /// 是否显示更多弹窗，默认不显示
  bool showMoreDialog = false;
  @override
  onInit() {
    super.onInit();
    loadData(isMore: false);
  }

  updateMoreDialogStatus() {
    showMoreDialog = !showMoreDialog;
    update();
  }

  loadData({bool? isMore, Function(bool success, bool last)? completeHandler}) {
    bool isLoadMore = isMore ?? false;
    if (isLoadMore == true) {
      pageNum++;
    } else {
      pageNum = 1;
      SCLoadingUtils.show();
    }
    SCHttpManager.instance.post(
        url: SCUrl.kMessageListUrl,
        params: null,
        success: (value) {
          SCLoadingUtils.hide();
          List list = value['records'];
          if (isLoadMore == true) {
            allDataList.addAll(List<SCMessageCardModel>.from(
                list.map((e) => SCMessageCardModel.fromJson(e)).toList()));
          } else {
            allDataList = List<SCMessageCardModel>.from(
                list.map((e) => SCMessageCardModel.fromJson(e)).toList());
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

}