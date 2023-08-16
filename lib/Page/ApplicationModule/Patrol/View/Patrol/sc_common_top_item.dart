
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';



class CommonTabTopItem extends StatelessWidget {

  CommonTabTopItem({
    Key? key,
    required this.tabController,
    required this.titleList,
  }) : super(key: key);

  final TabController tabController;

  final List titleList;

  List<Tab> tabItemList = [];

  @override
  Widget build(BuildContext context) {
    for (String title in titleList) {
      tabItemList.add(Tab(text: title,));
    }
    return Container(
      width: double.infinity,
      height: 44.0,
      color: SCColors.color_FFFFFF,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          tabBarItem(),
        ],
      ),
    );
  }

  Widget tabBarItem() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      width: 300.0,
      height: 44.0,
      color: SCColors.color_FFFFFF,
      child: PreferredSize(
          preferredSize: const Size.fromHeight(44.0),
          child: Material(
            color: Colors.transparent,
            child: Theme(
                data: ThemeData(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent),
                child: TabBar(
                    controller: tabController,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                    isScrollable: true, //为false时不能滚动，标题会平分宽度显示，为true时会紧凑排列
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: SCColors.color_4285F4,
                    unselectedLabelColor: SCColors.color_5E5E66,
                    labelColor: SCColors.color_1B1D33,
                    indicatorWeight: 2.0,
                    labelStyle:
                    const TextStyle(fontSize: SCFonts.f14, fontWeight: FontWeight.w600),
                    unselectedLabelStyle: const TextStyle(
                        fontSize: SCFonts.f14, fontWeight: FontWeight.w400),
                    tabs: tabItemList
                )),
          )),
    );
  }
}