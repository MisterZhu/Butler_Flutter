import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';

/// tabBar

class SCTabBar extends StatelessWidget {
  const SCTabBar(
      {Key? key, required this.tabController, required this.titleList})
      : super(key: key);

  /// tabController
  final TabController tabController;

  /// titleList
  final List<String> titleList;

  @override
  Widget build(BuildContext context) {
    List<Tab> tabItemList = [];
    for (String title in titleList) {
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
                controller: tabController,
                labelPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: SCColors.color_4285F4,
                unselectedLabelColor: SCColors.color_5E5F66,
                labelColor: SCColors.color_1B1D33,
                indicatorWeight: 2.0,
                labelStyle: const TextStyle(
                    fontSize: SCFonts.f14,
                    fontWeight: FontWeight.w500,
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
