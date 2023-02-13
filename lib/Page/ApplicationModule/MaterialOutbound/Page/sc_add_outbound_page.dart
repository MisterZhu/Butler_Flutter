
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
  late SCAddOutboundController addController;

  /// SCAddEntryController - tag
  String addControllerTag = '';

  @override
  initState() {
    super.initState();
    addControllerTag = SCScaffoldManager.instance.getXControllerTag((SCAddOutboundPage).toString());
    addController = Get.put(SCAddOutboundController(), tag: addControllerTag);

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
            tag: addControllerTag,
            init: addController,
            builder: (state) {
              return SCAddOutboundView(state: state,);
            }),
      ),
    );
  }

}



