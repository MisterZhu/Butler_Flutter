import 'dart:developer';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:smartcommunity/Network/sc_http_manager.dart';
import 'package:smartcommunity/Network/sc_url.dart';
import 'package:smartcommunity/Page/ApplicationModule/Patrol/Model/sc_patrol_detail_model.dart';
import '../../../../Constants/sc_type_define.dart';
import '../../MaterialEntry/View/Detail/sc_material_bottom_view.dart';
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
      getDetailData();
    }
  }

  /// 巡查详情
  getDetailData() {
    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: SCUrl.kPatrolDetailUrl+procInstId+'\$_\$'+nodeId,
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
        for (int i = 2; i < list.length; i++) {
          moreButtonList.add(list[i]);
        }
      }
    }
  }

  /// 更新检查项
  updateCheckList() {
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

  /// 更新dataList
  updateDataList() {
    dataList = [
      {'type': SCTypeDefine.SC_PATROL_TYPE_TITLE, 'data': titleList()},
      {'type': SCTypeDefine.SC_PATROL_TYPE_LOG, 'data': logList()},
      {'type': SCTypeDefine.SC_PATROL_TYPE_INFO, 'data': infoList()}
    ];
  }

  /// title-数据源
  List titleList() {
    List data = [
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
      {"type": 7, "title": '发起时间', "content": model.startTime},
      {"type": 7, "title": '实际完成时间', "content": model.endTime}
    ];
    return List.from(data.map((e) {
      return SCUIDetailCellModel.fromJson(e);
    }));
  }
}
