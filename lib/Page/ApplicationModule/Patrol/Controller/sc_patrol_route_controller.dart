
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

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


}