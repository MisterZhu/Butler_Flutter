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
import '../../../../Constants/sc_default_value.dart';
import '../../../../Constants/sc_enum.dart';
import '../../../../Constants/sc_key.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Utils/sc_utils.dart';
import '../../MaterialEntry/Controller/sc_material_entry_detail_controller.dart';

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
      if (params['isFixedCheck'] != null) {
        controller.isFixedCheck = params['isFixedCheck'];
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
              type: controller.isFixedCheck ? SCWarehouseManageType.fixedCheck : SCWarehouseManageType.check,
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
            if (controller.checkedList.isNotEmpty) {
              list = [
                {"type": scMaterialBottomViewType1, "title": "暂存",},
                {"type": scMaterialBottomViewType2, "title": "盘点",},
              ];
            } else {
              list = [
                {"type": scMaterialBottomViewType2, "title": "盘点",},
              ];
            }
          } else if (state.model.status == 3 || state.model.status ==  4) {// 盘点中（超时）、盘点中
            if (controller.isFixedCheck == true) {
              list = [
                {"type": scMaterialBottomViewType1, "title": "暂存",},
                {"type": scMaterialBottomViewType2, "title": "提交",},
              ];
            } else {
              if (controller.checkedList.length == state.model.materials?.length) {
                list = [
                  {"type": scMaterialBottomViewType1, "title": "暂存",},
                  {"type": scMaterialBottomViewType2, "title": "提交",},
                ];
              } else {
                list = [
                  {"type": scMaterialBottomViewType1, "title": "暂存",},
                  {"type": scMaterialBottomViewType2, "title": "盘点",},
                ];
              }
            }
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
                  if (controller.isFixedCheck == true) {
                    submitFixedCheckAction(0);
                  } else {
                    saveAction();
                  }
                } else if (value == '提交') {
                  if (controller.isFixedCheck == true) {
                    submitFixedCheckAction(1);
                  } else {
                    submitAlert();
                  }
                } else if (value == '作废') {
                  cancelAction();
                } else if (value == '盘点') {
                  checkAction();
                } else if (value == '删除') {
                  deleteAction();
                }
              },
            ),
          );
        });
  }

  /// 暂存
  saveAction() {
    List list = [];
    for (int i = 0; i < controller.checkedList.length; i++) {
      SCMaterialListModel model = controller.checkedList[i];
      var dict = {
        "id": model.id,
        "checkId": model.checkId,
        "checkNum": model.checkNum,
      };
      list.add(dict);
    }
    print('暂存===========$list');
    controller.checkSubmit(
        action: 0,
        checkId: controller.model.id ?? '',
        materials: list,
        successHandler: () {
          controller.loadMaterialCheckDetail();
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
    String taskName = controller.model.taskName ?? '';
    String taskStartTime = controller.model.taskStartTime ?? '';
    String taskEndTime = controller.model.taskEndTime ?? '';
    String dealOrgName = controller.model.dealOrgName ?? '';
    String dealOrgId = controller.model.dealOrgId ?? '';
    String dealUserName = controller.model.dealUserName ?? '';
    String dealUserId = controller.model.dealUserId ?? '';
    int rangeValue = controller.model.rangeValue ?? 1;

    for (SCMaterialListModel model in materials) {
      model.localNum = model.number ?? 1;
      model.isSelect = true;
      model.name = model.materialName ?? '';
      //model.id = model.materialId;
    }
    var params = {
      'isEdit': true,
      'data': materials,
      "wareHouseName": wareHouseName,
      "wareHouseId": wareHouseId,
      "typeName": typeName,
      "type": type,
      "remark": remark,
      "id": id,
      "taskName": taskName,
      "startTime": taskStartTime,
      "endTime": taskEndTime,
      "dealOrgName": dealOrgName,
      "dealOrgId": dealOrgId,
      "dealUserName": dealUserName,
      "dealUserId": dealUserId,
      "rangeValue": rangeValue
    };
    if (controller.isFixedCheck == true) {//去编辑固定资产盘点页面
      SCRouterHelper.pathPage(SCRouterPath.addFixedCheckPage, params)?.then((value) {
        controller.loadMaterialCheckDetail();
      });
    } else {
      SCRouterHelper.pathPage(SCRouterPath.addCheckPage, params)?.then((value) {
        controller.loadMaterialCheckDetail();
      });
    }
  }

  /// 提交确认弹窗
  submitAlert() {
    SCDialogUtils.instance.showMiddleDialog(
      context: context,
      content: SCDefaultValue.checkSubmitTip,
      customWidgetButtons: [
        defaultCustomButton(context,
            text: '取消',
            textColor: SCColors.color_1B1C33,
            fontWeight: FontWeight.w400),
        defaultCustomButton(context,
            text: '确定',
            textColor: SCColors.color_4285F4,
            fontWeight: FontWeight.w400,
            onTap: () {
              submitAction();
            }
        ),
      ],
    );
  }

  /// 提交
  submitAction() {
    List list = [];
    for (int i = 0; i < controller.checkedList.length; i++) {
      SCMaterialListModel model = controller.checkedList[i];
      var dict = {
        "id": model.id,
        "checkId": model.checkId,
        "checkNum": model.checkNum,
      };
      list.add(dict);
    }
    print('提交===========$list');
    controller.checkSubmit(
        action: 1,
        checkId: controller.model.id ?? '',
        materials: list,
        successHandler: () {
          if (controller.isFixedCheck == true) {
            SCScaffoldManager.instance.eventBus
                .fire({'key': SCKey.kRefreshFixedCheckPage});
          } else {
            SCScaffoldManager.instance.eventBus
                .fire({'key': SCKey.kRefreshMaterialCheckPage});
          }
          SCRouterHelper.back(null);
        });
  }



  /// 作废
  cancelAction() {
    SCDialogUtils.instance.showMiddleDialog(
      context: context,
      content: SCDefaultValue.checkCancelTip,
      customWidgetButtons: [
        defaultCustomButton(context,
            text: '取消',
            textColor: SCColors.color_1B1C33,
            fontWeight: FontWeight.w400),
        defaultCustomButton(context,
            text: '确定',
            textColor: SCColors.color_4285F4,
            fontWeight: FontWeight.w400,
            onTap: () {
              controller.cancelCheckTask(id: controller.model.id ?? '', successHandler: () {
                if (controller.isFixedCheck == true) {
                  SCScaffoldManager.instance.eventBus
                      .fire({'key': SCKey.kRefreshFixedCheckPage});
                } else {
                  SCScaffoldManager.instance.eventBus
                      .fire({'key': SCKey.kRefreshMaterialCheckPage});
                }
                SCRouterHelper.back(null);
              });
            }
        ),
      ],
    );
  }

  /// 盘点
  checkAction() {
    if (controller.isFixedCheck) {
      startCheck();
    } else {
      selectMaterialAction();
    }
  }

  /// 开始盘点
  startCheck() {
    controller.startFixedCheckTask(id: controller.model.id ?? '', successHandler: () {
      controller.loadMaterialCheckDetail();
    });
  }

  /// 盘点-选择物资
  selectMaterialAction() async {
    var list = await SCRouterHelper.pathPage(SCRouterPath.addMaterialPage, {
      'unCheckList': controller.uncheckedList,
      "materialType": SCWarehouseManageType.check,
      'hideNumTextField': false,
      'check': true,
      'isProperty': controller.isFixedCheck
    });
    if (list != null) {
      print('已盘点的物资==============$list');
      List<SCMaterialListModel> newList = list;
      setState(() {
        controller.checkedList.addAll(newList);
      });
      for (int i = 0; i < newList.length; i++) {
        SCMaterialListModel model = newList[i];
        controller.uncheckedList.remove(model);
      }
    }
  }

  /// 删除
  deleteAction() {
    controller.deleteCheckTask(id: controller.model.id ?? '', successHandler: () {
      SCScaffoldManager.instance.eventBus
          .fire({'key': SCKey.kRefreshMaterialCheckPage});
      SCRouterHelper.back(null);
    });
  }


  /// 固定资产盘点-提交
  submitFixedCheckAction(int action) {
    List list = [];
    for (int i = 0; i < controller.checkedList.length; i++) {
      SCMaterialListModel model = controller.checkedList[i];
      var dict = {
        "id": model.id,
        "reportReason": 0,
        "status": 0,
      };
      list.add(dict);
    }
    print('提交===========$list');
    controller.fixedCheckSubmit(
        action: action,
        checkId: controller.model.id ?? '',
        materials: list,
        successHandler: () {
          if (controller.isFixedCheck == true) {
            SCScaffoldManager.instance.eventBus
                .fire({'key': SCKey.kRefreshFixedCheckPage});
          } else {
            SCScaffoldManager.instance.eventBus
                .fire({'key': SCKey.kRefreshMaterialCheckPage});
          }
          SCRouterHelper.back(null);
        });
  }
}
