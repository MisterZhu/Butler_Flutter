
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';

/// 验房-问题listview

class SCHouseInspectProblemListView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return getCell(index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return line();
        },
        itemCount: 2);
  }

  /// cell
  Widget getCell(int index) {
    if (index == 0) {
      return const SizedBox(
        height: 100.0,
      );
    } else {
      return Container();
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
