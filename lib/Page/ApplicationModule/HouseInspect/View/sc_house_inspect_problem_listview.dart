
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/HouseInspect/View/sc_bottom_button_item.dart';
import 'package:smartcommunity/Page/ApplicationModule/HouseInspect/View/sc_house_inspect_problem_description_cell.dart';
import 'package:smartcommunity/Page/ApplicationModule/HouseInspect/View/sc_house_inspect_problem_position_cell.dart';
import 'package:smartcommunity/Page/ApplicationModule/HouseInspect/View/sc_house_inspect_problem_standard_cell.dart';
import 'package:smartcommunity/Page/ApplicationModule/HouseInspect/View/sc_house_problem_tags_item.dart';

/// 验房-问题listview

class SCHouseInspectProblemListView extends StatelessWidget {

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
        SCBottomButtonItem(list: const ['立即提交'], tapAction: () {

        },),
      ],
    );
  }

  /// listview
  Widget listview() {
    return ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return getCell(index);
        },
        separatorBuilder: (BuildContext context, int index) {
          if (index < 2) {
            return line();
          } else {
            return const SizedBox(height: 8.0,);
          }
        },
        itemCount: 5);
  }

  /// cell
  Widget getCell(int index) {
    if (index == 0) {
      return SCHouseInspectProblemPositionCell();
    } else if (index == 1) {
      return problemsCell();
    } else if (index == 2) {
      return SCHouseInspectProblemDescriptionCell();
    } else if (index == 3) {
      return SCHouseInspectProblemStandardCell();
    } else {
      return const SizedBox(height: 8.0,);
    }
  }

  /// problemsCell
  Widget problemsCell() {
    return Container(
      color: SCColors.color_FFFFFF,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '验房问题',
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: SCFonts.f16,
              color: SCColors.color_1B1D33,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 18.0,),
          SCHouseProblemTagsCell(
            tagList: ['地面不平整', '墙漆脱落', '淋浴水管漏水', '水管漏水', '地板翘起来了了', '防水问题'],
            maxSelectedNum: 100,
          ),
        ],
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
