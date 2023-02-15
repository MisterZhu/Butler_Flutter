
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../../../../Utils/sc_utils.dart';
import '../Controller/sc_add_outbound_controller.dart';
import '../View/AddOutbound/sc_add_outbound_view.dart';

/// 新增出库page

class SCAddOutboundPage extends StatefulWidget {
  @override
  SCAddOutboundPageState createState() => SCAddOutboundPageState();
}

class SCAddOutboundPageState extends State<SCAddOutboundPage> {

  /// SCAddOutboundController
  late SCAddOutboundController controller;

  /// SCAddOutboundController - tag
  String controllerTag = '';

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance.getXControllerTag((SCAddOutboundPage).toString());
    controller = Get.put(SCAddOutboundController(), tag: controllerTag);

  }

  @override
  dispose() {
    SCScaffoldManager.instance.deleteGetXControllerTag((SCAddOutboundPage).toString(), controllerTag);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "新增出库",
        centerTitle: true,
        elevation: 0,
        resizeToAvoidBottomInset: false, /// 页面不会随着键盘上移
        body: body());
  }

  Widget body() {
    return GestureDetector(
      onTap: () {
        SCUtils().hideKeyboard(context: context);
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: SCColors.color_F2F3F5,
        child: GetBuilder<SCAddOutboundController>(
            tag: controllerTag,
            init: controller,
            builder: (state) {
              return SCAddOutboundView(state: state,);
            }),
      ),
    );
  }

}



