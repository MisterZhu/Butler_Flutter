import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Model/sc_todo_model.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';

/// 工作台-待办controller

class SCWorkBenchToDoController extends GetxController {
  /// pageNum
  int pageNum = 1;

  /// data
  List data = [];

  /// 是否是最后一页
  bool isLast = false;

  /// key
  String key = "";

  /// subKey
  String subKey = "";

  /// subValue
  String subValue = "";

  /// refreshController
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  onInit() {
    super.onInit();
  }

  /// 获取数据
  getData({bool? isMore}) {
    bool isLoadMore = isMore ?? false;
    if (isLoadMore == true) {
      pageNum++;
    } else {
      pageNum = 1;
      SCLoadingUtils.show();
    }
    var params = {
      "conditions": {key: SCScaffoldManager.instance.user.id, subKey: subValue},
      "count": true,
      "last": isLast,
      "pageNum": pageNum,
      "pageSize": 10
    };
    return SCHttpManager.instance.post(
        url: SCUrl.kSearchTaskUrl,
        params: params,
        success: (value) {
          log('数据$key===${jsonEncode(value)}');
          SCLoadingUtils.hide();
          if (value is List) {
            if (isLoadMore == false) {
              List list = List.from(value.map((e) {
                return SCToDoModel.fromJson(e);
              }));
              data = list;
            } else {
              List list = List.from(value.map((e) {
                return SCToDoModel.fromJson(e);
              }));
              data.addAll(list);
            }
          } else {
            if (isLoadMore == false) {}
          }
          if (isLoadMore == true) {
            refreshController.loadComplete();
          }
          update();
        },
        failure: (value) {
          SCLoadingUtils.hide();
          if (isLoadMore == true) {
            pageNum--;
            refreshController.loadFailed();
          }
        });
  }
}
