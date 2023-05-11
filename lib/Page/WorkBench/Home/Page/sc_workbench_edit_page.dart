import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';

import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../../../ApplicationModule/MaterialEntry/View/Detail/sc_material_bottom_view.dart';
import '../GetXController/sc_workbench_edit_controller.dart';
import '../View/Edit/sc_workbench_edit_view.dart';

/// 编辑工作台page

class SCWorkBenchEditPage extends StatefulWidget {
  @override
  SCWorkBenchEditPageState createState() => SCWorkBenchEditPageState();
}

class SCWorkBenchEditPageState extends State<SCWorkBenchEditPage> {

  /// SCWorkBenchEditController
  late SCWorkBenchEditController controller;

  /// SCWorkBenchEditController - tag
  String controllerTag = '';

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance.getXControllerTag((SCWorkBenchEditPage).toString());
    controller = Get.put(SCWorkBenchEditController(), tag: controllerTag);
    controller.initData(Get.arguments ?? {});
  }

  @override
  dispose() {
    SCScaffoldManager.instance.deleteGetXControllerTag((SCWorkBenchEditPage).toString(), controllerTag);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: '编辑工作台',
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              contentView(),
              bottomView()
            ],
          ),
        ));
  }

  /// content
  Widget contentView() {
    return Expanded(child: SCWorkBenchEditView(
      state: controller,
    ));
  }

  /// bottom
  Widget bottomView() {
    return SCMaterialDetailBottomView(
      list: const [{
        "type": scMaterialBottomViewType2,
        "title": "确定",
      }],
      onTap: (value) {
        sureAction();
      },
    );
  }

  /// 确定
  sureAction() {
    print("我的任务===${controller.myTaskTitleList}");
    SCRouterHelper.back({'data': controller.myTaskTitleList});
  }
}