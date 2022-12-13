import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartcommunity/Constants/sc_default_value.dart';
import 'package:smartcommunity/Constants/sc_key.dart';
import 'package:smartcommunity/Page/Login/Privacy/GetXController/sc_base_privacy_controller.dart';
import 'package:smartcommunity/Page/Login/Privacy/View/Privacy/sc_privacy_alert.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import 'package:smartcommunity/Utils/Router/sc_router_path.dart';

/// 用户协议与隐私政策弹窗-page

class SCPrivacyAlertPage extends StatefulWidget {
  @override
  SCPrivacyAlertPageState createState() => SCPrivacyAlertPageState();
}

class SCPrivacyAlertPageState extends State<SCPrivacyAlertPage> {
  SCBasePrivacyController state = Get.put(SCBasePrivacyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// body
  Widget body() {
    return Stack(
      children: [maskItem(), privacyAlertItem()],
    );
  }

  /// 半透明背景蒙层
  Widget maskItem() {
    return Container(
      width: double.infinity,
      color: SCColors.color_000000.withOpacity(0.5),
    );
  }

  /// 协议弹窗
  Widget privacyAlertItem() {
    return GetBuilder<SCBasePrivacyController>(builder: (state) {
      return SCBasicPrivacyAlert(
        isAgree: state.isAgree,
        titleString: state.title,
        contentString: state.content,
        descriptionString: state.description,
        cancelAction: () {
          SCToast.showTip(SCDefaultValue.canUseAppMessage);
        },
        sureAction: () async {
          if (state.isAgree == true) {
            SharedPreferences preference =
                await SharedPreferences.getInstance();
            preference.setBool(SCKey.isShowPrivacyAlert, false);
            SCRouterHelper.pathOffAllPage(SCRouterPath.loginPath, null);
          } else {
            SCToast.showTip(SCDefaultValue.agreeUserAgreementMessage);
          }
        },
        agreeAction: () {
          state.updateAgreementState();
        },
        agreementDetailAction: (String? title, String url) {
          SCRouterHelper.pathPage(SCRouterPath.webViewPath,
              {"title": title, "url": url, "removeLoginCheck": true});
        },
      );
    });
  }
}
