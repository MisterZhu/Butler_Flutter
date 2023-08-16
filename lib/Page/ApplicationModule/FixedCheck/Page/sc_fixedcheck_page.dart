import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Constants/sc_key.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../Controller/sc_fixedcheck_controller.dart';
import '../View/Check/sc_fixedcheck_view.dart';

/// 固定资产盘点page

class SCFixedCheckPage extends StatefulWidget {
  @override
  SCFixedCheckPageState createState() => SCFixedCheckPageState();
}

class SCFixedCheckPageState extends State<SCFixedCheckPage>
    with AutomaticKeepAliveClientMixin {
  /// SCFixedCheckController
  late SCFixedCheckController controller;

  /// SCFixedCheckController - tag
  String controllerTag = '';

  /// notify
  late StreamSubscription subscription;

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance
        .getXControllerTag((SCFixedCheckPage).toString());
    controller = Get.put(SCFixedCheckController(), tag: controllerTag);
    controller.loadData(isMore: false);
    addNotification();
  }

  @override
  dispose() {
    subscription.cancel();
    SCScaffoldManager.instance.deleteGetXControllerTag(
        (SCFixedCheckPage).toString(), controllerTag);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "固定资产盘点", centerTitle: true, elevation: 0, body: body());
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: GetBuilder<SCFixedCheckController>(
          tag: controllerTag,
          init: controller,
          builder: (state) {
            return SCFixedCheckView(
              state: controller,
            );
          }),
    );
  }

  /// 通知
  addNotification() {
    subscription = SCScaffoldManager.instance.eventBus.on().listen((event) {
      String key = event['key'];
      if (key == SCKey.kRefreshFixedCheckPage) {
        controller.loadData(isMore: false);
      }
    });
  }

  @override
  bool get wantKeepAlive => true;
}
