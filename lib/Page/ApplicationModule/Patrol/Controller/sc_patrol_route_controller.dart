
import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';

import '../../../../Constants/sc_asset.dart';
import '../../../../Constants/sc_type_define.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../Model/sc_form_data_model.dart';
import '../Model/sc_patrol_detail_model.dart';
import '../Model/sc_patrol_task_model.dart';

class ScPatrolRouteController extends GetxController{
  /// 当前tab的index
  int currentIndex = 0;

  int pageNum = 1;

  int pageNum1 = 1;


  /// 编号
  String procInstId = "";

  /// nodeID
  String nodeId = "";


  @override
  void onInit() {
    super.onInit();

  }


  FormDataModel model1 = FormDataModel();

  SCPatrolDetailModel model = SCPatrolDetailModel();


  /// 初始化
  initParams(Map<String, dynamic> params) {
    if (params.isNotEmpty) {
      if (params.containsKey("place")) {
        model1 = params['place'];
        log('获取model的数据===${json.encode(model1.checkObject)}');
      }
      if (params.containsKey("procInstId")) {
        log('获取model的数据=11111==${params['procInstId']}');
        procInstId = params['procInstId'];
      }
      if (params.containsKey("nodeId")) {
        log('获取model的数据22222===${params['nodeId']}');
        nodeId = params['nodeId'];
      }
    }

    loadData(isMore: false);
    loadData2(isMore: false);
  }

  List<SCPatrolTaskModel> dataList1 = [];
  List<SCPatrolTaskModel> dataList2 = [];


  loadData({bool? isMore, Function(bool success, bool last)? completeHandler}) {
    bool isLoadMore = isMore ?? false;
    if (isLoadMore == true) {
      pageNum++;
    } else {
      pageNum = 1;
      SCLoadingUtils.show();
    }
    List fields = [];
    var param1 ={"map":{},"method":1,"name":"ws.type","value":1};
    var param2 = {"map":{},"method":1,"name":"wt.appCode","value":"POLICED_WATCH"};
    var param3 = {"map":{},"method":1,"name":"ws.mainProcInstId","value":"$procInstId\$_\$$nodeId"};
    fields.add(param1);
    fields.add(param2);
    fields.add(param3);
    var params = {
      "conditions": {"fields": fields},
      "count": true,
      "last": true,
      "orderBy": [],// 排序，正序是 true，倒序是 false
      "pageNum": pageNum,
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
              dataList1.addAll(List<SCPatrolTaskModel>.from(list.map((e) => SCPatrolTaskModel.fromJson(e)).toList()));
            } else {
              dataList1 = List<SCPatrolTaskModel>.from(list.map((e) => SCPatrolTaskModel.fromJson(e)).toList());
            }
          } else {
            if (isLoadMore == false) {
              dataList1 = [];
            }
          }
          model = SCPatrolDetailModel.fromJson(value);
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
          model = SCPatrolDetailModel.fromJson(value);
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
      {'type': SCTypeDefine.SC_PATROL_TYPE_LOG, 'data': logList()}

    ];
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