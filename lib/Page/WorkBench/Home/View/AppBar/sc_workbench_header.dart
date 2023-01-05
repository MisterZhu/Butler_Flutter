import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/AppBar/sc_workbench_card.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/AppBar/sc_workbench_search.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/AppBar/sc_workbench_switchspace_view.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/AppBar/sc_workbench_tabbar.dart';
import 'package:smartcommunity/Utils/sc_utils.dart';

import '../../../../../Network/sc_config.dart';
import '../../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../GetXController/sc_workbench_controller.dart';

/// 工作台-header

class SCWorkBenchHeader extends StatelessWidget {
  const SCWorkBenchHeader({
    Key? key,
    required this.state,
    required this.height,
    required this.tabController,
    required this.tabTitleList,
    required this.classificationList,
    this.switchSpaceAction,
    this.headerAction,
    this.searchAction,
    this.scanAction,
    this.messageAction,
    this.cardDetailAction,
    this.tagMenuAction,
    this.tagAction,
  }) : super(key: key);

  final SCWorkBenchController state;

  /// 组件高度
  final double height;

  /// tabController
  final TabController tabController;

  /// tab标题list
  final List tabTitleList;

  /// 分类list
  final List classificationList;

  /// 切换空间
  final Function? switchSpaceAction;

  /// 点击头像
  final Function? headerAction;

  /// 搜索
  final Function? searchAction;

  /// 扫一扫
  final Function? scanAction;

  /// 消息详情
  final Function? messageAction;

  /// 卡片详情
  final Function(int index)? cardDetailAction;

  /// 标签-菜单点击
  final Function? tagMenuAction;

  /// 点击标签
  final Function(int index)? tagAction;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: SCColors.color_F2F3F5),
      child: SizedBox(
        width: double.infinity,
        height: height,
        child: body(context),
      ),
    );
  }

  /// body
  Widget body(BuildContext context) {
    String spaceName = '';
    if (state.spaceName.isNotEmpty) {
      spaceName = state.spaceName;
    } else {
      spaceName = SCScaffoldManager.instance.user.tenantName ?? '';
    }
    return Padding(
      padding: EdgeInsets.only(top: SCUtils().getTopSafeArea()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SCWorkBenchSwitchSpaceView(
            avatar: SCConfig.getImageUrl(SCScaffoldManager.instance.user.headPicUri?.fileKey ?? ''),
            space: spaceName,
            onTap: () {
              switchSpaceAction?.call();
            },
            headerTap: () {
              headerAction?.call();
            },
          ),
          const SizedBox(
            height: 15.0,
          ),
          SCWorkBenchSearch(
            searchAction: () {
              searchAction?.call();
            },
            scanAction: () {
              scanAction?.call();
            },
            messageAction: () {
              messageAction?.call();
            },
          ),
          const SizedBox(
            height: 22.0,
          ),
          SCWorkBenchCard(
            data: state.numDataList,
            onTap: (int index) {
              cardDetailAction?.call(index);
            },
          ),
          const SizedBox(
            height: 4.0,
          ),
          SCWorkBenchTabBar(
            tabController: tabController,
            tabTitleList: tabTitleList,
            classificationList: classificationList,
            currentTabIndex: 0,
            menuTap: () {
              tagMenuAction?.call();
            },
            tagTap: (int index) {
              tagAction?.call(index);
            },
          )
        ],
      ),
    );
  }
}
