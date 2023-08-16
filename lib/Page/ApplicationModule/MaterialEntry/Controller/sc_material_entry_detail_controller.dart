import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_default_value.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/Constant/sc_material_entry_enum.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/Model/sc_material_entry_model.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../../../../Utils/Date/sc_date_utils.dart';
import '../Model/sc_material_list_model.dart';
import '../View/Detail/sc_material_bottom_view.dart';
import '../Model/sc_material_task_detail_model.dart';

/// 入库详情controller

class SCMaterialEntryDetailController extends GetxController {
  /// 数据是否加载成功
  bool success = false;

  List<SCMaterialEntryModel> dataList = [];

  String id = '';

  /// 状态 单据状态(0：待提交，1：待审批，2：审批中，3：已拒绝，4：已驳回，5：已撤回，6：已入库)
  int status = -1;

  /// 详情model
  SCMaterialTaskDetailModel model = SCMaterialTaskDetailModel();

  /// 定时器
  Timer? timer;

  /// 盘点剩余时间
  int remainingTime = 0;

  /// 已盘点的物资
  List<SCMaterialListModel> checkedList = [];

  /// 未增盘点的物资
  List<SCMaterialListModel> uncheckedList = [];

  /// 是否是固定资产盘点
  bool isFixedCheck = false;

  /// 新提交的数据
  List fixedList = [];

  /// 是否是领料出入库
  bool isLL = false;

  @override
  onInit() {
    super.onInit();
  }

  @override
  onClose() {
    super.onClose();
    closeTimer();
  }

  /// 更新fixedList
  updateFixedList(int index, dynamic data) {
    bool contains = false;
    for (var params in fixedList) {
      int subIndex = params['index'];
      if (index == subIndex) {
        contains = true;
        break;
      }
    }

    if (contains) {
      fixedList[index] = {"index": index, "data" : data};
    } else {
      fixedList.add({"index": index, "data" : data});
    }
    print("fff===$fixedList");
  }

  /// 定时器
  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        remainingTime--;
        update();
      } else {
        closeTimer();
        update();
      }
    });
  }

  /// 关闭定时器
  closeTimer() {
    timer?.cancel();
  }

  /// 入库详情
  loadMaterialEntryDetail() {
    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: SCUrl.kMaterialEntryDetailUrl,
        params: {'wareHouseInId': id},
        success: (value) {
          SCLoadingUtils.hide();
          success = true;
          model = SCMaterialTaskDetailModel.fromJson(value);
          update();
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }

  /// 出库详情
  loadMaterialOutboundDetail() {
    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: SCUrl.kMaterialOutboundDetailUrl,
        params: {'wareHouseOutId': id},
        success: (value) {
          SCLoadingUtils.hide();
          success = true;
          model = SCMaterialTaskDetailModel.fromJson(value);
          update();
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }

  /// 报损详情
  loadMaterialFrmLossDetail() {
    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: SCUrl.kMaterialFrmLossDetailUrl,
        params: {'id': id},
        success: (value) {
          SCLoadingUtils.hide();
          success = true;
          model = SCMaterialTaskDetailModel.fromJson(value);
          update();
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }

  /// 资产报损详情
  loadPropertyFrmLossDetail() {
    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: SCUrl.kPropertyFrmLossDetailUrl,
        params: {'id': id},
        success: (value) {
          SCLoadingUtils.hide();
          success = true;
          model = SCMaterialTaskDetailModel.fromJson(value);
          update();
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }

  /// 盘点详情
  loadMaterialCheckDetail() {
    checkedList.clear();
    uncheckedList.clear();
    SCLoadingUtils.show();
    String url = isFixedCheck ? (SCUrl.kFixedCheckDetailUrl) : (SCUrl.kMaterialCheckDetailUrl + id);
    SCHttpManager.instance.get(
        url: url,
        params: isFixedCheck ? {'id' : id} : null,
        success: (value) {
          log('盘点详情===$value');
          SCLoadingUtils.hide();
          success = true;
          model = SCMaterialTaskDetailModel.fromJson(value);
          if (model.materials != null) {
            List<SCMaterialListModel> list = model.materials!;
            for (int i = 0; i < list.length; i++) {
              SCMaterialListModel model = list[i];
              if (model.checkNum == null) {
                model.localNum = model.number;
                uncheckedList.add(model);
              } else {
                checkedList.add(model);
              }
            }
          }
          int subStatus = model.status ?? -1;
          if (subStatus == 2 || subStatus == 4) {
            String timeString = model.taskEndTime ?? '';
            DateTime endDate = SCDateUtils.stringToDateTime(
                dateString: timeString, formateString: 'yyyy-MM-dd HH:mm:ss');
            remainingTime =
                (endDate.millisecondsSinceEpoch - SCDateUtils.timestamp()) ~/
                    1000;
            closeTimer();
            startTimer();
          }
          update();
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }

  /// 调拨详情
  loadMaterialTransferDetail() {
    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: SCUrl.kMaterialTransferDetailUrl,
        params: {'id': id},
        success: (value) {
          SCLoadingUtils.hide();
          success = true;
          model = SCMaterialTaskDetailModel.fromJson(value);
          update();
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }

  /// 资产维保详情
  loadPropertyMaintenanceDetail() {
    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: SCUrl.kPropertyMaintenanceDetailUrl,
        params: {'id': id},
        success: (value) {
          log('资产维保详情===${jsonEncode(value)}');
          SCLoadingUtils.hide();
          success = true;
          model = SCMaterialTaskDetailModel.fromJson(value);
          update();
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }

  /// 开始处理盘点任务
  startCheckTask({required String id, Function? successHandler}) {
    SCHttpManager.instance.post(
        url: SCUrl.kStartCheckTaskUrl + id,
        params: null,
        success: (value) {
          successHandler?.call();
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }

  /// 暂存或提交盘点任务
  checkSubmit(
      {required int action,
      required String checkId,
      required List materials,
      Function? successHandler}) {
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kCheckSubmitUrl,
        params: {"action": action, "checkId": checkId, "materials": materials},
        success: (value) {
          SCLoadingUtils.hide();
          if (action == 0) {
            SCToast.showTip(SCDefaultValue.checkSaveSuccessTip);
          } else {
            SCToast.showTip(SCDefaultValue.checkSubmitSuccessTip);
          }
          successHandler?.call();
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }

  /// 作废盘点任务
  cancelCheckTask({required String id, Function? successHandler}) {
    SCLoadingUtils.show();
    String url = isFixedCheck ? SCUrl.kCancelFixedCheckTaskUrl : SCUrl.kCancelCheckTaskUrl;
    SCHttpManager.instance.post(
        url: url,
        isQuery: true,
        params: {"id": id},
        success: (value) {
          SCLoadingUtils.hide();
          successHandler?.call();
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }

  /// 删除盘点任务
  deleteCheckTask({required String id, Function? successHandler}) {
    SCLoadingUtils.show();
    String url = isFixedCheck ? SCUrl.kDeleteFixedCheckTaskUrl : SCUrl.kDeleteCheckTaskUrl;
    SCHttpManager.instance.post(
        url: url,
        isQuery: true,
        params: {"id": id},
        success: (value) {
          SCLoadingUtils.hide();
          successHandler?.call();
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }

  /// 出库确认
  outboundConfirm(
      {required String outTime,
      required String remark,
      Function? successHandler}) {
    SCHttpManager.instance.post(
        url: SCUrl.kOutboundConfirmUrl,
        params: {
          "files": "",
          "outId": id,
          "outTime": outTime,
          "remark": remark
        },
        success: (value) {
          SCToast.showTip(SCDefaultValue.outboundConfirmSuccessTip);
          successHandler?.call();
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }

  /// 根据状态获取底部按钮list
  List getBottomList() {
    List list = [];
    if (status == SCMaterialEntryEnum.orderStatusWaitSubmit) {
      list = [
        {
          "type": scMaterialBottomViewType1,
          "title": "编辑",
        },
        {
          "type": scMaterialBottomViewType2,
          "title": "提交",
        },
      ];
    } else if (status == SCMaterialEntryEnum.orderStatusWaitApprove) {
      list = [
        {
          "type": scMaterialBottomViewType2,
          "title": "驳回",
        },
      ];
    } else if (status == SCMaterialEntryEnum.orderStatusApproving) {
      list = [
        {
          "type": scMaterialBottomViewType1,
          "title": "驳回",
        },
        {
          "type": scMaterialBottomViewType1,
          "title": "拒绝",
        },
        {
          "type": scMaterialBottomViewType2,
          "title": "通过",
        },
      ];
    } else if (status == SCMaterialEntryEnum.orderStatusRefuse) {
      list = [];
    } else if (status == SCMaterialEntryEnum.orderStatusReject) {
      list = [
        {
          "type": scMaterialBottomViewType1,
          "title": "编辑",
        },
        {
          "type": scMaterialBottomViewType2,
          "title": "提交",
        },
      ];
    } else if (status == SCMaterialEntryEnum.orderStatusWithdraw) {
      list = [
        {
          "type": scMaterialBottomViewType1,
          "title": "编辑",
        },
        {
          "type": scMaterialBottomViewType2,
          "title": "提交",
        },
      ];
    } else if (status == SCMaterialEntryEnum.orderStatusDone) {
      list = [];
    }

    return list;
  }


  /// 开始处理固定资产盘点任务
  startFixedCheckTask({required String id, Function? successHandler}) {
    SCHttpManager.instance.post(
        url: SCUrl.kStartFixedCheckTaskUrl,
        params: {'id': id},
        isQuery: true,
        success: (value) {
          successHandler?.call();
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }

  /// 暂存或提交固定资产盘点任务
  fixedCheckSubmit(
      {required int action,
        required String checkId,
        required List materials,
        Function? successHandler}) {
    var params = {
      "action": action,
      "assetsCheckRelationEditFS": materials,
      "id": checkId
    };
    SCLoadingUtils.show();
    SCHttpManager.instance.post(
        url: SCUrl.kFixedCheckSubmitUrl,
        params: params,
        success: (value) {
          SCLoadingUtils.hide();
          if (action == 0) {
            SCToast.showTip(SCDefaultValue.checkSaveSuccessTip);
          } else {
            SCToast.showTip(SCDefaultValue.checkSubmitSuccessTip);
          }
          successHandler?.call();
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }
}
