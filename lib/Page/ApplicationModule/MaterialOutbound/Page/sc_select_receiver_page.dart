
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../../../../Utils/sc_utils.dart';
import '../Controller/sc_select_receiver_controller.dart';
import '../Model/sc_receiver_model.dart';
import '../View/AddOutbound/sc_receiver_listview.dart';

/// 选择领用人page

class SCSelectReceiverPage extends StatefulWidget {
  @override
  SCSelectReceiverPageState createState() => SCSelectReceiverPageState();
}

class SCSelectReceiverPageState extends State<SCSelectReceiverPage> {

  SCReceiverModel receiverModel = SCReceiverModel();

  /// SCSelectReceiverController
  late SCSelectReceiverController controller;

  /// SCSelectReceiverController - tag
  String controllerTag = '';

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance
        .getXControllerTag((SCSelectReceiverPage).toString());
    controller = Get.put(SCSelectReceiverController(), tag: controllerTag);
    controller.loadDataList(isMore: false);
    var arguments = Get.arguments;
    if (arguments != null) {
      receiverModel = arguments['receiverModel'];
    }
  }

  @override
  dispose() {
    SCScaffoldManager.instance.deleteGetXControllerTag((SCSelectReceiverPage).toString(), controllerTag);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "选择领用人",
        centerTitle: true,
        elevation: 0,
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
        child: GetBuilder<SCSelectReceiverController>(
            tag: controllerTag,
            init: controller,
            builder: (state) {
              return SCReceiverListView(
                currentModel: receiverModel,
                list: controller.dataList,
                tapAction: (model) {
                  receiverModel = model;
                  SCRouterHelper.back({'receiverModel': model});
              }, callAction: (mobile) {

              },
              );
            }),
      ),
    );
  }

}



