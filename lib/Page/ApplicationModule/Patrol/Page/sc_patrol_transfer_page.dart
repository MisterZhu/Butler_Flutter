import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_default_value.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../../HouseInspect/View/sc_bottom_button_item.dart';
import '../../MaterialOutbound/Controller/sc_select_department_controller.dart';
import '../Controller/sc_patrol_transfer_controller.dart';
import '../View/Transfer/sc_patrol_transfer_view.dart';

/// 巡查-转派page

class SCPatrolTransferPage extends StatefulWidget {
  @override
  SCPatrolTransferPageState createState() => SCPatrolTransferPageState();
}

class SCPatrolTransferPageState extends State<SCPatrolTransferPage>
    with AutomaticKeepAliveClientMixin {
  /// SCPatrolTransferController
  late SCPatrolTransferController controller;

  /// SCPatrolTransferController - tag
  String controllerTag = '';

  /// SCSelectDepartmentController
  late SCSelectDepartmentController selectDepartmentController;

  /// SCSelectDepartmentController - tag
  String selectDepartmentControllerTag = '';

  /// notify
  late StreamSubscription subscription;

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance
        .getXControllerTag((SCPatrolTransferPage).toString());
    controller = Get.put(SCPatrolTransferController(), tag: controllerTag);
    selectDepartmentControllerTag = SCScaffoldManager.instance
        .getXControllerTag((SCPatrolTransferPage).toString());
    selectDepartmentController = Get.put(SCSelectDepartmentController(),
        tag: selectDepartmentControllerTag);
    selectDepartmentController.tag = selectDepartmentControllerTag;
  }

  @override
  dispose() {
    subscription.cancel();
    SCScaffoldManager.instance
        .deleteGetXControllerTag(pageName(), controllerTag);
    SCScaffoldManager.instance
        .deleteGetXControllerTag(pageName(), selectDepartmentControllerTag);
    controller.dispose();
    selectDepartmentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "转派", centerTitle: true, elevation: 0, body: body());
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: Column(
        children: [contentView(), bottomView()],
      ),
    );
  }

  /// content
  Widget contentView() {
    return Expanded(
        child: GetBuilder<SCPatrolTransferController>(
            tag: controllerTag,
            init: controller,
            builder: (state) {
              return SCPatrolTransferView(
                controller: controller,
                selectDepartmentController: selectDepartmentController,
              );
            }));
  }

  /// 底部按钮
  Widget bottomView() {
    return SCBottomButtonItem(
      list: const ["确定"],
      buttonType: 0,
      tapAction: () {
        if (checkForm()) {
          SCRouterHelper.back({
            "departmentId": controller.departmentId,
            "userId": controller.userId
          });
        }
      },
    );
  }

  /// 检查表单
  bool checkForm() {
    if (controller.departmentId.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectPatrolDepartment);
      return false;
    }
    if (controller.userId.isEmpty) {
      SCToast.showTip(SCDefaultValue.selectPatrolUser);
      return false;
    }
    return true;
  }

  /// pageName
  String pageName() {
    return (SCPatrolTransferPage).toString();
  }

  @override
  bool get wantKeepAlive => true;
}
