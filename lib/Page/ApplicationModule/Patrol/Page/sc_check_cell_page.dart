import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/Patrol/Controller/sc_check_cell_controller.dart';
import 'package:smartcommunity/Page/ApplicationModule/Patrol/View/Patrol/sc_check_cell_view.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';

/// 巡查检查项编辑页面

class SCCheckCellEditPage extends StatefulWidget {

  const SCCheckCellEditPage({Key? key}) : super(key: key);

  @override
  SCCheckCellEditPageState createState() => SCCheckCellEditPageState();
}

class SCCheckCellEditPageState extends State<SCCheckCellEditPage>
    with AutomaticKeepAliveClientMixin {
  /// SCPatrolController
  late SCCheckCellEditController controller;

  /// SCWarningCenterController - tag
  String controllerTag = '';

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance
        .getXControllerTag((SCCheckCellEditPage).toString());
    controller = Get.put(SCCheckCellEditController(), tag: controllerTag);
    controller.initParams(Get.arguments);
  }

  @override
  dispose() {
    SCScaffoldManager.instance
        .deleteGetXControllerTag(pageName(), controllerTag);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: '检查',
        centerTitle: true,
        elevation: 0,
        resizeToAvoidBottomInset: false,
        body: body());
  }

  /// body
  Widget body() {
    return Container(
        width: double.infinity,
        // height: double.infinity,
        color: SCColors.color_F2F3F5,
        child: SCCheckCellView(state: controller));
  }

  /// pageName
  String pageName() {
    return (SCCheckCellEditPage).toString();
  }

  @override
  bool get wantKeepAlive => true;
}
