import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../Controller/sc_task_controller.dart';


/// 任务卡片listview

class SCTaskListView extends StatelessWidget {

  /// SCTaskController
  final SCTaskController state;

  /// RefreshController
  final RefreshController refreshController;

  SCTaskListView({Key? key, required this.state, required this.refreshController}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return SCTaskCardCell(
            timeType: 0,
            tagList: index == 0 ? const ['标签1', '标签2', '标签3'] : [],
            remainingTime: state.timeList[index],
            time: state.testTimeList[index],
            btnText: '处理',
            hideBtn: index == 0 ? true : false,
            hideAddressIcon: index == 0 ? true : false,
            hideCallIcon: index == 0 ? true : false,
            hideBottomView: index == 1 ? true : false,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 10.0,);
        },
        itemCount: 5);
  }

}