import 'package:get/get.dart';

/// 监控-筛选空间名称controller

class SCMonitorSiftController extends GetxController {

  /// 搜索内容
  String searchString = '';

  /// 更新搜索内容
  updateSearchString(String value) {
    searchString = value;
    update();
  }
}