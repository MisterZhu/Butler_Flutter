import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/Detail/sc_material_bottom_view.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/Detail/sc_material_detail_listview.dart';
import 'package:smartcommunity/Skin/View/sc_custom_scaffold.dart';
import '../../../../Constants/sc_enum.dart';
import '../../../../Constants/sc_key.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Utils/Router/sc_router_helper.dart';
import '../../../../Utils/Router/sc_router_path.dart';
import '../../../../Utils/sc_utils.dart';
import '../../MaterialEntry/Controller/sc_material_entry_detail_controller.dart';
import '../../MaterialEntry/Model/sc_material_list_model.dart';
import '../../MaterialEntry/Page/sc_material_entry_detail_page.dart';
import '../Controller/sc_material_outbound_controller.dart';
import '../View/Alert/sc_outbound_confirm_alert.dart';

/// 出库详情

class SCMaterialOutboundDetailPage extends StatefulWidget {
  @override
  SCMaterialOutboundDetailPageState createState() => SCMaterialOutboundDetailPageState();
}

class SCMaterialOutboundDetailPageState extends State<SCMaterialOutboundDetailPage> {

  /// SCMaterialEntryDetailController
  late SCMaterialEntryDetailController controller;

  /// SCMaterialEntryDetailController - tag
  String controllerTag = '';

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance
        .getXControllerTag((SCMaterialEntryDetailPage).toString());
    controller = Get.put(SCMaterialEntryDetailController(), tag: controllerTag);
    var params = Get.arguments;
    print('上个页面传过来的参数:$params');
    if (params != null) {
      var id = params['id'];
      if (id != null) {
        controller.id = id;
      }
    }
    controller.loadMaterialOutboundDetail();
  }

  @override
  dispose() {
    SCScaffoldManager.instance.deleteGetXControllerTag((SCMaterialOutboundDetailPage).toString(), controllerTag);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: '出库详情',
        body: body()
    );
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
            type: SCWarehouseManageType.outbound,
          ),
        );
      });
  }

  /// bottomView
  Widget bottomView() {
    List list = [
      {
        "type" : scMaterialBottomViewType1,
        "title" : "编辑",
      },
      {
        "type" : scMaterialBottomViewType2,
        "title" : "提交",
      },
    ];
    return GetBuilder<SCMaterialEntryDetailController>(
        tag: controllerTag,
        init: controller,
        builder: (state) {
          bool showBtns = false;
          if (state.model.status == 0) {
            showBtns = true;
          } else if (state.model.status == 6 && state.model.haveAuth == true) {/// 已通过
            showBtns = true;
            list = [
              {
                "type" : scMaterialBottomViewType2,
                "title" : "出库确认",
              },
            ];
          }
    return Offstage(
      offstage: !showBtns,
      child: SCMaterialDetailBottomView(list: list, onTap: (value) {
        if (value == '编辑') {
          editAction();
        } else if(value == '提交') {
          submitAction();
        } else if (value == "出库确认") {
          SCUtils.getCurrentContext(completionHandler: (BuildContext context) {
            SCDialogUtils().showCustomBottomDialog(
                isDismissible: true,
                context: context,
                widget: SCOutboundConfirmAlert(sureAction: (outTime, input) {
                  outboundConfirmAction(outTime, input);
                },));
          });
        }
      },),
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
    List<SCMaterialListModel> materials = controller.model.materials ?? [];
    /// 领用人（只有出库类型为领料出库时才传）
    String fetchUserName = controller.model.fetchUserName ?? '';

    /// 领用人ID（只有出库类型为领料出库时才传）
    String fetchUserId = controller.model.fetchUserId ?? '';

    /// 领用组织(或部门)（只有出库类型为领料出库时才传）
    String fetchOrgName = controller.model.fetchOrgName ?? '';

    /// 领用组织(或部门)ID（只有出库类型为领料出库时才传）
    String fetchOrgId = controller.model.fetchOrgId ?? '';

    /// 主键id
    String id = controller.model.id ?? '';

    for (SCMaterialListModel model in materials) {
      model.localNum = model.number ?? 1;
      model.isSelect = true;
      model.name = model.materialName ?? '';
      // model.id = model.materialId;
    }
    SCRouterHelper.pathPage(SCRouterPath.addOutboundPage, {
      'isEdit' : true,
      'data' : materials,
      "wareHouseName" : wareHouseName,
      "wareHouseId" : wareHouseId,
      "typeName" : typeName,
      "type" : type,
      "fetchOrgName" : fetchOrgName,
      "fetchOrgId" : fetchOrgId,
      "fetchUserName" : fetchUserName,
      "fetchUserId" : fetchUserId,
      "remark" : remark,
      "id" : id
    })?.then((value) {
      controller.loadMaterialOutboundDetail();
    });
  }

  /// 提交
  submitAction() {
    SCMaterialOutboundController materialOutboundController = SCMaterialOutboundController();
    materialOutboundController.submit(id: controller.id, completeHandler: (bool success){
      SCScaffoldManager.instance.eventBus.fire({'key': SCKey.kRefreshMaterialOutboundPage});
      SCRouterHelper.back( null);
    });
  }

  /// 出库确认
  outboundConfirmAction(String outTime, String input) {
    controller.outboundConfirm(outTime: outTime, remark: input, successHandler: () {
      SCScaffoldManager.instance.eventBus.fire({'key': SCKey.kRefreshMaterialOutboundPage});
      Future.delayed(const Duration(seconds: 2), (){
        SCRouterHelper.back( null);
      });
    });
  }
}