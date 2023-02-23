import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/Model/sc_material_list_model.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/Detail/sc_material_bottom_view.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/Detail/sc_material_detail_listview.dart';
import 'package:smartcommunity/Skin/View/sc_custom_scaffold.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import 'package:smartcommunity/Utils/Router/sc_router_path.dart';
import '../../../../Constants/sc_enum.dart';
import '../../../../Constants/sc_key.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../MaterialEntry/Controller/sc_material_entry_controller.dart';
import '../../MaterialEntry/Controller/sc_material_entry_detail_controller.dart';
import '../../MaterialEntry/Model/sc_material_task_detail_model.dart';
import '../Controller/sc_material_frmLoss_controller.dart';


/// 报损详情

class SCMaterialFrmLossDetailPage extends StatefulWidget {
  @override
  SCMaterialFrmLossDetailPageState createState() =>
      SCMaterialFrmLossDetailPageState();
}

class SCMaterialFrmLossDetailPageState extends State<SCMaterialFrmLossDetailPage> {
  /// SCMaterialEntryDetailController
  late SCMaterialEntryDetailController controller;

  /// SCMaterialEntryDetailController - tag
  String controllerTag = '';

  /// 是否允许编辑
  bool canEdit = false;

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance.getXControllerTag((SCMaterialFrmLossDetailPage).toString());
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
      controller.loadMaterialFrmLossDetail();
    }
  }

  @override
  dispose() {
    SCScaffoldManager.instance.deleteGetXControllerTag((SCMaterialFrmLossDetailPage).toString(), controllerTag);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(title: '报损详情', body: body());
  }

  /// body
  body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: Column(
        children: [
          Expanded(child: topView()),
          bottomView()
        ],
      ),
    );
  }

  /// topView
  Widget topView() {
    return GetBuilder<SCMaterialEntryDetailController>(
        tag: controllerTag,
        init: controller,
        builder: (state) {
          return SCMaterialDetailListView(
            state: controller,
            type: SCWarehouseManageType.frmLoss,
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
          return Offstage(
            offstage: !canEdit,
            child: SCMaterialDetailBottomView(
              list: list,
              onTap: (value) {
                if (value == '编辑') {
                  editAction();
                } else if(value == '提交') {
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
  editAction() async{
    String wareHouseName = controller.model.wareHouseName ?? '';
    String wareHouseId = controller.model.wareHouseId ?? '';
    String typeName = controller.model.typeName ?? '';
    int type = controller.model.type ?? 0;
    String remark = controller.model.remark ?? '';
    String id = controller.model.id ?? '';
    List<SCMaterialListModel> materials = controller.model.materials ?? [];
    for (SCMaterialListModel model in materials) {
      model.localNum = model.number ?? 1;
      model.isSelect = true;
      model.name = model.materialName ?? '';
      //model.id = model.materialId;
    }

    List<Files> filesList = controller.model.files ?? [];
    List files = [];
    for (Files file in filesList) {
      files.add(file.toJson());
    }
    SCRouterHelper.pathPage(SCRouterPath.addFrmLossPage, {
      'isEdit' : true,
      'data' : materials,
      "wareHouseName" : wareHouseName,
      "wareHouseId" : wareHouseId,
      "typeName" : typeName,
      "type" : type,
      "remark" : remark,
      "reportUserName": controller.model.reportUserName ?? '',
      "reportUserId": controller.model.reportUserId ?? '',
      "reportOrgName": controller.model.reportOrgName ?? '',
      "reportOrgId": controller.model.reportOrgId ?? '',
      "reportTime": controller.model.reportTime ?? '',
      "files": files,
      "id" : id
    })?.then((value) {
      controller.loadMaterialFrmLossDetail();
    });
  }

  /// 提交
  submitAction() {
    SCMaterialFrmLossController materialFrmLossController = SCMaterialFrmLossController();
    materialFrmLossController.submit(id: controller.id, completeHandler: (bool success){
      SCScaffoldManager.instance.eventBus
          .fire({'key': SCKey.kRefreshMaterialFrmLossPage});
      SCRouterHelper.back( null);
    });
  }
}
