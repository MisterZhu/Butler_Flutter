
import 'dart:developer';

import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_default_value.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/Constant/sc_material_entry_enum.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/Model/sc_material_entry_model.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
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
  SCMaterialTaskDetailModel model = SCMaterialTaskDetailModel();

  @override
  onInit() {
    super.onInit();
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
      list = [
      ];
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
      list = [
      ];
    }

    return list;
  }
}
