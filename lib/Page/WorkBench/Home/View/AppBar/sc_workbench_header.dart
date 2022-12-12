import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/AppBar/sc_workbench_card.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/AppBar/sc_workbench_search.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/AppBar/sc_workbench_switchspace_view.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/AppBar/sc_workbench_tabbar.dart';
import 'package:smartcommunity/Utils/sc_utils.dart';

/// 工作台-header

class SCWorkBenchHeader extends StatelessWidget {
  const SCWorkBenchHeader(
      {Key? key,
      required this.height,
      required this.tabController,
      required this.tabTitleList,
      required this.classificationList})
      : super(key: key);

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
    return DecoratedBox(decoration: const BoxDecoration(
      color: SCColors.color_F2F3F5
    ), child: SizedBox(
      width: double.infinity,
      height: height,
      child: body(context),
    ),);
  }

  /// body
  Widget body(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: SCUtils().getTopSafeArea()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SCWorkBenchSwitchSpaceView(
            onTap: (){},
            headerTap: (){},
          ),
          const SizedBox(
            height: 15.0,
          ),
          SCWorkBenchSearch(
            searchAction: (){},
            scanAction: (){},
            messageAction: (){},
          ),
          const SizedBox(
            height: 22.0,
          ),
          SCWorkBenchCard(),
          const SizedBox(
            height: 4.0,
          ),
          SCWorkBenchTabBar(
            tabController: tabController,
            tabTitleList: tabTitleList,
            classificationList: classificationList,
            currentTabIndex: 0,
            currentClassificationIndex: 0,
            menuTap: (){},
            tagTap: (int index){},
          )
        ],
      ),
    );
  }
}
