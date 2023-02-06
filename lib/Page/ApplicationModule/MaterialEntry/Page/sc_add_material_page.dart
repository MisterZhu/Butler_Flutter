
import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../View/AddMaterial/sc_add_material_view.dart';

/// 添加物资page

class SCAddMaterialPage extends StatefulWidget {
  @override
  SCAddMaterialPageState createState() => SCAddMaterialPageState();
}

class SCAddMaterialPageState extends State<SCAddMaterialPage> {

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "添加物资",
        centerTitle: true,
        elevation: 0,
        body: body());
  }

  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: SCAddMaterialView(),
    );
  }

}



