import 'dart:developer';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:smartcommunity/Network/sc_http_manager.dart';
import 'package:smartcommunity/Network/sc_url.dart';
import 'package:smartcommunity/Page/ApplicationModule/Patrol/Model/sc_patrol_detail_model.dart';
import 'package:smartcommunity/Utils/Date/sc_date_utils.dart';
import '../../../../Constants/sc_type_define.dart';
import '../../MaterialEntry/View/Detail/sc_material_bottom_view.dart';
import '../Other/sc_patrol_utils.dart';

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

  /// 是否显示更多弹窗，默认不显示
  bool showMoreDialog = false;

  /// 更多按钮list
  List moreButtonList = [];

  /// 底部按钮list
  List bottomButtonList = [];

  /// 检查项list
  List checkList = [];

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
      if (params.containsKey("taskId")) {
        taskId = params['taskId'];
      }
      getDetailData();
    }
  }

  /// 巡查详情
  getDetailData() {
    var params = {"procInstId": procInstId, "taskId": taskId};
    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: SCUrl.kPatrolDetailUrl,
        params: params,
        success: (value) {
          log('巡查详情===$value');
          SCLoadingUtils.hide();
          getDataSuccess = true;
          model = SCPatrolDetailModel.fromJson(value);
          updateDataList();
          if ((model.formData?.checkObject?.checkList ?? []).isNotEmpty) {
            updateCheckList();
          }
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
      checkList.add(SCUIDetailCellModel.fromJson(dic));
    }
    dataList.insert(1, {'type': SCTypeDefine.SC_PATROL_TYPE_CHECK, 'data': checkList});
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
  /// action:操作类型
  /// dealChannel：处理来源，1-判断是否需要扫码,2-处理操作
  /// mode：选择的节点
  /// content：内容
  /// imageList：图片
  /// code：二维码
  dealTask(
      {required String action,
      int? dealChannel,
      String? node,
      String? content,
      List? imageList,
      String? code}) {
    var comment = {};
    if (action == "handle") {
      // 处理
      if (dealChannel == 2) {
        comment = {
          "attachments": transferImage(imageList ?? []),
          "text": content
        };
      } else {}
    } else if (action == "transfer") {
      // 转派
      comment = {
        "attachments": transferImage(imageList ?? []),
        "text": content
      };
    } else if (action == "close") {
      // 关闭
      comment = {
        "attachments": transferImage(imageList ?? []),
        "text": content
      };
    } else if (action == "comment") {
      // 添加日志
      comment = {
        "attachments": transferImage(imageList ?? []),
        "text": content
      };
    } else if (action == "recall") {
      // 回退
      comment = {
        "attachments": transferImage(imageList ?? []),
        "text": content
      };
    }
    var params = {
      "action": action,
      "comment": comment,
      "formData": {"code": code ?? ''},
      "instanceId": procInstId,
      "taskId": taskId
    };
    SCHttpManager.instance.post(
        url: SCUrl.kDealTaskUrl,
        params: params,
        success: (value) {
          log('处理任务===$value');
          SCLoadingUtils.hide();

          update();
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
        "url": params['fileKey']
      };
      list.add(newParams);
    }
    return list;
  }
}
