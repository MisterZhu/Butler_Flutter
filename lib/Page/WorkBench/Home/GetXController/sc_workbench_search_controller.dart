import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Network/sc_http_manager.dart';
import 'package:smartcommunity/Network/sc_url.dart';
import 'package:smartcommunity/Page/Login/Home/Model/sc_user_model.dart';
import 'package:smartcommunity/Page/WorkBench/Home/GetXController/sc_changespace_controller.dart';
import 'package:smartcommunity/Page/WorkBench/Home/GetXController/sc_wrokbench_listview_controller.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Model/sc_hotel_order_model.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Model/sc_default_config_model.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Model/sc_space_model.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Model/sc_verification_order_model.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import 'package:smartcommunity/Utils/Permission/sc_permission_utils.dart';

import '../../../../Constants/sc_asset.dart';
import '../../../../Constants/sc_key.dart';
import '../../../../Utils/Location/sc_location_model.dart';
import '../../../ApplicationModule/MaterialEntry/Model/sc_material_entry_model.dart';
import '../../../../Utils/sc_sp_utils.dart';
import '../Model/sc_work_order_model.dart';

/// 工作台搜索Controller

class SCWorkBenchSearchController extends GetxController {

  /// 搜索内容
  String searchString = '';

  int pageNum = 1;

  /// 是否显示搜索结果，默认不显示
  bool showSearchResult = false;

  /// 历史记录数组
  List<String> historyDataList = [];

  @override
  onInit() {
    super.onInit();
    getHistoryData();
  }

  /// 保存历史记录
  saveHistoryData(String content) {
    List<String> list = [content];
    if (SCSpUtil.getKeys().contains(SCKey.kWorkBenchSearchHistory)) {
      List<String> historyList = SCSpUtil.getStringList(SCKey.kWorkBenchSearchHistory);
      if (historyList.contains(content)) {
        historyList.remove(content);
      }
      list.addAll(historyList);
    }
    SCSpUtil.setStringList(SCKey.kWorkBenchSearchHistory, list);
    getHistoryData();
  }

  /// 获取历史记录数组
  getHistoryData() {
    historyDataList = SCSpUtil.getStringList(SCKey.kWorkBenchSearchHistory);
    update();
  }

  /// 清空历史记录
  clearHistoryData() {
    SCSpUtil.remove(SCKey.kWorkBenchSearchHistory);
    getHistoryData();
  }

  /// 更新搜索内容
  updateSearchString(String value) {
    searchString = value;
    update();
  }


  searchData({bool? isMore, Function(bool success, bool last)? completeHandler}) {
    bool isLoadMore = isMore ?? false;
    if (isLoadMore == true) {
      pageNum++;
    } else {
      pageNum = 1;
      //SCLoadingUtils.show();
    }
    showSearchResult = true;
    update();
  }

}