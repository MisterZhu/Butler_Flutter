import 'package:flutter/material.dart';
import 'package:smartcommunity/Skin/View/sc_custom_scaffold.dart';

/// 用户协议与隐私政策弹窗-page

class SCPrivacyAlertPage extends StatefulWidget {
  @override
  SCPrivacyAlertPageState createState() => SCPrivacyAlertPageState();
}

class SCPrivacyAlertPageState extends State<SCPrivacyAlertPage> {
  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(body: body());
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
    );
  }
}