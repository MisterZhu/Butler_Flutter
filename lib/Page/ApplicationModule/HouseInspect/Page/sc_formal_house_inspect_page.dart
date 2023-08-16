
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../../../../Utils/sc_utils.dart';
import '../View/sc_formal_house_inspect_listview.dart';

/// 正式验房page

class SCFormalHouseInspectPage extends StatefulWidget {
  @override
  SCFormalHouseInspectPageState createState() => SCFormalHouseInspectPageState();
}

class SCFormalHouseInspectPageState extends State<SCFormalHouseInspectPage> {

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "正式验房",
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
        child: SCFormalHouseInspectListView(),
      ),
    );
  }
}
