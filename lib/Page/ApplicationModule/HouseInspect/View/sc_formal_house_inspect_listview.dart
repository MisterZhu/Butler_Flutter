
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/HouseInspect/View/sc_bottom_button_item.dart';
import 'package:smartcommunity/Page/ApplicationModule/HouseInspect/View/sc_house_info_cell.dart';
import 'package:smartcommunity/Page/ApplicationModule/HouseInspect/View/sc_house_inspect_info_cell.dart';

import '../../../../Utils/Router/sc_router_helper.dart';
import '../../../../Utils/Router/sc_router_path.dart';

/// 正式验房listview

class SCFormalHouseInspectListView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: listview()),
        SCBottomButtonItem(list: ['开始验房'], tapAction: () {
            SCRouterHelper.pathPage(SCRouterPath.formalHouseInspectDetailPage, null);
        },),
      ],
    );
  }

  /// listview
  Widget listview() {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return getCell(index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 10.0,);
        },
        itemCount: 2);
  }

  /// cell
  Widget getCell(int index) {
    if (index == 0) {
      return SCHouseInfoCell();
    } else if (index == 1) {
      return SCHouseInspectInfoCell();
    } else {
      return const SizedBox(height: 20.0,);
    }
  }

  /// line
  Widget line() {
    return Container(
      color: SCColors.color_FFFFFF,
      padding: const EdgeInsets.only(left: 12.0),
      child: Container(
        height: 0.5,
        width: double.infinity,
        color: SCColors.color_EDEDF0,
      ),
    );
  }

}
