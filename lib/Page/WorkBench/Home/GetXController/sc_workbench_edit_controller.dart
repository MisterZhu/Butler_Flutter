import 'package:get/get.dart';

import '../../../../Constants/sc_key.dart';

/// 工作台-编辑controller

class SCWorkBenchEditController extends GetxController {

  /// 所有任务
  List allTaskTitleList = [];

  /// 我的任务
  List myTaskTitleList = [];

  /// 其他任务
  List otherTaskTitleList = [];

  /// 初始化数据
  initData(dynamic params) {
    if (params.containsKey(SCKey.kWorkBenchAllTabTitleListKey)) {
      allTaskTitleList = List.from(params[SCKey.kWorkBenchAllTabTitleListKey]);
    }
    if (params.containsKey(SCKey.kWorkBenchMyTabTitleListKey)) {
      myTaskTitleList = List.from(params[SCKey.kWorkBenchMyTabTitleListKey]);
    }

    for(var title in allTaskTitleList) {
      if (myTaskTitleList.contains(title) == false) {
        otherTaskTitleList.add(title);
      }
    }
  }
}