import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_default_value.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/Model/sc_material_entry_model.dart';
import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../Model/sc_material_task_detail_model.dart';

/// 入库详情controller

class SCMaterialEntryDetailController extends GetxController {
  /// 数据是否加载成功
  bool success = false;

  List<SCMaterialEntryModel> dataList = [];

  String id = '';

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
}
