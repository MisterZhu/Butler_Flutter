import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/Detail/sc_material_bottom_view.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/Detail/sc_material_detail_listview.dart';
import 'package:smartcommunity/Skin/View/sc_custom_scaffold.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Utils/sc_utils.dart';
import '../../MaterialEntry/Controller/sc_material_entry_detail_controller.dart';
import '../../MaterialEntry/Page/sc_material_entry_detail_page.dart';
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
    controllerTag = SCScaffoldManager.instance.getXControllerTag((SCMaterialEntryDetailPage).toString());
    controller = Get.put(SCMaterialEntryDetailController(), tag: controllerTag);
    controller.loadMaterialEntryDetail();
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
    return SCMaterialDetailListView(state: controller, type: 1,);
  }
  /// bottomView
  Widget bottomView() {
    List list = [
      {
        "type" : scMaterialBottomViewType1,
        "title" : "打印",
      },
      {
        "type" : scMaterialBottomViewType2,
        "title" : "出库确认",
      },
    ];
    return SCMaterialDetailBottomView(list: list, onTap: (value) {
      if (value == "出库确认") {
        SCUtils.getCurrentContext(completionHandler: (BuildContext context) {
          SCDialogUtils().showCustomBottomDialog(
              isDismissible: true,
              context: context,
              widget: SCOutboundConfirmAlert());
        });
      }
    },);
  }
}