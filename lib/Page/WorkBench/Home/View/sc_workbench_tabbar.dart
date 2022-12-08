import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';

/// 导航栏

class SCWorkBenchTabBar extends StatelessWidget {
  const SCWorkBenchTabBar(
      {Key? key,
      required this.tabController,
      required this.tabTitleList,
      required this.classificationList})
      : super(key: key);

  /// tabController
  final TabController tabController;

  /// tab标题list
  final List tabTitleList;

  /// 分类list
  final List classificationList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 110.0,
      child: Column(
        children: [
          tabBar(),
          const SizedBox(
            height: 16.0,
          ),
          classificationItem()
        ],
      ),
    );
  }

  /// tabBar
  Widget tabBar() {
    List<Tab> tabItemList = [];
    for (String title in tabTitleList) {
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
                controller: tabController,
                labelPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: SCColors.color_4285F4,
                unselectedLabelColor: SCColors.color_8D8E99,
                labelColor: SCColors.color_1B1D33,
                indicatorWeight: 3.0,
                labelStyle: const TextStyle(
                    fontSize: SCFonts.f16, fontWeight: FontWeight.w500),
                unselectedLabelStyle: const TextStyle(
                    fontSize: SCFonts.f16, fontWeight: FontWeight.w400),
                tabs: tabItemList,
              )),
        ));
  }

  /// 分类
  Widget classificationItem() {
    return SizedBox(
      height: 26.0,
      child: ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return classificationCell(index);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              width: 10.0,
            );
          },
          itemCount: classificationList.length),
    );
  }

  /// 分类cell
  Widget classificationCell(int index) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: SCColors.color_EDEDF0,
          borderRadius: BorderRadius.circular(13.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Text(
          classificationList[index],
          style: const TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: SCColors.color_5E5F66),
        ),
      ),
    );
  }
}
