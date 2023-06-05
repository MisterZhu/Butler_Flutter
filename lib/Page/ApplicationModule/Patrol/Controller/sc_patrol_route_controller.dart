
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';

import '../../../../Constants/sc_asset.dart';
import '../../../../Constants/sc_type_define.dart';
import '../Model/sc_form_data_model.dart';

class ScPatrolRouteController extends GetxController{
  /// 当前tab的index
  int currentIndex = 0;

  List tabList = ['全部', '未读'];

    @override
  void onInit() {
    super.onInit();

  }


  late FormDataModel model;

  /// 初始化
  initParams(Map<String, dynamic> params) {
    if (params.isNotEmpty) {
      if (params.containsKey("place")) {
        model = params['place'];
        log('获取model的数据===${model.checkObject?.placeList?.first.tenantId}-- ${model.checkObject?.placeList?.first.policedClassName}');
      }
    }
  }


  /// 更新currentIndex
  updateCurrentIndex(int value) {
    currentIndex = value;
    update;
  }


  //造数据

  List dataList = [];


  /// 更新dataList
  updateDataList() {
    dataList = [
      {'type': SCTypeDefine.SC_PATROL_TYPE_TITLE, 'data': titleList()},
      {'type': SCTypeDefine.SC_PATROL_TYPE_LOG, 'data': logList()},
      {'type': SCTypeDefine.SC_PATROL_TYPE_INFO, 'data': infoList()},

    ];
  }

  List pingfen(){
    List data = [
      {
        "type": 7,
        "title": '合格项',
        "content": "12",
      },
      {
        "type": 7,
        "title": '不合格项',
        "content": "12",
      },
      {
        "type": 7,
        "title": '不涉及项',
        "content": "12",
      }
      , {
        "type": 7,
        "title": '未完成项',
        "content": "12",
      }
    ];
    return List.from(data.map((e) {
      return SCUIDetailCellModel.fromJson(e);
    }));

  }

  /// title-数据源
  List titleList() {
    List data = [
      {"type":1,"title":"剩余时间","time":200345},
      {
        "leftIcon": SCAsset.iconPatrolTask,
        "type": 2,
        "title": "分类名称",
        "content": "处理中"
      },
      {"type": 5, "content": "看发的看发你打开", "maxLength": 10},
      {"type": 7, "title": '任务编号', "content": "001", "maxLength": 2},
      {"type": 7, "title": '任务来源', "content": "002"},
      {"type": 7, "title": '归属项目', "content": "003"},
      {"type": 7, "title": '当前执行人', "content": "004"},
      {"type": 7, "title": '发起时间', "content": "005"},
      {"type": 7, "title": '实际完成时间', "content": "006"}
    ];
    return List.from(data.map((e) {
      return SCUIDetailCellModel.fromJson(e);
    }));
  }

  /// 任务日志
  List logList() {
    List data = [
      {
        "type": 7,
        "title": '任务日志',
        "subTitle": '',
        "content": "",
        "subContent": '',
        "rightIcon": "images/common/icon_arrow_right.png"
      }
    ];
    return List.from(data.map((e) {
      return SCUIDetailCellModel.fromJson(e);
    }));
  }

  /// 任务信息-数据源
  List infoList() {
    List data = [
      {"type": 7, "title": '任务编号', "content": "001", "maxLength": 2},
      {"type": 7, "title": '任务来源', "content": "002"},
      {"type": 7, "title": '归属项目', "content": "003"},
      {"type": 7, "title": '当前执行人', "content": "004"},
      {"type": 7, "title": '发起时间', "content": "005"},
      {"type": 7, "title": '实际完成时间', "content": "006"}
    ];
    return List.from(data.map((e) {
      return SCUIDetailCellModel.fromJson(e);
    }));
  }


}