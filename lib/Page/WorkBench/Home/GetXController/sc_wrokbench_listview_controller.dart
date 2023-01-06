import 'dart:async';

import 'package:get/get.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Model/sc_work_order_model.dart';

/// listView-controller

class SCWorkBenchListViewController extends GetxController {

  /// 数据源
  List<SCWorkOrderModel> dataList = [];

  String pageName = '';

  String tag = '';

}
