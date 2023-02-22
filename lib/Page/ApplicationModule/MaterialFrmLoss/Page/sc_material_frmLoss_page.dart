import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/Controller/sc_material_entry_controller.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Constants/sc_key.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../Controller/sc_material_frmLoss_controller.dart';
import '../View/MaterialFrmLoss/sc_material_frmLoss_view.dart';

/// 物资报损page

class SCMaterialFrmLossPage extends StatefulWidget {
  @override
  SCMaterialFrmLossPageState createState() => SCMaterialFrmLossPageState();
}

class SCMaterialFrmLossPageState extends State<SCMaterialFrmLossPage> {

  /// SCMaterialFrmLossController
  late SCMaterialFrmLossController controller;

  /// SCMaterialEntryController - tag
  String controllerTag = '';

  /// notify
  late StreamSubscription subscription;

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance
        .getXControllerTag((SCMaterialFrmLossPage).toString());
    controller = Get.put(SCMaterialFrmLossController(), tag: controllerTag);
    controller.loadData(isMore: false);
    addNotification();
  }

  @override
  dispose() {
    subscription.cancel();
    SCScaffoldManager.instance.deleteGetXControllerTag((SCMaterialFrmLossPage).toString(), controllerTag);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "物资报损", centerTitle: true, elevation: 0, body: body());
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: GetBuilder<SCMaterialFrmLossController>(
          tag: controllerTag,
          init: controller,
          builder: (state) {
            return SCMaterialFrmLossView(state: state,);
          }),
    );
  }

  /// 通知
  addNotification() {
    subscription = SCScaffoldManager.instance.eventBus.on().listen((event) {
      String key = event['key'];
      if (key == SCKey.kRefreshMaterialFrmLossPage) {
        controller.loadData(isMore: false);
      }
    });
  }
}
