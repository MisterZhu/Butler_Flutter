import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../../../Skin/Tools/sc_scaffold_manager.dart';
import '../Controller/sc_handle_message_controller.dart';
import '../Controller/sc_message_controller.dart';
import '../View/sc_message_listview.dart';
import '../View/sc_message_top_dialog.dart';
import '../View/sc_message_top_item.dart';

/// 消息page

class SCHandleMessagePage extends StatefulWidget {
  @override
  State<SCHandleMessagePage> createState() => _SCHandleMessagePage();
}

class _SCHandleMessagePage extends State<SCHandleMessagePage> {
  late SCHandleMessageController controller;

  String controllerTag = '';

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance
        .getXControllerTag((SCHandleMessagePage).toString());
    controller = Get.put(SCHandleMessageController(), tag: controllerTag);
    controller.initParams(Get.arguments);
  }

  @override
  dispose() {
    SCScaffoldManager.instance.deleteGetXControllerTag(
        (SCHandleMessagePage).toString(), controllerTag);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "消息",
        centerTitle: true,
        navBackgroundColor: SCColors.color_FFFFFF,
        elevation: 0,
        body: Container(
            width: double.infinity,
            height: double.infinity,
            color: SCColors.color_F2F3F5,
            child: body()));
  }

  /// body
  Widget body() {
    return GetBuilder<SCHandleMessageController>(
      tag: controllerTag,
      init: controller,
      builder: (state) {
        return Column(
          children: [
            title(),
            // time(state:state),
            // contextItem(state:state),
          ],
        );
      },
    );
  }

  Widget title() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('待办通知',
            style: TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w500,
            ))
      ],
    );
  }

  Widget time(state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(state.content,
            style: TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w500,
            ))
      ],
    );
  }

  Widget contextItem() {


    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text('ttttttttt')],
    );
  }

  /// 刷新tabList
  updateTabList() {
    if (SCScaffoldManager.instance.unreadMessageCount > 0) {
      return ['全部', '未读(${SCScaffoldManager.instance.unreadMessageCount})'];
    } else {
      return ['全部', '未读'];
    }
  }
}
