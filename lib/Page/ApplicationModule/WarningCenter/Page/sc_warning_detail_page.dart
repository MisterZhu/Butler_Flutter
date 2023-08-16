import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/Detail/sc_material_bottom_view.dart';
import 'package:smartcommunity/Skin/View/sc_custom_scaffold.dart';
import '../../../../Constants/sc_h5.dart';
import '../../../../Network/sc_config.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Utils/Router/sc_router_helper.dart';
import '../../../../Utils/Router/sc_router_path.dart';
import '../../../../Utils/sc_utils.dart';
import '../../MaterialEntry/View/Alert/sc_reject_alert.dart';
import '../Controller/sc_warning_detail_controller.dart';
import '../Model/sc_warning_dealresult_model.dart';
import '../View/Detail/sc_warning_detail_view.dart';

/// 预警详情

class SCWarningDetailPage extends StatefulWidget {
  @override
  SCWarningDetailPageState createState() => SCWarningDetailPageState();
}

class SCWarningDetailPageState extends State<SCWarningDetailPage>
    with SingleTickerProviderStateMixin {
  /// SCWarningDetailController
  late SCWarningDetailController controller;

  /// SCWarningDetailController - tag
  String controllerTag = '';

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance
        .getXControllerTag((SCWarningDetailPage).toString());
    controller = Get.put(SCWarningDetailController(), tag: controllerTag);

    Map<String, dynamic> params = Get.arguments;
    if (params.isNotEmpty) {
      var id = params['id'];
      if (id != null) {
        controller.id = id;
        controller.alertContext = params['alertContext'];
        controller.provider = this;
        controller.loadWarningDetailData();
      }
    }
  }

  @override
  dispose() {
    super.dispose();
    SCScaffoldManager.instance.deleteGetXControllerTag(
        (SCWarningDetailPage).toString(), controllerTag);
    controller.dispose();
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
        children: [Expanded(child: contentView()), bottomView()],
      ),
    );
  }

  /// contentView
  Widget contentView() {
    return GetBuilder<SCWarningDetailController>(
        tag: controllerTag,
        init: controller,
        builder: (state) {
          if (controller.success) {
            return SCWarningDetailView(
              state: controller,
              tabController: controller.tabController,
            );
          } else {
            return const SizedBox();
          }
        });
  }

  /// bottomView
  Widget bottomView() {
    return GetBuilder<SCWarningDetailController>(
        tag: controllerTag,
        init: controller,
        builder: (state) {
          List list;
          if (controller.detailModel.status == 3) {
            list = [
              {
                "type": scMaterialBottomViewType2,
                "title": "新增报事",
              },
            ];
          } else {
            list = [
              {
                "type": scMaterialBottomViewType1,
                "title": "新增报事",
              },
              {
                "type": scMaterialBottomViewType2,
                "title": "处理",
              },
            ];
          }
          if (controller.success) {
            return SCMaterialDetailBottomView(
              list: list,
              onTap: (value) {
                if (value == '新增报事') {
                  addAction();
                } else if (value == '处理') {
                  dealAction();
                }
              },
            );
          } else {
            return const SizedBox();
          }
        });
  }

  /// 新增
  addAction() {
    SCRouterHelper.pathPage(SCRouterPath.webViewPath, {
      "title": '快捷报事',
      "url": SCUtils.getWebViewUrl(
          url: SCConfig.getH5Url(SCH5.quickReportUrl),
          title: '快捷报事',
          needJointParams: true)
    });
  }

  /// 处理
  dealAction() {
    controller.loadDictionaryCode(controller.detailModel.alertType ?? '',
        (success, list) {
      if (success) {
        List<String> tagList = [];
        for (SCWarningDealResultModel model in list) {
          tagList.add(model.name ?? '');
        }
        SCUtils.getCurrentContext(completionHandler: (BuildContext context) {
          SCDialogUtils().showCustomBottomDialog(
              isDismissible: true,
              context: context,
              widget: SCRejectAlert(
                title: '处理',
                resultDes: '处理结果',
                reasonDes: '处理说明',
                isRequired: true,
                tagList: tagList,
                hiddenTags: true,
                showNode: true,
                sureAction: (int index, String value, List imageList) {
                  SCWarningDealResultModel model = list[index];
                  controller.deal(
                      value,
                      int.parse(model.code ?? '0'),
                      int.parse(controller.id),
                      imageList,
                      controller.detailModel.status ?? 0);
                },
              ));
        });
      }
    });
  }
}
