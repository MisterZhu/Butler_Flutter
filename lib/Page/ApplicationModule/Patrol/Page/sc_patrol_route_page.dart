import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/Patrol/Controller/sc_patrol_route_controller.dart';

import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../../../Message/Page/sc_message_page.dart';
import '../View/Patrol/sc_common_top_item.dart';
import '../View/Patrol/sc_patrol_route_list_view.dart';


class ScPatrolRoutePage extends StatefulWidget {
  const ScPatrolRoutePage({Key? key}) : super(key: key);

  @override
  State<ScPatrolRoutePage> createState() => _ScPatrolRoutePageState();
}

class _ScPatrolRoutePageState extends State<ScPatrolRoutePage> with SingleTickerProviderStateMixin{

  late ScPatrolRouteController controller;

  String controllerTag = '';

  late TabController tabController;

  List tabList = ['巡更任务', '异常报事'];

  RefreshController refreshController1 = RefreshController(initialRefresh: false);

  RefreshController refreshController2 = RefreshController(initialRefresh: false);



  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabList.length, vsync: this);
    controllerTag = SCScaffoldManager.instance.getXControllerTag((ScPatrolRoutePage).toString());
    controller = Get.put(ScPatrolRouteController(), tag: controllerTag);
    controller.initParams(Get.arguments);
    tabController.addListener(() {
      if (controller.currentIndex != tabController.index) {
        controller.updateCurrentIndex(tabController.index);
      }
    });
  }

  @override
  dispose() {
    SCScaffoldManager.instance.deleteGetXControllerTag((ScPatrolRoutePage).toString(), controllerTag);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "路线详情",
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
    return GetBuilder<ScPatrolRouteController>(
      tag: controllerTag,
      init: controller,
      builder: (state) {
        return Stack(
          alignment: Alignment.topRight,
          children: [
            contentItem(),
          ],
        );
      },
    );
  }

  Widget contentItem() {

    List list1 = controller.titleList();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SCDetailCell(list: list1,),
        const SizedBox(height: 10,),
        CommonTabTopItem(tabController: tabController, titleList: tabList),
        Expanded(child: TabBarView(
            controller: tabController,
            children:  [
              SCPatrolRouteListView(state: controller,  refreshController: refreshController1),
              SCPatrolRouteListView(state: controller,  refreshController: refreshController2),
            ])
        ),
      ],
    );
  }


  /// cell1
  Widget cell1(List list) {
    return SCDetailCell(
      list: list,
      leftAction: (String value, int index) {},
      rightAction: (String value, int index) {},
      imageTap: (int imageIndex, List imageList, int index) {
        // SCImagePreviewUtils.previewImage(imageList: [imageList[index]]);
      },
    );
  }




}


/*class ScPatrolRoutePage extends GetView<ScPatrolRouteController> with SingleTickerProviderStateMixin{

   ScPatrolRoutePage({Key? key}) : super(key: key);

  late TabController tabController;


  @override
  Widget build(BuildContext context) {
    tabController = TabController(length: controller.tabList.length, vsync: this);
    return SCCustomScaffold(
        title: "路线详情", centerTitle: true, elevation: 0, body: body());
  }




  Widget body(){
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: Center(
        child: Text("ddd"),
      )
    );
  }


}*/
