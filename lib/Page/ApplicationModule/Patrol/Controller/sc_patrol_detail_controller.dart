import 'dart:developer';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:smartcommunity/Network/sc_http_manager.dart';
import 'package:smartcommunity/Network/sc_url.dart';
import 'package:smartcommunity/Page/ApplicationModule/Patrol/Model/sc_patrol_detail_model.dart';
import '../../WarningCenter/Other/sc_warning_utils.dart';

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
      {"leftIcon":SCAsset.iconPatrolTask, "type": 2, "title": model.categoryName, "content": model.customStatus, 'contentColor': SCWarningCenterUtils.getStatusColor(model.customStatusInt ?? -1)},
      {
        "type": 5,
        "content": model.procInstName,
        "maxLength": 10
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
      {"type": 7, "title": '任务编号', "content": model.procInstId},
      {"type": 7, "title": '任务来源', "content": model.instSource},
      {"type": 7, "title": '发起时间', "content": model.startTime},
      {"type": 7, "title": '实际完成时间', "content": model.endTime}
    ];
    return List.from(data.map((e) {
      return SCUIDetailCellModel.fromJson(e);
    }));
  }

  /// 处理任务
  dealTask(String action) {
    var params = {
      "action": action,
      "comment": {
        "attachments": [
          {
            "id": "",
            "isImage": true,
            "name": "",
            "suffix": "",
            "url": ""
          }
        ],
        "text": ""
      },
      "instanceId": procInstId,
      "taskId": taskId
    };
    SCHttpManager.instance.post(url: SCUrl.kDealTaskUrl, params: params, success: (value){
      log('处理任务===$value');
      SCLoadingUtils.hide();

      update();
    }, failure: (value){
      SCToast.showTip(value['message']);
    });
  }

}