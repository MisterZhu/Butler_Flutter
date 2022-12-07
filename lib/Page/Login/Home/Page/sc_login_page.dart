import 'package:flutter/material.dart';
import 'package:smartcommunity/Skin/View/sc_custom_scaffold.dart';

/// 登录-page

class SCLoginPage extends StatefulWidget {
  @override
  SCLoginPageState createState() => SCLoginPageState();
}

class SCLoginPageState extends State<SCLoginPage> {
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