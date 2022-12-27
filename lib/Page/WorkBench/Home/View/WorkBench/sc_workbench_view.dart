import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/WorkBench/Home/GetXController/sc_changespace_controller.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Model/sc_space_model.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Model/sc_work_order_model.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/Alert/SwitchSpace/sc_workbench_changespace_alert.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/PageView/sc_workbench_listview.dart';
import 'package:smartcommunity/Utils/sc_utils.dart';

import '../../GetXController/sc_workbench_controller.dart';
import '../AppBar/sc_workbench_header.dart';

/// 工作台-view

class SCWorkBenchView extends StatelessWidget {
  SCWorkBenchView(
      {Key? key,
      required this.state,
      required this.changeSpaceController,
      required this.height,
      required this.tabController,
      required this.tabTitleList,
      required this.classificationList,
      this.tagAction,
      this.menuTap,
      this.onRefreshAction,
      this.detailAction
      })
      : super(key: key);

  final SCWorkBenchController state;

  /// 切换空间controller
  final SCChangeSpaceController changeSpaceController;

  /// 组件高度
  final double height;

  /// tabController
  final TabController tabController;

  /// tab标题list
  final List tabTitleList;

  /// 分类list
  final List classificationList;

  /// 点击菜单
  final Function? menuTap;

  /// 点击标签
  final Function(int index)? tagAction;

  /// 详情
  final Function(SCWorkOrderModel model)? detailAction;

  /// 下拉刷新
  final Function? onRefreshAction;

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
      state: state,
      height: height,
      tabTitleList: tabTitleList,
      classificationList: classificationList,
      tabController: tabController,
      tagAction: (index) {
        tagAction?.call(index);
      },
      tagMenuAction: () {
        menuTap?.call();
      },
      switchSpaceAction: () {
        switchAction(context);
      },
    );
  }

  /// pageView
  Widget pageView(double height) {
    Widget tabBarView = SizedBox(
      height: height,
      child: TabBarView(
        controller: tabController,
        children: [
          SCWorkBenchListView(
            dataList: state.dataList,
            detailAction: (SCWorkOrderModel model){
              detail(model);
            },
          ),
          Container(color: Colors.white,)
      ]),
    );
    return tabBarView;
  }

  /// 下拉刷新
  Future onRefresh() async {
    Future.delayed(const Duration(milliseconds: 1500), () {
      refreshController.refreshCompleted();
      onRefreshAction?.call();
    });
  }

  /// 切换空间
  switchAction(BuildContext context) {
    changeSpaceController.clearData();
    changeSpaceController.loadManageTreeData(success: (List<SCSpaceModel> list){
      SCDialogUtils().showCustomBottomDialog(
          context: context,
          isDismissible: true,
          widget: GetBuilder<SCChangeSpaceController>(builder: (state){
            return SCWorkBenchChangeSpaceAlert(
              changeSpaceController: changeSpaceController,
              selectList: state.dataList,
            );
          }));
    });
  }

  /// 详情
  detail(SCWorkOrderModel model) {
    detailAction?.call(model);
  }
}
