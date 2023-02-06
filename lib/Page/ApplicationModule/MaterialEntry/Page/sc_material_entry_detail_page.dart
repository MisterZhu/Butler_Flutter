import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/Detail/sc_material_bottom_view.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/Detail/sc_material_detail_listview.dart';
import 'package:smartcommunity/Skin/View/sc_custom_scaffold.dart';

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
          bottomView()
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
    Widget moreBtn = SizedBox(
      width: 61.0,
      height: 40.0,
      child: CupertinoButton(alignment: Alignment.centerLeft,minSize: 22.0, padding: EdgeInsets.zero, child: Image.asset(SCAsset.iconMaterialMore, width: 22.0, height: 22.0,), onPressed: (){moreAction();}),
    );
    List list = [
      {
        "type" : sc_materialBottomViewTypeCustom,
        "title" : "",
        "widget" : moreBtn
      },
      {
        "type" : sc_materialBottomViewType1,
        "title" : "驳回",
      },
      {
        "type" : sc_materialBottomViewType1,
        "title" : "拒绝",
      },
      {
        "type" : sc_materialBottomViewType2,
        "title" : "通过",
      },
    ];
    return SCMaterialDetailBottomView(list: list);
  }

  /// 更多选项
  moreAction() {

  }
}