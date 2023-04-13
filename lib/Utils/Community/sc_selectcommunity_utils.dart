import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';

import '../../../../Network/sc_http_manager.dart';
import '../../../../Network/sc_url.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import 'package:get/get.dart';

import '../../Page/Mine/Home/Model/sc_community_alert_model.dart';
import '../../Page/Mine/Home/Model/sc_community_common_model.dart';
import '../../Page/Mine/Home/View/SelectCommunityAlert/sc_community_alertview.dart';

/// 选择项目

class SCSelectCommunityUtils {
  /// 选择项目弹窗
  static showCommunityAlert(
      Function(SCCommunityCommonModel model)? resultHandler) {
    loadCommunity(success: (List<SCCommunityCommonModel> list) {
      if (Get.context != null) {
        SCDialogUtils().showCustomBottomDialog(
            context: Get.context!,
            isDismissible: true,
            widget: SCSelectCommunityAlert(
              list: list,
              title: '请选择项目',
              onSure: (int index) {
                Navigator.of(Get.context!).pop();
                resultHandler?.call(list[index]);
              },
            ));
      }
    });
  }

  /// 获取项目列表
  static loadCommunity({Function(List<SCCommunityCommonModel> list)? success}) {
    SCLoadingUtils.show();
    SCHttpManager.instance.get(
        url: SCUrl.kCommunityListUrl,
        params: {
          "tenantId":
              (SCScaffoldManager.instance.defaultConfigModel?.tenantId ?? '')
        },
        success: (value) {
          SCLoadingUtils.hide();
          List<SCCommunityCommonModel> titleList = [];
          List<SCCommunityAlertModel> subCommunityList = [];
          for (var map in value) {
            titleList
                .add(SCCommunityCommonModel.fromJson({"title": map['name']}));
            subCommunityList.add(SCCommunityAlertModel.fromJson(map));
          }
          success?.call(titleList);
        },
        failure: (value) {
          SCToast.showTip(value['message']);
        });
  }
}
