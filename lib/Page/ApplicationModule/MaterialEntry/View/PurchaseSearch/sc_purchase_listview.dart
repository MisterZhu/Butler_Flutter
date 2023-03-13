import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';

/// 采购单listView

class SCPurchaseListView extends StatefulWidget {
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
        itemCount: 10);
  }

  /// cell
  Widget cell(int index) {
    return Container(
      height: 44.0,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      color: SCColors.color_FFFFFF,
      alignment: Alignment.centerLeft,
      child: Text(
        '搜索点位1',
        style: TextStyle(
            fontSize: SCFonts.f16,
            fontWeight: FontWeight.w400,
            color: SCColors.color_1B1D33),
      ),
    );
  }

  /// line
  Widget line(int index) {
    return Divider(
      height: 0.5,
      color: SCColors.color_EDEDF0,
    );
  }
}
