import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';

import '../../Controller/sc_purchase_search_controller.dart';
import '../../Model/sc_purchase_model.dart';

/// 采购单listView

class SCPurchaseListView extends StatefulWidget {

  const SCPurchaseListView({Key? key, required this.list, required this.controller}) : super(key: key);

  /// 数据源
  final List<SCPurchaseModel> list;

  /// controller
  final SCPurchaseSearchController controller;

  @override
  SCPurchaseListViewState createState() => SCPurchaseListViewState();
}

class SCPurchaseListViewState extends State<SCPurchaseListView> {
  @override
  Widget build(BuildContext context) {
    return listView();
  }

  /// listView
  Widget listView() {
    return ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          return cell(index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return line(index);
        },
        itemCount: widget.list.length);
  }

  /// cell
  Widget cell(int index) {
    SCPurchaseModel model = widget.list[index];
    String text = model.purchaseCode ?? '';
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        detail(index);
      },
      child: Container(
        height: 44.0,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        color: SCColors.color_FFFFFF,
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: const TextStyle(
              fontSize: SCFonts.f16,
              fontWeight: FontWeight.w400,
              color: SCColors.color_1B1D33),
        ),
      ),
    );
  }

  /// line
  Widget line(int index) {
    return const Padding(
        padding: EdgeInsets.only(left: 16.0),
        child: Divider(
          height: 0.5,
          color: SCColors.color_EDEDF0,
        ));
  }

  /// 详情
  detail(int index) {
    SCPurchaseModel model = widget.list[index];
    widget.controller.detail(model: model);
  }
}
