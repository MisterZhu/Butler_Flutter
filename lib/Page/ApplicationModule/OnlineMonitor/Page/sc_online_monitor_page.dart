import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../Controller/sc_online_monitor_controller.dart';
import '../View/sc_online_monitor_view.dart';

/// 在线监控page

class SCOnlineMonitorPage extends StatefulWidget {
  @override
  SCOnlineMonitorPageState createState() => SCOnlineMonitorPageState();
}

class SCOnlineMonitorPageState extends State<SCOnlineMonitorPage> with AutomaticKeepAliveClientMixin{
  /// SCOnlineMonitorController
  late SCOnlineMonitorController controller;

  /// SCMaterialEntryController - tag
  String controllerTag = '';


  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance
        .getXControllerTag((SCOnlineMonitorPage).toString());
    controller = Get.put(SCOnlineMonitorController(), tag: controllerTag);
    controller.loadData(isMore: false);

  }

  @override
  dispose() {
    SCScaffoldManager.instance
        .deleteGetXControllerTag((SCOnlineMonitorPage).toString(), controllerTag);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "在线监控", centerTitle: true, elevation: 0, body: body());
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: GetBuilder<SCOnlineMonitorController>(
          tag: controllerTag,
          init: controller,
          builder: (state) {
            return SCOnlineMonitorView(
              state: state,
            );
          }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
