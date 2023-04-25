import 'dart:developer';

import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:smartcommunity/Network/sc_http_manager.dart';
import 'package:smartcommunity/Network/sc_url.dart';
import 'package:smartcommunity/Page/ApplicationModule/Patrol/Model/sc_patrol_detail_model.dart';

/// 巡查详情controller

class SCPatrolDetailController extends GetxController {

  /// 编号
  String procInstId = "";

  /// 任务ID
  String taskId = "";

  /// 是否成功获取数据
  bool getDataSuccess = false;

  /// 详情model
  SCPatrolDetailModel model = SCPatrolDetailModel();

  @override
  onInit() {
    super.onInit();
  }

  /// 初始化
  initParams(Map<String, dynamic> params) {
    if (params.isNotEmpty) {
      if (params.containsKey("procInstId")) {
        procInstId = params['procInstId'];
      }
      if (params.containsKey("taskId")) {
        taskId = params['taskId'];
      }
      getDetailData();
    }
  }

  /// 巡查详情
  getDetailData() {
    var params = {
      "procInstId" : procInstId,
      "taskId": taskId
    };
    SCLoadingUtils.show();
    SCHttpManager.instance.get(url: SCUrl.kPatrolDetailUrl, params: params, success: (value){
      log('巡查详情===$value');
      SCLoadingUtils.hide();
      getDataSuccess = true;
      model = SCPatrolDetailModel.fromJson(value);
      update();
    }, failure: (value){
      SCToast.showTip(value['message']);
    });
  }

  /// title-数据源
  List list1() {
    List data = [
      {"type": 2, "title": '标题标题标题', "content": "状态状态状态"},
      {
        "type": 3,
      },
      {
        "type": 4,
        "tags": [
          {
            'title': '标签1',
          },
          {
            'title': '标签2',
          },
          {
            'title': '标签3',
          },
        ]
      },
      {
        "type": 5,
        "content": "这是一条主要内容这是一条主要内容这是一条主要内容这是一条主要内容这是一条主要内容这是一条主要内容",
        "maxLength": 10
      },
      {
        "type": 6,
        "images": ['', '']
        // "images": [SCAsset.iconMaterialEmpty, SCAsset.iconMaterialIcon]
      },
      {"type": 7, "title": '标题标题标题', "content": "123"},
      {
        "type": 7,
        "title": '标题标题标题',
        "subTitle": '标题标题标题',
        "content": "内容内容内容",
        "subContent": '15100000000'
      },
    ];
    return List.from(data.map((e) {
      return SCUIDetailCellModel.fromJson(e);
    }));
  }

  List list2() {
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

  /// content-数据源
  List list3() {
    List data = [
      {"type": 7, "title": '标题标题标题', "content": "状态状态状态", "rightIcon": SCAsset.iconNewCopy},
      {"type": 7, "title": '标题标题标题', "content": "状态状态状态", "rightIcon": SCAsset.iconContactPhone},
      {"type": 7, "title": '标题标题标题', "content": "2023-01-01"},
      {"type": 7, "title": '标题标题标题', "content": "内容内容内容"},
      {"type": 7, "title": '标题标题标题', "content": "内容内容内容"},
    ];
    return List.from(data.map((e) {
      return SCUIDetailCellModel.fromJson(e);
    }));
  }

}