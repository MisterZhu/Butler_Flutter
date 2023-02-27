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
import '../Controller/sc_material_check_controller.dart';

/// 盘点详情

class SCMaterialCheckDetailPage extends StatefulWidget {
  @override
  SCMaterialCheckDetailPageState createState() =>
      SCMaterialCheckDetailPageState();
}

class SCMaterialCheckDetailPageState extends State<SCMaterialCheckDetailPage> {
  /// SCMaterialCheckDetailController
  late SCMaterialEntryDetailController controller;

  /// SCMaterialEntryDetailController - tag
  String controllerTag = '';

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance
        .getXControllerTag((SCMaterialCheckDetailPage).toString());
    controller = Get.put(SCMaterialEntryDetailController(), tag: controllerTag);
    Map<String, dynamic> params = Get.arguments;
    if (params.isNotEmpty) {
      var id = params['id'];
      if (id != null) {
        controller.id = id;
      }
      controller.loadMaterialCheckDetail();
    }
  }

  @override
  dispose() {
    SCScaffoldManager.instance.deleteGetXControllerTag(
        (SCMaterialCheckDetailPage).toString(), controllerTag);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(title: '盘点详情', body: body());
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
              type: SCWarehouseManageType.check,
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
          bool showBottomBtn = true;
          // state 任务状态(0：未开始，1：待盘点（超时），2：待盘点，3：盘点中（超时），4：盘点中，5：已完成（超时），6：已完成，7：已作废
          if (state.model.status == 0) {// 未开始
            list = [
              {"type": scMaterialBottomViewType1, "title": "作废",},
              {"type": scMaterialBottomViewType2, "title": "编辑",},
            ];
          } else if (state.model.status == 2) {// 待盘点
            list = [
              {"type": scMaterialBottomViewType2, "title": "盘点",},
            ];
          } else if (state.model.status == 3 || state.model.status ==  4) {// 盘点中（超时）、盘点中
            list = [
              {"type": scMaterialBottomViewType1, "title": "暂存",},
              {"type": scMaterialBottomViewType2, "title": "提交",},
            ];
          } else if (state.model.status == 7) {// 已作废
            list = [
              {"type": scMaterialBottomViewType2, "title": "删除",},
            ];
          } else {
            showBottomBtn = false;
          }
          return Offstage(
            offstage: !showBottomBtn,
            child: SCMaterialDetailBottomView(
              list: list,
              onTap: (value) {
                if (value == '编辑') {
                  editAction();
                } else if (value == '暂存') {

                } else if (value == '提交') {
                  submitAction();
                } else if (value == '作废') {

                } else if (value == '盘点') {

                } else if (value == '删除') {

                }
              },
            ),
          );
        });
  }

  /// 编辑
  editAction() async {
    String wareHouseName = controller.model.wareHouseName ?? '';
    String wareHouseId = controller.model.wareHouseId ?? '';
    String typeName = controller.model.typeName ?? '';
    int type = controller.model.type ?? 0;
    String remark = controller.model.remark ?? '';
    List<SCMaterialListModel> materials = controller.model.materials ?? [];
    String id = controller.model.id ?? '';

    for (SCMaterialListModel model in materials) {
      model.localNum = model.number ?? 1;
      model.isSelect = true;
      model.name = model.materialName ?? '';
      //model.id = model.materialId;
    }
    SCRouterHelper.pathPage(SCRouterPath.addCheckPage, {
      'isEdit': true,
      'data': materials,
      "wareHouseName": wareHouseName,
      "wareHouseId": wareHouseId,
      "typeName": typeName,
      "type": type,
      "remark": remark,
      "id": id
    })?.then((value) {
      controller.loadMaterialCheckDetail();
    });
  }

  /// 提交
  submitAction() {
    SCMaterialCheckController materialCheckController =
        SCMaterialCheckController();
    materialCheckController.submit(
        id: controller.id,
        completeHandler: (bool success) {
          SCScaffoldManager.instance.eventBus
              .fire({'key': SCKey.kRefreshMaterialTransferPage});
          SCRouterHelper.back(null);
        });
  }
}
