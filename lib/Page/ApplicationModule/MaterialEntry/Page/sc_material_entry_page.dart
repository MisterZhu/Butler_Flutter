import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../View/MaterialEntry/sc_material_entry_view.dart';

/// 物资入库page

class SCMaterialEntryPage extends StatefulWidget {
  @override
  SCMaterialEntryPageState createState() => SCMaterialEntryPageState();
}

class SCMaterialEntryPageState extends State<SCMaterialEntryPage> {
  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "物资入库", centerTitle: true, elevation: 0, body: body());
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: SCMaterialEntryView(),
    );
  }

}
