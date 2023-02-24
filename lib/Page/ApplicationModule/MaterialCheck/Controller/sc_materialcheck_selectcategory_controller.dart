import 'package:get/get.dart';

import '../Model/sc_check_selectcategory_model.dart';

/// 盘点任务-物资分类controller

class SCMaterialCheckSelectCategoryController extends GetxController {
  /// header数据源
  List<SCCheckSelectCategoryModel> headerList = [];

  /// footer数据源
  List<SCCheckSelectCategoryModel> footerList = [];

  /// 原始数据源
  List<SCCheckSelectCategoryModel> originalList = [];

  @override
  onInit() {
    super.onInit();
    initData();
  }

  /// 初始化数据源
  initData() {
    var json = {
      "title" : "请选择",
      "enable" : false
    };
    SCCheckSelectCategoryModel model = SCCheckSelectCategoryModel.fromJson(json);
    headerList = [model];
    footerList = testData();
    originalList = List.from(footerList);
  }

  /// header点击
  headerTap(int index) {
    if (index == 0) {
      SCCheckSelectCategoryModel model = headerList[index];
      print("第一个===${model.childList}");
      SCCheckSelectCategoryModel lastModel = headerList.last;
      headerList = [lastModel];
      footerList = model.childList ?? [];
    } else {
      SCCheckSelectCategoryModel model = headerList[index - 1];
      SCCheckSelectCategoryModel lastModel = headerList.last;
      List<SCCheckSelectCategoryModel> list = headerList.sublist(0, index);
      list.add(lastModel);
      headerList = list;
      footerList = model.childList ?? [];
    }
    update();
  }

  /// 更新headerList
  updateHeaderList(int index) {
    SCCheckSelectCategoryModel model = footerList[index];
    model.parentList = footerList;
    headerList.insert(headerList.length - 1, model);
    footerList = model.childList ?? [];
    update();
  }

  /// 更新footerList
  updateFooterData(int index) {
    SCCheckSelectCategoryModel model = footerList[index];
    model.isSelected = !(model.isSelected ?? false);
    update();
  }

  /// 测试数据
  List<SCCheckSelectCategoryModel> testData() {
    List list = [
      {
        "title" : "1号",
        "isSelected" : false,
        "parentList" : [],
        "childList" : [
          {
            "title" : "101号",
            "isSelected" : false,
            "childList" : [
              {
                "title" : "1001号",
                "isSelected" : false,
                "childList" : []
              }
            ]
          },
          {
            "title" : "102号",
            "isSelected" : false,
            "childList" : []
          },
          {
            "title" : "103号",
            "isSelected" : false,
            "childList" : []
          },
        ]
      },
      {
        "title" : "2号",
        "isSelected" : false,
        "parentList" : [],
        "childList" : [
          {
            "title" : "201号",
            "isSelected" : false,
            "childList" : []
          },
          {
            "title" : "202号",
            "isSelected" : false,
            "childList" : []
          },
          {
            "title" : "203号",
            "isSelected" : false,
            "childList" : []
          },
        ]
      },
    ];
    List<SCCheckSelectCategoryModel> modelList = [];
    for (var map in list) {
      modelList.add(SCCheckSelectCategoryModel.fromJson(map));
    }
    return modelList;
  }

}