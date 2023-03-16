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
import '../Controller/sc_material_entry_controller.dart';
import '../Controller/sc_material_entry_detail_controller.dart';

/// 入库详情

class SCMaterialEntryDetailPage extends StatefulWidget {
  @override
  SCMaterialEntryDetailPageState createState() =>
      SCMaterialEntryDetailPageState();
}

class SCMaterialEntryDetailPageState extends State<SCMaterialEntryDetailPage> {
  /// SCMaterialEntryDetailController
  late SCMaterialEntryDetailController controller;

  /// SCMaterialEntryDetailController - tag
  String controllerTag = '';

  /// 是否允许编辑
  bool canEdit = false;

  /// 是否隐藏底部按钮
  bool hideBottomBtn = false;

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance
        .getXControllerTag((SCMaterialEntryDetailPage).toString());
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
      if (params.containsKey("status")) {
        controller.status = params['status'];
      }
      if (params.containsKey('hideBottomBtn')) {
        hideBottomBtn = params['hideBottomBtn'];
      }
      controller.loadMaterialEntryDetail();
    }
  }

  @override
  dispose() {
    SCScaffoldManager.instance.deleteGetXControllerTag((SCMaterialEntryDetailPage).toString(), controllerTag);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(title: '入库详情', body: body());
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
          return Offstage(
            offstage: !controller.success,
            child: SCMaterialDetailListView(
              state: controller,
              type: SCWarehouseManageType.entry,
            ),
          );
        });
  }

  /// bottomView
  Widget bottomView() {
    if (hideBottomBtn) {
      return const SizedBox();
    }
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
              } else if(value == '提交') {
                submitAction();
              }
          // if (value == "驳回") {
          //   SCUtils.getCurrentContext(completionHandler: (BuildContext context) {
          //     SCDialogUtils().showCustomBottomDialog(
          //         isDismissible: true,
          //         context: context,
          //         widget: SCRejectAlert(
          //           title: '驳回',
          //           reason: '驳回理由',
          //           tagList: const [],
          //           showNode: true,
          //         ));
          //   });
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
          // } else if (value == "通过") {
          //   SCUtils.getCurrentContext(completionHandler: (BuildContext context) {
          //     SCDialogUtils().showCustomBottomDialog(
          //         isDismissible: true,
          //         context: context,
          //         widget: SCRejectAlert(
          //           title: '审批通过',
          //           reason: '通过理由',
          //           tagList: ['批准通过', '入库批准通过'],
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
    int materialType = controller.model.materialType ?? 2;
    List<SCMaterialListModel> materials = controller.model.materials ?? [];
    for (SCMaterialListModel model in materials) {
      model.localNum = model.number ?? 1;
      model.isSelect = true;
      model.name = model.materialName ?? '';
      // model.id = model.materialId;
    }
    SCRouterHelper.pathPage(SCRouterPath.addEntryPage, {
      'isEdit' : true,
      'data' : materials,
      "wareHouseName" : wareHouseName,
      "wareHouseId" : wareHouseId,
      "typeName" : typeName,
      "type" : type,
      "remark" : remark,
      "id" : id,
      "materialType": materialType
    })?.then((value) {
      controller.loadMaterialEntryDetail();
    });
  }

  /// 提交
  submitAction() {
    SCMaterialEntryController materialEntryController = SCMaterialEntryController();
    materialEntryController.submit(id: controller.id, completeHandler: (bool success){
      if (success) {
        SCScaffoldManager.instance.eventBus
            .fire({'key': SCKey.kRefreshMaterialEntryPage});
        SCRouterHelper.back( null);
      }
    });
  }
}
