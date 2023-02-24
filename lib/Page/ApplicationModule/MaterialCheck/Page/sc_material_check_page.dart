import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Constants/sc_key.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../Controller/sc_material_check_controller.dart';
import '../View/MaterialCheck/sc_material_check_view.dart';

/// 盘点任务page

class SCMaterialCheckPage extends StatefulWidget {
  @override
  SCMaterialCheckPageState createState() => SCMaterialCheckPageState();
}

class SCMaterialCheckPageState extends State<SCMaterialCheckPage> with AutomaticKeepAliveClientMixin{

  /// SCMaterialCheckController
  late SCMaterialCheckController controller;

  /// SCMaterialCheckController - tag
  String controllerTag = '';

  /// notify
  late StreamSubscription subscription;

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance
        .getXControllerTag((SCMaterialCheckPage).toString());
    controller = Get.put(SCMaterialCheckController(), tag: controllerTag);
    controller.loadData(isMore: false);
    addNotification();
  }

  @override
  dispose() {
    subscription.cancel();
    SCScaffoldManager.instance.deleteGetXControllerTag((SCMaterialCheckPage).toString(), controllerTag);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "盘点任务", centerTitle: true, elevation: 0, body: body());
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: GetBuilder<SCMaterialCheckController>(
          tag: controllerTag,
          init: controller,
          builder: (state) {
            return SCMaterialCheckView(state: state,);
          }),
    );
  }

  /// 通知
  addNotification() {
    subscription = SCScaffoldManager.instance.eventBus.on().listen((event) {
      String key = event['key'];
      if (key == SCKey.kRefreshMaterialCheckPage) {
        controller.loadData(isMore: false);
      }
    });
  }

  @override
  bool get wantKeepAlive => true;
}
