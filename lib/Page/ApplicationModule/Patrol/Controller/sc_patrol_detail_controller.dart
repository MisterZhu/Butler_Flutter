import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:smartcommunity/Network/sc_http_manager.dart';
import 'package:smartcommunity/Network/sc_url.dart';
import 'package:smartcommunity/Page/ApplicationModule/Patrol/Model/sc_patrol_detail_model.dart';
import '../../../../Constants/sc_type_define.dart';
import '../../MaterialEntry/View/Detail/sc_material_bottom_view.dart';
import '../Model/sc_patrol_task_model.dart';
import '../Model/sc_star_model.dart';
import '../Other/sc_patrol_utils.dart';

/// 巡查详情controller

class SCPatrolDetailController extends GetxController {
  /// 编号
  String procInstId = "";

  /// nodeID
  String nodeId = "";

  /// 是否成功获取数据
  bool getDataSuccess = false;

  /// 详情model
  SCPatrolDetailModel model = SCPatrolDetailModel();

  /// 是否显示更多弹窗，默认不显示
  bool showMoreDialog = false;

  /// 更多按钮list
  List moreButtonList = [];

  /// 底部按钮list
  List bottomButtonList = [];

  List dataList = [];

  int currentIndex = 0;


  StarResultModel? starResultModel;
  String? type;

  /// 更新currentIndex
  updateCurrentIndex(int value) {
    currentIndex = value;
    update;
  }


  @override
  onInit() {
    super.onInit();
  }

  /// 更新弹窗显示状态
  updateMoreDialogStatus() {
    showMoreDialog = !showMoreDialog;
    update();
  }

  /// 初始化
  initParams(Map<String, dynamic> params) {
    if (params.isNotEmpty) {
      if (params.containsKey("procInstId")) {
        procInstId = params['procInstId'];
      }
      if (params.containsKey("nodeId")) {
        nodeId = params['nodeId'];
      }
      if (params.containsKey("type")) {
        type = params['type'];
      }
      log('三巡累行::===$type');
      getDetailData();
    }
  }


  getScoreData(){
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: '${SCUrl.kPatrolScoreUrl}$procInstId\$_\$$nodeId',
        params: {"procInstId":procInstId,"nodeId":nodeId},
        success: (value) {
          log('统计评分::===$value');
          SCLoadingUtils.hide();
          starResultModel = StarResultModel.fromJson(value);
          update();
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }


  List<SCPatrolTaskModel> dataList2 = [];
  int pageNum1 = 1;

  //避免pagenum 混乱导致业务有问题
  loadData2({bool? isMore, Function(bool success, bool last)? completeHandler}) {
    bool isLoadMore = isMore ?? false;
    if (isLoadMore == true) {
      pageNum1++;
    } else {
      pageNum1 = 1;
      SCLoadingUtils.show();
    }
    List fields = [];
    var param2 = {"map":{},"method":1,"name":"wt.appCode","value":"POLICED_WATCH"};
    var param3 = {"map":{},"method":1,"name":"ws.relateProcInstId","value":"$procInstId\$_\$$nodeId"};
    fields.add(param2);
    fields.add(param3);
    var params = {
      "conditions": {"fields": fields},
      "count": true,
      "last": true,
      "orderBy": [],// 排序，正序是 true，倒序是 false
      "pageNum": pageNum1,
      "pageSize": 40
    };
    SCHttpManager.instance.post(
        url: SCUrl.kPatrolUrl,
        params: params,
        success: (value) {
          log('巡查详情===$value');
          SCLoadingUtils.hide();
          if (value is Map) {
            List list = value['records'];
            if (isLoadMore == true) {
              dataList2.addAll(List<SCPatrolTaskModel>.from(list.map((e) => SCPatrolTaskModel.fromJson(e)).toList()));
            } else {
              dataList2 = List<SCPatrolTaskModel>.from(list.map((e) => SCPatrolTaskModel.fromJson(e)).toList());
            }
          } else {
            if (isLoadMore == false) {
              dataList2 = [];
            }
          }
          update();
          bool last = false;
          if (isLoadMore) {
            last = value['last'];
          }
          completeHandler?.call(true, last);
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }



  /// 巡查详情
  getDetailData() {
    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: '${SCUrl.kPatrolDetailUrl}$procInstId\$_\$$nodeId',
        params: null,
        success: (value) {
          log('巡查详情===$value');
          SCLoadingUtils.hide();
          getDataSuccess = true;
          model = SCPatrolDetailModel.fromJson(value);
          updateDataList();
          updateCheckList();
          updateBottomButtonList();
          update();
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }

  reportData(CheckList data,int type){
    SCLoadingUtils.show();
    String str = "";
    if(type == 0){
      str = "QUALIFIED";
    }else{
      str = "UNQUALIFIED";
    }
    var param1 ={
      "checkId":data.id,
      "nodeId":nodeId,
      "procInstId":procInstId,
      "evaluateResult":str,
      "taskId":model.taskId
    };
    SCHttpManager.instance.post(
        url: SCUrl.kPatrolReport,
        params: param1,
        success: (value) {
          log('巡更检查上报===$value');
          SCLoadingUtils.hide();
          update();
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }

  /// 更新底部按钮
  updateBottomButtonList() {
    if ((model.actionVo ?? []).isNotEmpty) {
      List<String> list = model.actionVo!;
      if (list.length == 1) {
        bottomButtonList = [
          {
            "type": scMaterialBottomViewType2,
            "title": list.first,
          }
        ];
      } else if (list.length == 2) {
        bottomButtonList = [
          {
            "type": scMaterialBottomViewType1,
            "title": list[1],
          },
          {
            "type": scMaterialBottomViewType2,
            "title": list.first,
          }
        ];
      } else {
        bottomButtonList = [
          {
            "type": scMaterialBottomViewTypeMore,
            "title": "更多",
          },
          {
            "type": scMaterialBottomViewType1,
            "title": list[1],
          },
          {
            "type": scMaterialBottomViewType2,
            "title": list.first,
          }
        ];
        moreButtonList.clear();
        for (int i = 2; i < list.length; i++) {
          moreButtonList.add(list[i]);
        }
      }
    }
  }

  /// 更新检查项
  updateCheckList() {
    //不是巡更才进行操作
    if(type!="POLICED_WATCH"){
      for (int i = 0; i < dataList.length; i++) {
        var dic = dataList[i];
        if (dic['type'] == SCTypeDefine.SC_PATROL_TYPE_CHECK) {
          dataList.removeAt(i);
        }
      }
      List list = [];
      if ((model.formData?.checkObject?.checkList ?? []).isNotEmpty) {
        for (int i = 0; i < (model.formData?.checkObject?.checkList ?? []).length; i++) {
          CheckList? check = model.formData?.checkObject?.checkList?[i];
          var dic = {
            "type": 7,
            "title": check?.checkContent ?? '',
            "subTitle": '',
            "content": "",
            "subContent": '',
            "rightIcon": "images/common/icon_arrow_right.png"
          };
          list.add(SCUIDetailCellModel.fromJson(dic));
        }
        dataList.insert(1, {'type': SCTypeDefine.SC_PATROL_TYPE_CHECK, 'data': list});
      }
    }
  }

  /// 更新dataList
  updateDataList() {
    if(type=="POLICED_WATCH"){
      dataList = [
        {'type': SCTypeDefine.SC_PATROL_TYPE_TITLE, 'data': titleList()},
        {'type': SCTypeDefine.SC_PATROL_TYPE_TAB, 'data': model.formData?.checkObject?.checkList},
        //{'type':SCTypeDefine.SC_PATROL_TYPE_PINGFEN,'data':pingfen()},
        {'type': SCTypeDefine.SC_PATROL_TYPE_LOG, 'data': logList()},

      ];
    }else{
      dataList = [
        {'type': SCTypeDefine.SC_PATROL_TYPE_TITLE, 'data': titleList()},
        {'type': SCTypeDefine.SC_PATROL_TYPE_LOG, 'data': logList()},
        {'type': SCTypeDefine.SC_PATROL_TYPE_INFO, 'data': infoList()},
      ];
    }

  }

  //ui 给的有问题，后面品质督查的需要用
  List pingfen(){
    List data = [
      {"type": 5, "content": "评分统计", "maxLength": 10},
      {
        "type": 7,
        "title": '合格项',
        "content": starResultModel?.qualifiedCount,
      },
      {
        "type": 7,
        "title": '不合格项',
        "content": starResultModel?.qualifiedCount,
      },
      {
        "type": 7,
        "title": '不涉及项',
        "content":  starResultModel?.unusedCount,
      }
      , {
        "type": 7,
        "title": '未完成项',
        "content":  starResultModel?.qualifiedCount,
      }
    ];
    return List.from(data.map((e) {
      return SCUIDetailCellModel.fromJson(e);
    }));

  }

  /// title-数据源
  List titleList() {
    List data=[];
    if(type=="POLICED_WATCH"){
       data = [
        {
          "leftIcon": SCAsset.iconPatrolTask,
          "type": 2,
          "title": model.categoryName,
          "content": model.customStatus,
          'contentColor': SCPatrolUtils.getStatusColor(model.customStatusInt ?? -1)
        },
         {"type": 5, "content": model.procInstName, "maxLength": 10},
         {"type": 7, "title": '任务地点', "content": model.formData?.checkObject?.place?.placeName ?? ''},
         {"type": 7, "title": '任务编号', "content": model.procInstId, "maxLength": 2},
         {"type": 7, "title": '任务来源', "content": model.instSource},
         {"type": 7, "title": '归属项目', "content": model.procName},
         {"type": 7, "title": '当前执行人', "content": model.assigneeName},
         {"type": 7, "title": '发起时间', "content": model.startTime},
         {"type": 7, "title": '实际完成时间', "content": model.endTime}
      ];
    }else{
      data = [
        {
          "leftIcon": SCAsset.iconPatrolTask,
          "type": 2,
          "title": model.categoryName,
          "content": model.customStatus,
          'contentColor': SCPatrolUtils.getStatusColor(model.customStatusInt ?? -1)
        },
        {"type": 5, "content": model.procInstName, "maxLength": 10},
        {"type": 7, "title": '任务地点', "content": model.formData?.checkObject?.place?.placeName ?? ''},
      ];
    }

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
      {"type": 7, "title": '任务编号', "content": model.procInstId, "maxLength": 2},
      {"type": 7, "title": '任务来源', "content": model.instSource},
      {"type": 7, "title": '归属项目', "content": model.procName},
      {"type": 7, "title": '当前执行人', "content": model.assigneeName},
      {"type": 7, "title": '发起时间', "content": model.startTime},
      {"type": 7, "title": '实际完成时间', "content": model.endTime}
    ];
    return List.from(data.map((e) {
      return SCUIDetailCellModel.fromJson(e);
    }));
  }
}
