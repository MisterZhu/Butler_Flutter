import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/Detail/sc_material_bottom_view.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/Detail/sc_material_detail_listview.dart';
import 'package:smartcommunity/Skin/View/sc_custom_scaffold.dart';
import '../../../../Utils/sc_utils.dart';
import '../View/Alert/sc_reject_alert.dart';

/// 入库详情

class SCMaterialEntryDetailPage extends StatefulWidget {
  @override
  SCMaterialEntryDetailPageState createState() => SCMaterialEntryDetailPageState();
}

class SCMaterialEntryDetailPageState extends State<SCMaterialEntryDetailPage> {
  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
      title: '入库详情',
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
          //bottomView()
        ],
      ),
    );
  }

  /// topView
  Widget topView() {
    return const SCMaterialDetailListView();
  }
  /// bottomView
  Widget bottomView() {
    List list = [
      {
        "type" : scMaterialBottomViewType1,
        "title" : "驳回",
      },
      {
        "type" : scMaterialBottomViewType1,
        "title" : "拒绝",
      },
      {
        "type" : scMaterialBottomViewType2,
        "title" : "通过",
      },
    ];
    return SCMaterialDetailBottomView(list: list, onTap: (value) {
      if (value == "驳回") {
        SCUtils.getCurrentContext(completionHandler: (BuildContext context) {
          SCDialogUtils().showCustomBottomDialog(
              isDismissible: true,
              context: context,
              widget: SCRejectAlert(
                title: '驳回',
                reason: '驳回理由',
                tagList: const [],
                showNode: true,
              ));
        });
      } else if (value == "拒绝") {
        SCUtils.getCurrentContext(completionHandler: (BuildContext context) {
          SCDialogUtils().showCustomBottomDialog(
              isDismissible: true,
              context: context,
              widget: SCRejectAlert(
                title: '审批拒绝',
                reason: '拒绝理由',
                tagList: ['流程不合理', '图片不清晰', '名称错误', '审批不合规'],
                showNode: false,
              ));
        });
      } else if (value == "通过") {
        SCUtils.getCurrentContext(completionHandler: (BuildContext context) {
          SCDialogUtils().showCustomBottomDialog(
              isDismissible: true,
              context: context,
              widget: SCRejectAlert(
                title: '审批通过',
                reason: '通过理由',
                tagList: ['批准通过', '入库批准通过'],
                showNode: false,
              ));
        });
      }
    },);
  }
}