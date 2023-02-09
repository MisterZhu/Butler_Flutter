import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/Controller/sc_material_entry_controller.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../View/MaterialEntry/sc_material_entry_view.dart';

/// 物资入库page

class SCMaterialEntryPage extends StatefulWidget {
  @override
  SCMaterialEntryPageState createState() => SCMaterialEntryPageState();
}

class SCMaterialEntryPageState extends State<SCMaterialEntryPage> {

  /// SCMaterialEntryController
  late SCMaterialEntryController entryController;

  /// SCMaterialEntryController - tag
  String entryControllerTag = '';

  @override
  initState() {
    super.initState();
    entryControllerTag = SCScaffoldManager.instance
        .getXControllerTag((SCMaterialEntryPage).toString());
    entryController =
        Get.put(SCMaterialEntryController(), tag: entryControllerTag);
  }

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
      child: GetBuilder<SCMaterialEntryController>(
          tag: entryControllerTag,
          init: entryController,
          builder: (state) {
            return SCMaterialEntryView();
          }),
    );
  }

  /// pageName
  String pageName() {
    return (SCMaterialEntryPage).toString();
  }
}
