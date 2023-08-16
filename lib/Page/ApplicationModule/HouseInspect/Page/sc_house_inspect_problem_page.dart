
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../../../../Utils/sc_utils.dart';
import '../View/Problems/sc_house_inspect_problem_listview.dart';

/// 验房-问题page

class SCHouseInspectProblemPage extends StatefulWidget {
  @override
  SCHouseInspectProblemPageState createState() => SCHouseInspectProblemPageState();
}

class SCHouseInspectProblemPageState extends State<SCHouseInspectProblemPage> {

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "问题",
        centerTitle: true,
        elevation: 0,
        resizeToAvoidBottomInset: false, /// 页面不会随着键盘上移
        body: body());
  }

  /// body
  Widget body() {
    return GestureDetector(
      onTap: () {
        SCUtils().hideKeyboard(context: context);
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: SCColors.color_F2F3F5,
        child: SCHouseInspectProblemListView(),
      ),
    );
  }

}
