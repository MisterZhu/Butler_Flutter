import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Constants/sc_default_value.dart';
import '../../../../Constants/sc_key.dart';
import '../../../../Utils/JPush/sc_jpush.dart';
import '../../../../Utils/Router/sc_router_helper.dart';
import '../../../../Utils/Router/sc_router_path.dart';
import '../View/Privacy/sc_privacy_alert.dart';

class PrivacyAlertNewPage extends StatefulWidget {
  const PrivacyAlertNewPage({Key? key}) : super(key: key);

  @override
  State<PrivacyAlertNewPage> createState() => _PrivacyAlertNewPageState();
}

class _PrivacyAlertNewPageState extends State<PrivacyAlertNewPage> {

  /// 标题
  String title = '';

  /// 正文
  String content = '';

  /// 描述
  String description = '';

  /// 同意
  String agreeString = '同意';

  /// 用户协议
  String userAgreement = '';

  /// 用户协议url
  String userAgreementUrl = '';

  /// 和
  String andString = '和';

  /// 隐私政策
  String privacyPolicy = '隐私政策';

  /// 隐私政策url
  String privacyPolicyUrl = '';

  /// 是否同意相关协议，默认不同意
  bool isAgree = false;

  @override
  void initState(){
    title = '用户协议和隐私政策';
    content = '尊敬的用户：\n        您好！感谢您信任${SCDefaultValue.appName}APP，为了更好的保障您的个人权益，在您使用我们的产品和服务前，请仔细读并理解《用户协议》和《隐私政策》的相关条款，其中重点条款内容已为您加粗标注，以便您了解自己的权利。为了提供更好的服务功能，我们会根据您的授权，收集和使用对应的必要信息，同时您有权拒绝授权。我们深知个人信息及隐私的重要性，如涉及到您个人敏感信息，只有在您确认同意后，我们才会进行收集。同时，未经您授权同意，我们不会将您的信息直接获取、共享于第三方或用于其他用途。';
    description = "${SCDefaultValue.appName}APP用户协议和隐私政策已于2022年9月更新";
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("我是隐私协议"),),
      body: privacyAlertItem(),
    );
  }


  /// body
  Widget body() {
    return Stack(
      children: [privacyAlertItem()],
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
      return SCBasicPrivacyAlert(
        isAgree: isAgree,
        titleString: title,
        contentString: content,
        descriptionString: description,
        cancelAction: () {
          SCToast.showTip(SCDefaultValue.canUseAppMessage);
        },
        sureAction: () async {
          if (isAgree == true) {
            SharedPreferences preference = await SharedPreferences.getInstance();
            preference.setBool(SCKey.isShowPrivacyAlert, false);
            SCJPush.initJPush();
            SCRouterHelper.pathOffAllPage(SCRouterPath.loginPath, null);
          } else {
            SCToast.showTip(SCDefaultValue.agreeUserAgreementMessage);
          }
        },
        agreeAction: () {
          setState((){
            isAgree = !isAgree;
          });
        },
        agreementDetailAction: (String? title, String url) {
          SCRouterHelper.pathPage(SCRouterPath.webViewPath,
              {"title": title, "url": url, "removeLoginCheck": true});
        },
      );
  }

}
