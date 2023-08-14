import 'package:flutter/material.dart';
import 'package:sc_tools/sc_tools.dart';
import 'package:sc_uikit/src/styles/sc_colors.dart';
import 'package:sc_uikit/src/styles/sc_fonts.dart';

/// tabBar

class SCBaseTabBar extends StatelessWidget {
  const SCBaseTabBar(
      {Key? key,
      required this.tabController,
      required this.titleList,
      this.padding})
      : super(key: key);

  /// tabController
  final TabController tabController;

  /// titleList
  final List<String> titleList;

  /// padding
  final EdgeInsetsGeometry? padding;

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
                padding: padding ?? const EdgeInsets.symmetric(horizontal: 6.0),
                controller: tabController,
                labelPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: SCColors.color_4285F4,
                unselectedLabelColor: SCColors.color_5E5F66,
                labelColor: SCColors.color_1B1D33,
                indicatorWeight: 2.0,
                labelStyle: TextStyle(
                    fontFamilyFallback: SCToolsConfig.getPFSCForIOS(),
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
