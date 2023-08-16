import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/Model/sc_material_list_model.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/Detail/sc_material_bottom_view.dart';
import 'package:smartcommunity/Skin/View/sc_custom_scaffold.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import 'package:smartcommunity/Utils/Router/sc_router_path.dart';
import '../../../../Constants/sc_enum.dart';
import '../../../../Constants/sc_key.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../MaterialEntry/Controller/sc_material_entry_detail_controller.dart';
import '../../MaterialEntry/Model/sc_material_task_detail_model.dart';
import '../../MaterialEntry/View/Detail/sc_material_detail_listview.dart';
import '../Controller/sc_property_frmLoss_controller.dart';
import '../Model/sc_property_list_model.dart';

/// 固定资产报损详情

class SCPropertyFrmLossDetailPage extends StatefulWidget {
  @override
  SCPropertyFrmLossDetailPageState createState() =>
      SCPropertyFrmLossDetailPageState();
}

class SCPropertyFrmLossDetailPageState
    extends State<SCPropertyFrmLossDetailPage> {
  /// SCMaterialEntryDetailController
  late SCMaterialEntryDetailController controller;

  /// SCMaterialEntryDetailController - tag
  String controllerTag = '';

  /// 是否允许编辑
  bool canEdit = false;

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance
        .getXControllerTag((SCPropertyFrmLossDetailPage).toString());
    controller = Get.put(SCMaterialEntryDetailController(), tag: controllerTag);
    Map<String, dynamic> params = Get.arguments;
    if (params.isNotEmpty) {
      var id = params['id'];
      if (id != null) {
        controller.id = id;
      }
      if (params.containsKey("canEdit")) {
        canEdit = params['canEdit'];
      }
      controller.loadPropertyFrmLossDetail();
    }
  }

  @override
  dispose() {
    SCScaffoldManager.instance.deleteGetXControllerTag(
        (SCPropertyFrmLossDetailPage).toString(), controllerTag);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(title: '资产报损详情', body: body());
  }

  /// body
  body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: Column(
        children: [Expanded(child: topView()), bottomView()],
      ),
    );
  }

  /// topView
  Widget topView() {
    return GetBuilder<SCMaterialEntryDetailController>(
        tag: controllerTag,
        init: controller,
        builder: (state) {
          return Offstage(
            offstage: !controller.success,
            child: SCMaterialDetailListView(
              state: controller,
              type: SCWarehouseManageType.propertyFrmLoss,
              isProperty: true,
            ),
          );
        });
  }

  /// bottomView
  Widget bottomView() {
    List list = [
      {
        "type": scMaterialBottomViewType1,
        "title": "编辑",
      },
      {
        "type": scMaterialBottomViewType2,
        "title": "提交",
      },
    ];
    return GetBuilder<SCMaterialEntryDetailController>(
        tag: controllerTag,
        init: controller,
        builder: (state) {
          bool offstage = true;
          if (controller.success) {
            offstage = !canEdit;
          }
          return Offstage(
            offstage: offstage,
            child: SCMaterialDetailBottomView(
              list: list,
              onTap: (value) {
                if (value == '编辑') {
                  editAction();
                } else if (value == '提交') {
                  submitAction();
                }
                // } else if (value == "拒绝") {
                //   SCUtils.getCurrentContext(completionHandler: (BuildContext context) {
                //     SCDialogUtils().showCustomBottomDialog(
                //         isDismissible: true,
                //         context: context,
                //         widget: SCRejectAlert(
                //           title: '审批拒绝',
                //           reason: '拒绝理由',
                //           tagList: ['流程不合理', '图片不清晰', '名称错误', '审批不合规'],
                //           showNode: false,
                //         ));
                //   });
                // }
              },
            ),
          );
        });
  }

  /// 编辑
  editAction() async {
    String typeName = controller.model.typeName ?? '';
    int type = controller.model.type ?? 0;
    String remark = controller.model.remark ?? '';
    String id = controller.model.id ?? '';
    List<SCMaterialListModel> assets = controller.model.assets ?? [];
    for (SCMaterialListModel model in assets) {
      model.isSelect = true;
    }

    List<Files> filesList = controller.model.files ?? [];
    List files = [];
    for (Files file in filesList) {
      files.add(file.toJson());
    }
    SCRouterHelper.pathPage(SCRouterPath.addPropertyFrmLossPage, {
      'isEdit': true,
      'data': assets,
      "typeName": typeName,
      "type": type,
      "remark": remark,
      "fetchOrgName": controller.model.fetchOrgName ?? '',
      "fetchOrgId": controller.model.fetchOrgId ?? '',
      "reportUserName": controller.model.reportUserName ?? '',
      "reportUserId": controller.model.reportUserId ?? '',
      "reportOrgName": controller.model.reportOrgName ?? '',
      "reportOrgId": controller.model.reportOrgId ?? '',
      "reportTime": controller.model.reportTime ?? '',
      "files": files,
      "id": id,
      'number': controller.model.number ?? ''
    })?.then((value) {
      controller.loadPropertyFrmLossDetail();
    });
  }

  /// 提交
  submitAction() {
    SCPropertyFrmLossController materialFrmLossController = SCPropertyFrmLossController();
    materialFrmLossController.submit(
        id: controller.id,
        completeHandler: (bool success) {
          SCScaffoldManager.instance.eventBus
              .fire({'key': SCKey.kRefreshPropertyFrmLossPage});
          SCRouterHelper.back(null);
        });
  }
}
