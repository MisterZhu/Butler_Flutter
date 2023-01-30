
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/HouseInspect/View/sc_bottom_button_item.dart';
import 'package:smartcommunity/Page/ApplicationModule/HouseInspect/View/sc_house_inspect_form_info_cell.dart';
import 'package:smartcommunity/Page/ApplicationModule/HouseInspect/View/sc_house_inspect_score_cell.dart';
import 'package:smartcommunity/Page/ApplicationModule/HouseInspect/View/sc_house_problem_cell.dart';

/// 验房单listview

class SCHouseInspectFormListView extends StatelessWidget {

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
        SCBottomButtonItem(list: const ['重新签署', '确定'], buttonType: 1, leftTapAction: () {
          /// 验收完成
          //SCRouterHelper.back(null);
        }, rightTapAction: () {
          /// 确定
        },),
      ],
    );
  }

  /// listview
  Widget listview() {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0 ,top: 14.0),
      child: ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return getCell(index);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 10.0,);
          },
          itemCount: 4),
    );
  }

  /// cell
  Widget getCell(int index) {
    if (index == 0) {
      return SCHouseInspectFormInfoCell();
    } else if (index == 1) {
      return problemsItem();
    } else if (index == 2) {
      return SCHouseInspectScoreCell();
    } else {
      return const SizedBox(height: 28.0,);
    }
  }

  /// problemsCell
  Widget problemsItem() {
    return ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return problemCell();
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 10,);
        },
        itemCount: 3);
  }

  /// problemsCell
  Widget problemCell() {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(4.0)),
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: SCHouseProblemCell()
    );
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
