
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../View/sc_enter_house_inspect_view.dart';

/// 入伙验房page

class SCEnterHouseInspectPage extends StatefulWidget {
  @override
  SCEnterHouseInspectPageState createState() => SCEnterHouseInspectPageState();
}

class SCEnterHouseInspectPageState extends State<SCEnterHouseInspectPage> {

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "入伙验房", centerTitle: true, elevation: 0, body: body());
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SCEnterHouseInspectView()
        ],
      ),
    );
  }

}
