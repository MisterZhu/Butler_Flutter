import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Utils/sc_utils.dart';
import '../GetXController/sc_login_controller.dart';
import '../View/sc_login_listview.dart';

/// 登录-page

class SCLoginPage extends StatefulWidget {
  @override
  SCLoginPageState createState() => SCLoginPageState();
}

class SCLoginPageState extends State<SCLoginPage> {

  SCLoginController state = Get.put(SCLoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,///页面不会随着键盘上移
      body: body(),
    );
  }

  /// body
  Widget body() {
    return GestureDetector(
      onTap: (){
        SCUtils().hideKeyboard(context: context);
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: SCColors.color_FFFFFF,
        child: SCLoginListView(),
      ),
    );
  }
}