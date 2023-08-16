
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../View/sc_formal_house_inspect_detail_listview.dart';

/// 正式验房-详情page

class SCFormalHouseInspectDetailPage extends StatefulWidget {
  @override
  SCFormalHouseInspectDetailState createState() => SCFormalHouseInspectDetailState();
}

class SCFormalHouseInspectDetailState extends State<SCFormalHouseInspectDetailPage> {

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        resizeToAvoidBottomInset: false, /// 页面不会随着键盘上移
        title: "正式验房", centerTitle: true, elevation: 0, body: body());
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: SCFormalHouseInspectDeatilListView(),
    );
  }

}
