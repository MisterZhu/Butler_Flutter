import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';

/// 导航栏

class SCWorkBenchTabBar extends StatefulWidget {
  SCWorkBenchTabBar(
      {Key? key,
      required this.tabController,
      required this.tabTitleList,
      required this.currentTabIndex,
      this.siftAction,})
      : super(key: key);

  /// tabController
  final TabController tabController;

  /// tab标题list
  final List tabTitleList;

  /// 当前tabIndex
  final int currentTabIndex;

  /// 点击筛选
  final Function? siftAction;


  @override
  SCWorkBenchTabBarState createState() => SCWorkBenchTabBarState();
}

class SCWorkBenchTabBarState extends State<SCWorkBenchTabBar> {

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: tabBar()),
          const SizedBox(
            height: 20.0,
          ),
          CupertinoButton(
              minSize: 44.0,
              padding: EdgeInsets.zero,
              child: Image.asset(
                SCAsset.iconWorkBenchTaskSift,
                width: 20.0,
                height: 20.0,
              ),
              onPressed: () {
                widget.siftAction?.call();
              })
        ],
      ),
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
                //indicator: SCTabIndicator(borderSide: const BorderSide(width: 28.0, color: SCColors.color_4285F4)),
                indicatorColor: SCColors.color_4285F4,
                unselectedLabelColor: SCColors.color_5E5F66,
                labelColor: SCColors.color_1B1D33,
                indicatorWeight: 2.5,
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
