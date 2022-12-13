import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/Alert/SwitchSpace/sc_workbench_changespace_alert.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/PageView/sc_workbench_listview.dart';
import 'package:smartcommunity/Utils/sc_utils.dart';

import '../AppBar/sc_workbench_header.dart';

/// 工作台-view

class SCWorkBenchView extends StatelessWidget {
  SCWorkBenchView(
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

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
        enableScrollWhenRefreshCompleted: true,
        child: SmartRefresher(
          controller: refreshController,
          enablePullUp: false,
          enablePullDown: true,
          header: const SCCustomHeader(
            style: SCCustomHeaderStyle.noNavigation,
          ),
          onRefresh: onRefresh,
          child: listView(),
        ));
  }

  /// listView
  Widget listView() {
    double headerHeight = 305.0 + SCUtils().getTopSafeArea();
    double contentHeight = height - headerHeight;
    return ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          return SCStickyHeader(
              header: headerView(headerHeight, context),
              content: pageView(contentHeight));
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox();
        },
        itemCount: 1);
  }

  /// header
  Widget headerView(double height, BuildContext context) {
    return SCWorkBenchHeader(
      height: height,
      tabTitleList: tabTitleList,
      classificationList: classificationList,
      tabController: tabController,
      switchSpaceAction: () {
        switchAction(context);
      },
    );
  }

  /// pageView
  Widget pageView(double height) {
    Widget tabBarView = SizedBox(
      height: height,
      child: TabBarView(controller: tabController, children: [
        const SCWorkBenchListView(),
        Container(
          color: Colors.white,
        )
      ]),
    );
    return tabBarView;
  }

  /// 下拉刷新
  Future onRefresh() async {
    Future.delayed(const Duration(milliseconds: 1500), () {
      refreshController.refreshCompleted();
    });
  }

  /// 切换空间
  switchAction(BuildContext context) {
    SCDialogUtils().showCustomBottomDialog(
        context: context,
        isDismissible: true,
        widget: SCWorkBenchChangeSpaceAlert());
  }
}
