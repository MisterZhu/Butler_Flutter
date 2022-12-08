import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/sc_workbench_card.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/sc_workbench_search.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/sc_workbench_switchspace_view.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/sc_workbench_tabbar.dart';
import 'package:smartcommunity/Utils/sc_utils.dart';

/// 工作台-header

class SCWorkBenchHeader extends StatelessWidget {
  const SCWorkBenchHeader({
    Key? key,
    required this.height,
    required this.tabController,
    required this.tabTitleList,
    required this.classificationList
  }) : super(key: key);

  /// 组件高度
  final double height;

  /// tabController
  final TabController tabController;

  /// tab标题list
  final List tabTitleList;

  /// 分类list
  final List classificationList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: body(context),
    );
  }

  /// body
  Widget body(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: SCUtils().getTopSafeArea()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SCWorkBenchSwitchSpaceView(),
          const SizedBox(
            height: 15.0,
          ),
          SCWorkBenchSearch(),
          const SizedBox(
            height: 22.0,
          ),
          SCWorkBenchCard(),
          SCWorkBenchTabBar(tabController: tabController, tabTitleList: tabTitleList, classificationList: classificationList)
        ],
      ),
    );
  }
}
