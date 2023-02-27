
import 'dart:developer';

import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';

import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../Model/sc_check_type_model.dart';

/// 盘点任务-物资分类controller

class SCMaterialCheckSelectCategoryController extends GetxController {
  /// header数据源
  List<SCCheckTypeModel> headerList = [];

  /// footer数据源
  List<SCCheckTypeModel> footerList = [];

  /// 原始数据源
  List<SCCheckTypeModel> originalList = [];

  /// typeList
  List<SCCheckTypeModel> typeList = [];

  /// 已选的model
  List<SCCheckTypeModel> seelctList = [];

  @override
  onInit() {
    super.onInit();
    initData();
  }

  /// 初始化数据源
  initData() {
    var json = {
      "name" : "请选择",
      "disable" : true
    };
    SCCheckTypeModel model = SCCheckTypeModel.fromJson(json);
    headerList = [model];
    footerList = [];
  }

  /// 查询物资分类树
  loadMaterialClassTree() {
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kMaterialClassTreeUrl,
        params: null,
        success: (value) {
          SCLoadingUtils.hide();
          log('物资分类===$value');
          typeList = List<SCCheckTypeModel>.from(value.map((e) => SCCheckTypeModel.fromJson(e)).toList());
          footerList = typeList;
          update();
        },
        failure: (value) {
          SCLoadingUtils.hide();
        });
  }

  /// header点击
  headerTap(int index) {
    SCCheckTypeModel model = headerList[index];
    footerList = model.parentList ?? [];
    update();
    if (index == 0) {
      var json = {
        "name" : "请选择",
        "disable" : true
      };
      SCCheckTypeModel model = SCCheckTypeModel.fromJson(json);
      headerList = [model];
    } else {
      SCCheckTypeModel lastModel = headerList.last;
      List<SCCheckTypeModel> list = headerList.sublist(0, index);
      list.add(lastModel);
      headerList = list;
    }
    update();
  }

  /// 更新headerList
  updateHeaderList(int index) {
    SCCheckTypeModel model = footerList[index];
    model.parentList = footerList;
    headerList.insert(headerList.length - 1, model);
    footerList = model.children ?? [];
    update();
  }

  /// 更新footerList
  updateFooterData(int index) {
    SCCheckTypeModel model = footerList[index];
    bool isSelected = !(model.isSelected ?? false);
    model.isSelected = isSelected;
    if (isSelected) {
      seelctList.add(model);
    } else {
      int index = -1;
      for (int i=0; i<seelctList.length; i++) {
        SCCheckTypeModel subModel = seelctList[i];
        if (subModel.id == model.id) {
          index = i;
          break;
        }
      }
      if (index >= 0) {
        seelctList.removeAt(index);
      }
    }
    update();
  }

}