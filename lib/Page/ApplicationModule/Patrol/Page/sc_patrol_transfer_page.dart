import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Constants/sc_key.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../Controller/sc_patrol_controller.dart';
import '../Controller/sc_patrol_transfer_controller.dart';
import '../View/Patrol/sc_patrol_view.dart';
import '../View/Transfer/sc_patrol_transfer_view.dart';

/// 巡查-转派page

class SCPatrolTransferPage extends StatefulWidget {
  @override
  SCPatrolTransferPageState createState() => SCPatrolTransferPageState();
}

class SCPatrolTransferPageState extends State<SCPatrolTransferPage> with AutomaticKeepAliveClientMixin{

  /// SCPatrolTransferController
  late SCPatrolTransferController controller;

  /// SCPatrolTransferController - tag
  String controllerTag = '';

  /// notify
  late StreamSubscription subscription;

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance.getXControllerTag((SCPatrolTransferPage).toString());
    controller = Get.put(SCPatrolTransferController(), tag: controllerTag);
  }

  @override
  dispose() {
    subscription.cancel();
    SCScaffoldManager.instance.deleteGetXControllerTag(pageName(), controllerTag);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "转派", centerTitle: true, elevation: 0, body: body());
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: GetBuilder<SCPatrolTransferController>(
          tag: controllerTag,
          init: controller,
          builder: (state) {
            return SCPatrolTransferView(controller: controller,);
          }),
    );
  }

  /// pageName
  String pageName() {
    return (SCPatrolTransferPage).toString();
  }

  @override
  bool get wantKeepAlive => true;

}
