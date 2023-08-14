import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:smartcommunity/Network/sc_http_manager.dart';
import 'package:smartcommunity/Network/sc_url.dart';
import 'package:smartcommunity/Page/ApplicationModule/Patrol/Model/sc_patrol_detail_model.dart';
import 'package:smartcommunity/Utils/Date/sc_date_utils.dart';
import 'package:smartcommunity/utils/Router/sc_router_helper.dart';
import '../../../../Constants/sc_key.dart';
import '../../../../Constants/sc_type_define.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Utils/Router/sc_router_path.dart';
import '../../MaterialEntry/View/Detail/sc_material_bottom_view.dart';
import '../Model/sc_form_data_model.dart';
import '../Model/sc_patrol_task_model.dart';
import '../Model/sc_star_model.dart';
import '../Model/sc_task_check_model.dart';
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

  TaskCheckModel? taskCheckModel;
  String? type;

  /// tab-title
  // List<String> tabTitleList = ['检查项', '详细信息', '工单', '日志'];
  Map<String, List> tabBarData = {};

  /// 当前tab-index
  int currentTabIndex = 0;

  /// tabBarView-list
  // List<Widget> tabBarViewList = [];

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
      if (type == "POLICED_WATCH") {
        loadData2(isMore: false);
      }
    }
  }

  getScoreData() {
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: '${SCUrl.kPatrolScoreUrl}$procInstId\$_\$$nodeId',
        params: {"procInstId": procInstId, "nodeId": nodeId},
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
  loadData2(
      {bool? isMore, Function(bool success, bool last)? completeHandler}) {
    bool isLoadMore = isMore ?? false;
    if (isLoadMore == true) {
      pageNum1++;
    } else {
      pageNum1 = 1;
      SCLoadingUtils.show();
    }
    List fields = [];
    var param2 = {
      "map": {},
      "method": 1,
      "name": "wt.appCode",
      "value": "POLICED_WATCH"
    };
    var param3 = {
      "map": {},
      "method": 1,
      "name": "ws.relateProcInstId",
      "value": "$procInstId\$_\$$nodeId"
    };
    fields.add(param2);
    fields.add(param3);
    var params = {
      "conditions": {"fields": fields},
      "count": true,
      "last": true,
      "orderBy": [], // 排序，正序是 true，倒序是 false
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
              dataList2.addAll(List<SCPatrolTaskModel>.from(
                  list.map((e) => SCPatrolTaskModel.fromJson(e)).toList()));
            } else {
              dataList2 = List<SCPatrolTaskModel>.from(
                  list.map((e) => SCPatrolTaskModel.fromJson(e)).toList());
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
        url: '${SCUrl.kPatrolInstAndCurTaskDetail}?procInstId=b6b3e7dd-38ba-11ee-9336-96e30b26cb95',
      params: null,
      success: (value) {
          log('巡查详情===$value');
          SCLoadingUtils.hide();
          getDataSuccess = true;
          model = SCPatrolDetailModel.fromJson(value);
          ///todo 测试数据模拟
          if ((model.nodeBizCfg??{}).isEmpty) {
            model.nodeBizCfg = {
              "POLICED_POINT": {
                "checkHide": true,
                "signIn": true,
              }
            };
          }
          updateDataList();
          updateCheckList();
          //todo 新增工单table
          updateWorkOrderList();
          updateBottomButtonList();
          update();
      },
      failure: (value) {
        SCToast.showTip(value['message']);
      }
    );
    // SCHttpManager.instance.get(
    //     url: '${SCUrl.kPatrolDetailUrl}$procInstId\$_\$$nodeId',
    //     params: null,
    //     success: (value) {
    //       log('巡查详情===$value');
    //       SCLoadingUtils.hide();
    //       getDataSuccess = true;
    //       model = SCPatrolDetailModel.fromJson(value);
    //       updateDataList();
    //       updateCheckList();
    //       updateBottomButtonList();
    //       update();
    //     },
    //     failure: (value) {
    //       SCToast.showTip(value['message']);
    //     });
  }

  reportData(CheckList data, int type) {
    SCLoadingUtils.show();
    String str = "";
    if (type == 0) {
      str = "QUALIFIED";
    } else {
      str = "UNQUALIFIED";
    }
    var param1 = {
      "checkId": data.id,
      "nodeId": nodeId,
      "procInstId": procInstId,
      "evaluateResult": str,
      "taskId": model.taskId
    };
    SCHttpManager.instance.post(
        url: SCUrl.kPatrolReport,
        params: param1,
        success: (value) {
          log('巡更检查上报===$value');
          SCLoadingUtils.hide();
          SCScaffoldManager.instance.eventBus
              .fire({'key': SCKey.kRefreshPatrolDetailPage});
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

  /// 更新检查项    todo 如果是巡查组任务不限时检查项显示组任务
  updateCheckList() {
    //不是巡更才进行操作
    if (type != "POLICED_WATCH") {

      if ((model.formData?.checkObject?.planPolicedType??'') == '2') {
        ///巡查组任务
        tabBarData['巡查点任务'] = model.formData!.checkObject!.placeList??[];
      } else {
        ///点位任务
        for (int i = 0; i < dataList.length; i++) {
          var dic = dataList[i];
          if (dic['type'] == SCTypeDefine.SC_PATROL_TYPE_CHECK) {
            dataList.removeAt(i);
          }
        }
        List list = [];
        if ((model.formData?.checkObject?.checkList ?? []).isNotEmpty) {
          for (int i = 0;
          i < (model.formData?.checkObject?.checkList ?? []).length;
          i++) {
            CheckList? check = model.formData?.checkObject?.checkList?[i];
            var dic = {
              "type": 7,
              "title": check?.checkContent ?? '',
              "subTitle": '',
              "content": setUIState(check?.evaluateResult ?? ''),
              "subContent": '',
              "rightIcon": "images/common/icon_arrow_right.png"
            };
            list.add(SCUIDetailCellModel.fromJson(dic));
          }
          dataList.insert(
              1, {'type': SCTypeDefine.SC_PATROL_TYPE_CHECK, 'data': list});
          tabBarData['检查项'] = list;
        }

      }

    } else {
      List list = [];
      if ((model.formData?.checkObject?.checkList ?? []).isNotEmpty) {
        dataList.insert(1, {
          'type': SCTypeDefine.SC_PATROL_TYPE_TAB,
          'data': model.formData?.checkObject?.checkList
        });
      } else {
        dataList
            .insert(1, {'type': SCTypeDefine.SC_PATROL_TYPE_TAB, 'data': list});
      }
    }
  }

  loadData(String checkId, SCPatrolDetailModel model, List imageList,
      String comments, String type) {
    SCLoadingUtils.show();
    String str = "";
    if (type == "0") {
      str = "QUALIFIED";
    } else {
      str = "UNQUALIFIED";
    }
    var param1 = {
      "checkId": checkId,
      "nodeId": model.nodeId,
      "procInstId": model.procInstId,
      "evaluateResult": str,
      "taskId": model.taskId,
      "comments": comments,
      "attachments": transferImage(imageList ?? [])
    };
    SCHttpManager.instance.post(
        url: SCUrl.kPatrolReport,
        params: param1,
        success: (value) {
          SCLoadingUtils.hide();
          SCScaffoldManager.instance.eventBus
              .fire({'key': SCKey.kRefreshPatrolDetailPage});
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }

  loadCheckCellDetailData(
      SCPatrolDetailModel patrolDetailModel, String checkId) {
    var param1 = {
      "checkId": checkId,
      "nodeId": nodeId,
      "procInstId": procInstId,
      "taskId": model.taskId
    };
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.taskCheck,
        params: param1,
        success: (value) {
          SCLoadingUtils.hide();
          CellDetailList cellDetailList = CellDetailList.fromJson(value);
          taskCheckModel = TaskCheckModel(
              checkId: checkId,
              nodeId: nodeId,
              procInstId: procInstId,
              taskId: model.taskId);
          SCRouterHelper.pathPage(SCRouterPath.patrolCheckCellDetailPage, {
            'cellDetailList': cellDetailList,
            'taskCheckModel': taskCheckModel,
            'patrolDetailModel': patrolDetailModel
          });
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }

  /// 图片转换
  List transferImage(List imageList) {
    List list = [];
    for (var params in imageList) {
      var newParams = {
        "id": SCDateUtils.timestamp(),
        "isImage": true,
        "name": params['name'],
        "fileKey": params['fileKey']
      };
      list.add(newParams);
    }
    return list;
  }

  setUIState(String rst) {
    if (rst.isNotEmpty) {
      if (rst == "QUALIFIED") {
        return "正常";
      }
      return "异常";
    }
    return "未查";
  }

  /// 更新dataList
  updateDataList() {
    if (type == "POLICED_WATCH") {
      dataList = [
        {'type': SCTypeDefine.SC_PATROL_TYPE_TITLE, 'data': titleList()},
        {'type': SCTypeDefine.SC_PATROL_TYPE_LOG, 'data': logList()},
      ];

    } else {
      var ll = logList();
      var il= infoList();
      dataList = [
        {'type': SCTypeDefine.SC_PATROL_TYPE_TITLE, 'data': titleList()},
        {'type': SCTypeDefine.SC_PATROL_TYPE_LOG, 'data': ll},
        {'type': SCTypeDefine.SC_PATROL_TYPE_INFO, 'data': il},
      ];
      tabBarData['日志'] = ll;
      tabBarData['详细信息'] = il;
    }
  }

  //ui 给的有问题，后面品质督查的需要用
  List pingfen() {
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
        "content": starResultModel?.unusedCount,
      },
      {
        "type": 7,
        "title": '未完成项',
        "content": starResultModel?.qualifiedCount,
      }
    ];
    return List.from(data.map((e) {
      return SCUIDetailCellModel.fromJson(e);
    }));
  }

  /// title-数据源
  List titleList() {
    List data = [];
    if (type == "POLICED_WATCH") {
      data = [
        {
          "leftIcon": SCAsset.iconPatrolTask,
          "type": 2,
          "title": model.categoryName,
          "content": model.customStatus,
          'contentColor':
              SCPatrolUtils.getStatusColor(model.customStatusInt ?? -1)
        },
        {"type": 5, "content": model.procInstName, "maxLength": 10},
        {
          "type": 7,
          "title": '任务地点',
          "content": model.formData?.checkObject?.place?.placeName ?? ''
        },
        {
          "type": 7,
          "title": '任务编号',
          "content": model.procInstId,
          "maxLength": 2
        },
        {"type": 7, "title": '任务来源', "content": model.instSource},
        {"type": 7, "title": '归属项目', "content": model.procName},
        {"type": 7, "title": '当前执行人', "content": model.assigneeName},
        {"type": 7, "title": '发起时间', "content": model.startTime},
        {"type": 7, "title": '实际完成时间', "content": model.endTime}
      ];
    } else {
      data = [
        {
          "leftIcon": SCAsset.iconPatrolTask,
          "type": 2,
          "title": model.categoryName,
          "content": model.customStatus,
          'contentColor':
              SCPatrolUtils.getStatusColor(model.customStatusInt ?? -1)
        },
        {"type": 5, "content": model.procInstName, "maxLength": 10},
        {
          "type": 7,
          "title": '任务地点',
          "content": model.formData?.checkObject?.place?.placeName ?? ''
        },
        //todo 新增字段
        {
          "type": 7,
          "title": '巡查位置',
          "content": '待定字段',
        },
        {
          "type": 7,
          "title": '所属项目',
          "content": '待定字段',
        },
        {
          "type": 7,
          "title": '要求完成时间',
          "content": '待定字段',
        },
        {
          "type": 7,
          "title": '当前执行人',
          "content": '待定字段',
        },
        {
          "type": 7,
          "title": '签到方式',
          "content": model.formData?.checkObject?.execWay?? '',
        },
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
    if ((model.formData?.checkObject?.device?.deviceLocation ?? '').isNotEmpty) {
      data.insert(0, {
        "type": 7,
        "title": '安装位置',
        "content": model.formData?.checkObject?.device?.deviceLocation ?? '',
        "maxLength": 20
      });
    }
    if ((model.formData?.checkObject?.device?.deviceCode ?? '').isNotEmpty) {
      data.insert(0, {
        "type": 7,
        "title": '设备编号',
        "content": model.formData?.checkObject?.device?.deviceCode ?? '',
        "maxLength": 20
      });
    }
    return List.from(data.map((e) {
      return SCUIDetailCellModel.fromJson(e);
    }));
  }

  void updateWorkOrderList() {

   List workOrderList =  [
     {
       "appName":"WORK_ORDER",
       "type":"WORK_ORDER",
       "subType":"92a57e0b78914650b963700dbe21070c",
       "taskId":"2e0450c9fe54a62cf47c1fe6af3972bc",
       "id":"KX3I7okBxegE9LiUs969",
       "code":"2e0450c9fe54a62cf47c1fe6af3972bc",
       "title":"HBGD2023081320043617",
       "content":"测试1072",
       "statusName":"超时未接收",
       "statusValue":"3",
       "handleUserIds":null,
       "handledUserIds":null,
       "followUserIds":null,
       "hallUserIds":"2 66a1c2ca-7dd8-408d-8178-fc1a9cbb538f 11260464097201 11483229267803 12249663007416 12488231398973 12783670496132 12801754193015 128433248332100 129036278319108 129036370972109 12957221362650 1298132554102 1298290236861 13086327251325 13087736508423 13129506627801 13180876914114 13214497770579 13283331756405 13371126612244 13389615028441 13396165636352 13404341602459 13438606190914 13535971383821 13551001044125 13562912676527 13727213990021 10726085735001 11133507283301 11165656987604 12194637939502 12678150286604 129053102381101 12913558309702 12958111739953 1303316830730 13085264618622 13085280456623 13086338437126 13094601802027 13138712348107 13343926013503 13388590678148 13396169402653 13396173381954 13499876101015 13537593614324 13614123582723 11047513294001 12834335433911 12834356817712 13181852160702 13579468526922 13588000923201 13620545652627 13682351970824 13519965218807 13499869341514 13214103442577",
       "beginTime":"2023-08-13 20:04:36",
       "endTime":"2023-08-13 21:04:36",
       "createTime":"2023-08-13 20:04:36",
       "creator":"14021071599602",
       "operator":null,
       "creatorName":"周万盛",
       "operatorName":null,
       "tenantId":"eb1e1ad8-85af-42d0-ba3c-21229be19009",
       "tenantName":null,
       "communityId":"007a4b7d22c6e1c346e5af65f9e7b0e1",
       "communityName":null,
       "operationList":null,
       "contact":"周万盛",
       "contactInform":"18257587762",
       "contactAddress":"慧享小区-益乐-20-1-401",
       "typeDesc":"工单任务",
       "subTypeDesc":null
     }
   ];
   tabBarData['工单'] = workOrderList;

  }
}
