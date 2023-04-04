import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../../../Skin/Tools/sc_scaffold_manager.dart';
import '../Controller/sc_message_controller.dart';
import '../View/sc_message_listview.dart';
import '../View/sc_message_top_dialog.dart';
import '../View/sc_message_top_item.dart';

/// 消息page

class SCMessagePage extends StatefulWidget {
  @override
  SCMessagePageState createState() => SCMessagePageState();
}

class SCMessagePageState extends State<SCMessagePage> with SingleTickerProviderStateMixin {

  /// SCMessageController
  late SCMessageController controller;

  /// SCMessageController - tag
  String controllerTag = '';


  late TabController tabController;

  List tabList = ['全部', '未读'];

  @override
  initState() {
    super.initState();
    tabController = TabController(length: tabList.length, vsync: this);
    controllerTag = SCScaffoldManager.instance.getXControllerTag((SCMessagePage).toString());
    controller = Get.put(SCMessageController(), tag: controllerTag);
    tabController.addListener(() {
      if (controller.currentIndex != tabController.index) {
        if (controller.showMoreDialog == true) {
          controller.updateMoreDialogStatus();
        }
      }
    });
  }

  @override
  dispose() {
    SCScaffoldManager.instance.deleteGetXControllerTag((SCMessagePage).toString(), controllerTag);
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
          child: body()
        )
    );
  }

  /// body
  Widget body() {
    return GetBuilder<SCMessageController>(
      tag: controllerTag,
      init: controller,
      builder: (state) {
        return Stack(
          alignment: Alignment.topRight,
          children: [
            contentItem(),
            Offstage(
              offstage: !state.showMoreDialog,
              child: SCMessageTopDialog(
                list: const ['全部已读', '全部清除'],
                tapAction: (index) {
                  if (index == 0) {

                  } else if (index == 1) {

                  }
                  controller.updateMoreDialogStatus();
                },),
            ),
          ],
        );
      },
    );
  }

  Widget contentItem() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SCMessageTopItem(tabController: tabController, titleList: tabList, moreAction: () {
          controller.updateMoreDialogStatus();
        },),
        Expanded(child: TabBarView(
            controller: tabController,
            children: [
              SCMessageListView(state: controller, type: 0,),
              SCMessageListView(state: controller, type: 1,),
            ])
        ),
      ],
    );
  }
}

