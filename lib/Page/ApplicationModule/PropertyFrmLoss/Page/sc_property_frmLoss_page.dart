import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Constants/sc_key.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../Controller/sc_property_frmLoss_controller.dart';
import '../View/sc_property_frmLoss_view.dart';

/// 资产报损page

class SCPropertyFrmLossPage extends StatefulWidget {
  @override
  SCPropertyFrmLossPageState createState() => SCPropertyFrmLossPageState();
}

class SCPropertyFrmLossPageState extends State<SCPropertyFrmLossPage> with AutomaticKeepAliveClientMixin{

  /// SCPropertyFrmLossController
  late SCPropertyFrmLossController controller;

  /// SCMaterialEntryController - tag
  String controllerTag = '';

  /// notify
  late StreamSubscription subscription;

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance
        .getXControllerTag((SCPropertyFrmLossPage).toString());
    controller = Get.put(SCPropertyFrmLossController(), tag: controllerTag);
    controller.loadData(isMore: false);
    addNotification();
  }

  @override
  dispose() {
    subscription.cancel();
    SCScaffoldManager.instance.deleteGetXControllerTag((SCPropertyFrmLossPage).toString(), controllerTag);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "资产报损", centerTitle: true, elevation: 0, body: body());
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: GetBuilder<SCPropertyFrmLossController>(
          tag: controllerTag,
          init: controller,
          builder: (state) {
            return SCPropertyFrmLossView(state: state,);
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

  @override
  bool get wantKeepAlive => true;
}
