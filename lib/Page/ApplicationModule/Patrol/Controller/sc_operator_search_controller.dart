import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';

import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../../MaterialEntry/Model/sc_selectcategory_model.dart';
import '../../MaterialOutbound/Model/sc_receiver_model.dart';
import '../Model/sc_tenant_user_model.dart';

/// 转派人员搜索-controller

class SCOperatorSearchController extends GetxController {

  /// 搜索内容
  String searchString = '';

  /// 无搜索结果提示
  String tips = '';

  /// 人id
  String userId = "";

  int pageNum = 1;

  /// 转派人列表数组
  List<SCTenantUserModel> dataList = [];

  @override
  onInit() {
    super.onInit();
  }

  /// 更新搜索内容
  updateSearchString(String value) {
    searchString = value;
    update();
  }

  /// 搜索列表数据
  searchData({bool? isMore, Function(bool success, bool last)? completeHandler}) {
    bool isLoadMore = isMore ?? false;
    if (isLoadMore == true) {
      pageNum++;
    } else {
      pageNum = 1;
      SCLoadingUtils.show();
    }
    var params = {
      "conditions": {
        "fields": [
          {
            "map": {},
            "method": 1,
            "name": "orgIds",
            "value": []
          },
          {
            "map": {},
            "method": 7,
            "name": "userName",
            "value": searchString
          }
        ]
      },
      "count": true,
      "last": true,
      "orderBy": [],
      "pageNum": pageNum,
      "pageSize": 20
    };
    SCHttpManager.instance.post(
        url: SCUrl.kTransferUserListUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          List list = value['records'];
          if (isLoadMore == true) {
            dataList.addAll(List<SCTenantUserModel>.from(list.map((e) => SCTenantUserModel.fromJson(e)).toList()));
          } else {
            dataList = List<SCTenantUserModel>.from(list.map((e) => SCTenantUserModel.fromJson(e)).toList());
          }
          if (dataList.isNotEmpty) {
            tips = '';
          } else {
            tips = '暂无搜索结果';
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

  /// 更新转派人员信息
  updateUserInfo(SCReceiverModel model) {
    userId = model.personId ?? '';
    update();
  }
}
