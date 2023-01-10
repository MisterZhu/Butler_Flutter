import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';

/// 导航栏

class SCWorkBenchTabBar extends StatefulWidget {
  SCWorkBenchTabBar(
      {Key? key,
      required this.tabController,
      required this.tabTitleList,
      required this.classificationList,
      required this.currentTabIndex,
      required this.currentTagIndex,
      this.menuTap,
      this.tagTap})
      : super(key: key);

  /// tabController
  final TabController tabController;

  /// tab标题list
  final List tabTitleList;

  /// 分类list
  final List classificationList;

  /// 当前tabIndex
  final int currentTabIndex;

  /// 当前tagIndex
  final int currentTagIndex;

  /// 点击菜单
  final Function? menuTap;

  /// 标签点击
  final Function(int index)? tagTap;

  @override
  SCWorkBenchTabBarState createState() => SCWorkBenchTabBarState();
}

class SCWorkBenchTabBarState extends State<SCWorkBenchTabBar> {
  /// 分类-index
  int currentClassificationIndex = 0;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    currentClassificationIndex = widget.currentTagIndex;
    return SizedBox(
      height: 96.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tabBar(),
          const SizedBox(
            height: 18.0,
          ),
          classificationItem()
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
                indicatorColor: SCColors.color_4285F4,
                unselectedLabelColor: SCColors.color_5E5F66,
                labelColor: SCColors.color_1B1D33,
                indicatorWeight: 2.0,
                labelStyle: const TextStyle(
                    fontSize: SCFonts.f16,
                    fontWeight: FontWeight.w500,
                    color: SCColors.color_1B1D33),
                unselectedLabelStyle: const TextStyle(
                    fontSize: SCFonts.f16,
                    fontWeight: FontWeight.w400,
                    color: SCColors.color_5E5F66),
                tabs: tabItemList,
              )),
        ));
  }

  /// 分类
  Widget classificationItem() {
    return SizedBox(
      height: 26.0,
      width: double.infinity,
      child: Stack(
        children: [
          ListView.separated(
              padding: const EdgeInsets.only(left: 16.0, right: 48.0),
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
              itemCount: widget.classificationList.length),
          menuItem()
        ],
      ),
    );
  }

  /// 菜单
  Widget menuItem() {
    return Positioned(
        right: 0,
        top: 0,
        bottom: 0,
        child: GestureDetector(
          onTap: () {
            menuAction();
          },
          child: SizedBox(
            width: 48.0,
            height: 37.0,
            child: Row(
              children: [
                Container(
                  width: 8.0,
                  height: 37.0,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                        SCColors.color_F2F3F5.withOpacity(0.3),
                        SCColors.color_F2F3F5.withOpacity(0.5),
                        SCColors.color_F2F3F5
                      ])),
                ),
                Expanded(
                    child: Container(
                  alignment: Alignment.centerLeft,
                  color: SCColors.color_F2F3F5,
                  padding: const EdgeInsets.only(left: .0),
                  child: Image.asset(
                    SCAsset.iconGreyMenu,
                    width: 20.0,
                    height: 20.0,
                  ),
                ))
              ],
            ),
          ),
        ));
  }

  /// 分类cell
  Widget classificationCell(int index) {
    /// 背景颜色
    Color backgroundColor;

    /// 文字颜色
    Color textColor;

    /// decoration
    BoxDecoration decoration;

    /// title
    String title =  widget.classificationList[index]['title'];
    if (index == currentClassificationIndex) {
      backgroundColor = SCColors.color_EBF2FF;
      textColor = SCColors.color_4285F4;
      decoration = BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(13.0),
          border: Border.all(width: 0.5, color: SCColors.color_4285F4));
    } else {
      backgroundColor = SCColors.color_EDEDF0;
      textColor = SCColors.color_5E5F66;
      decoration = BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(13.0));
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          currentClassificationIndex = index;
        });
        widget.tagTap?.call(index);
      },
      child: Container(
        height: 26.0,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        decoration: decoration,
        child: Text(
         title,
          style: TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: textColor),
          strutStyle: const StrutStyle(
            fontSize: SCFonts.f14,
            height: 1.25,
            forceStrutHeight: true,
          ),
        ),
      ),
    );
  }

  /// 点击菜单
  menuAction() {
    widget.menuTap?.call();
  }
}
