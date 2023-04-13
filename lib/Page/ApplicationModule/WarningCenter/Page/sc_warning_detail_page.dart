import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/Detail/sc_material_bottom_view.dart';
import 'package:smartcommunity/Skin/View/sc_custom_scaffold.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../Controller/sc_warning_detail_controller.dart';
import '../View/Detail/sc_warning_detail_view.dart';


/// 预警详情

class SCWarningDetailPage extends StatefulWidget {
  @override
  SCWarningDetailPageState createState() => SCWarningDetailPageState();
}

class SCWarningDetailPageState extends State<SCWarningDetailPage> with SingleTickerProviderStateMixin {
  /// SCWarningDetailController
  late SCWarningDetailController controller;

  /// SCWarningDetailController - tag
  String controllerTag = '';

  late TabController tabController;

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance
        .getXControllerTag((SCWarningDetailPage).toString());
    controller = Get.put(SCWarningDetailController(), tag: controllerTag);
    tabController = TabController(length: 3, vsync: this);

    Map<String, dynamic> params = Get.arguments;
    if (params.isNotEmpty) {
      var id = params['id'];
      if (id != null) {
        controller.id = id;
        controller.loadWarningDetailData();
      }
    }
  }

  @override
  dispose() {
    SCScaffoldManager.instance.deleteGetXControllerTag((SCWarningDetailPage).toString(), controllerTag);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(title: '预警详情', body: body());
  }

  /// body
  body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: Column(
        children: [
          Expanded(child: contentView()),
          bottomView()
        ],
      ),
    );
  }

  /// contentView
  Widget contentView() {
    return GetBuilder<SCWarningDetailController>(
        tag: controllerTag,
        init: controller,
        builder: (state) {
          return Offstage(
            offstage: !controller.success,
            child: SCWarningDetailView(state: controller, tabController: tabController,),
          );
        });
  }

  /// bottomView
  Widget bottomView() {
    List list = [
      {
        "type": scMaterialBottomViewType1,
        "title": "新增",
      },
      {
        "type": scMaterialBottomViewType2,
        "title": "处理",
      },
    ];
    return GetBuilder<SCWarningDetailController>(
        tag: controllerTag,
        init: controller,
        builder: (state) {
          return SCMaterialDetailBottomView(
            list: list,
            onTap: (value) {
              if (value == '新增') {
                addAction();
              } else if(value == '处理') {
                dealAction();
              }
            },
          );
        });
  }

  /// 新增
  addAction() {

  }

  /// 处理
  dealAction() {

  }
}
