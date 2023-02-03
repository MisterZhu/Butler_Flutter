
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/HouseInspect/View/sc_bottom_button_item.dart';
import 'package:smartcommunity/Page/ApplicationModule/HouseInspect/View/Problems/sc_house_problem_cell.dart';
import 'package:smartcommunity/Page/ApplicationModule/HouseInspect/View/sc_house_status_cell.dart';
import 'package:smartcommunity/Page/ApplicationModule/HouseInspect/View/sc_open_state_cell.dart';
import '../../../../Utils/Router/sc_router_helper.dart';
import '../../../../Utils/Router/sc_router_path.dart';
import '../../../../Utils/sc_utils.dart';

/// 正式验房-详情listview

class SCFormalHouseInspectDeatilListView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  /// body
  Widget body(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: listview(context)),
          SCBottomButtonItem(list: const ['验收完成', '+ 问题'], buttonType: 1, leftTapAction: () {
            /// 验收完成
            //SCRouterHelper.back(null);
            SCRouterHelper.pathPage(SCRouterPath.houseInspectFormPage, null);
          }, rightTapAction: () {
            /// + 问题
            SCRouterHelper.pathPage(SCRouterPath.houseInspectProblemPage, null);
          },),
        ],
    );
  }

  /// listview
  Widget listview(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SCUtils().hideKeyboard(context: context);
      },
      behavior: HitTestBehavior.opaque,
      child: ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return getCell(index);
          },
          separatorBuilder: (BuildContext context, int index) {
            return line();
          },
          itemCount: 4),
    );
  }

  /// cell
  Widget getCell(int index) {
    if (index == 0) {
      return SCOpenStateCell();
    } else if (index == 1) {
      return SCHouseStatusCell();
    } else if (index == 2) {
      return problemsItem();
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
          return line();
        },
        itemCount: 3);
  }

  /// problemsCell
  Widget problemCell() {
    return Container(
      color: SCColors.color_FFFFFF,
      width: double.infinity,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SCHouseProblemCell()
      ),
    );
  }

  /// line
  Widget line() {
    return Container(
      color: SCColors.color_FFFFFF,
      padding: const EdgeInsets.only(left: 16.0),
      child: Container(
        height: 0.5,
        width: double.infinity,
        color: SCColors.color_EDEDF0,
      ),
    );
  }


}
