
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../View/sc_house_inspect_form_listview.dart';

/// 验房单page

class SCHouseInspectFormPage extends StatefulWidget {
  @override
  SCHouseInspectFormPageState createState() => SCHouseInspectFormPageState();
}

class SCHouseInspectFormPageState extends State<SCHouseInspectFormPage> {

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "验房单", centerTitle: true, elevation: 0, body: body());
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: SCHouseInspectFormListView(),
    );
  }

}
