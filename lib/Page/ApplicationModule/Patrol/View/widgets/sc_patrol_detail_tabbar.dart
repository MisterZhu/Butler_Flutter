import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';

import '../../../../../Network/sc_config.dart';

/// 导航栏

class SCPatrolDetailTabBar extends StatefulWidget {
  SCPatrolDetailTabBar(
      {Key? key,
      required this.tabController,
      required this.tabTitleList,
      required this.currentTabIndex})
      : super(key: key);

  /// tabController
  final TabController tabController;

  /// tab标题list
  final List tabTitleList;

  /// 当前tabIndex
  final int currentTabIndex;


  @override
  SCPatrolDetailTabBarState createState() => SCPatrolDetailTabBarState();
}

class SCPatrolDetailTabBarState extends State<SCPatrolDetailTabBar> {

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.0,
      child: tabBar(),
    );
  }

  /// tabBar
  Widget tabBar() {
    List<Tab> tabItemList = [];
    for (String title in widget.tabTitleList) {
      tabItemList.add(Tab(
        text: title,
      ));
    }
    return PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: Material(
          color: Colors.transparent,
          child: Theme(
              data: ThemeData(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent),
              child: TabBar(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                controller: widget.tabController,
                labelPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: SCTabIndicator(indicatorWidth: 28.0, borderSide: const BorderSide(width: 2.5, color: SCColors.color_4285F4)),
                indicatorColor: SCColors.color_4285F4,
                unselectedLabelColor: SCColors.color_5E5F66,
                labelColor: SCColors.color_1B1D33,
                indicatorWeight: 2.5,
                labelStyle: TextStyle(
                    fontSize: SCFonts.f14,
                    fontWeight: FontWeight.w500,
                    fontFamilyFallback: SCConfig.getPFSCForIOS(),
                    color: SCColors.color_1B1D33),
                unselectedLabelStyle: const TextStyle(
                    fontSize: SCFonts.f14,
                    fontWeight: FontWeight.w400,
                    color: SCColors.color_5E5F66),
                tabs: tabItemList,
              )),
        ));
  }
}
