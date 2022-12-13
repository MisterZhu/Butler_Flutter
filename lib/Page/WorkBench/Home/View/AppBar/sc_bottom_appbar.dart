import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';

/// 底部导航栏

class SCBottomAppBar extends StatefulWidget {
  const SCBottomAppBar(
      {Key? key,
      required this.tabBarTitleList,
      required this.tabBarNormalImageList,
      required this.tabBarSelectImageList,
      required this.defaultIndex,
      this.onTap})
      : super(key: key);

  /// tabBar默认图片列表
  final List<String> tabBarNormalImageList;

  /// tabBar选中图片列表
  final List<String> tabBarSelectImageList;

  /// tabBar-title
  final List<String> tabBarTitleList;

  /// tabBar点击
  final Function(int index)? onTap;

  /// 默认index
  final int defaultIndex;

  @override
  SCBottomAppBarState createState() => SCBottomAppBarState();
}

class SCBottomAppBarState extends State<SCBottomAppBar> {
  int currentIndex = 0;

  @override
  initState() {
    super.initState();
    currentIndex = widget.defaultIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
            brightness: Brightness.dark,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent),
        child: bottomAppBar());
  }

  /// 底部导航栏
  Widget bottomAppBar() {
    return BottomAppBar(
      color: Colors.white,
      shape: const CircularNotchedRectangle(),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: bottomAppBarItems(),
        ),
      ),
    );
  }

  /// 底部导航栏-所有item
  List<Widget> bottomAppBarItems() {
    List<Widget> list = [];
    for (int i = 0; i < widget.tabBarTitleList.length; i++) {
      Widget item;
      if (i == widget.tabBarTitleList.length - 1) {
        item = const Expanded(flex: 1, child: SizedBox());
      } else {
        item = bottomAppBarItem(i);
      }
      list.add(item);
    }
    return list;
  }

  /// 底部导航栏-item
  Widget bottomAppBarItem(int index) {
    return Expanded(
        flex: 1,
        child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              tabBarItemTap(index);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                getTabBarItemIcon(index),
                const SizedBox(
                  height: 2.0,
                ),
                getTabBarItemTitle(index)
              ],
            )));
  }

  /// tabBar-item-text-color
  Color getTabBarItemTextColor(int index) {
    return currentIndex == index
        ? SCColors.color_4285F4
        : SCColors.color_5E5F66;
  }

  /// tabBar-item-title
  Widget getTabBarItemTitle(int index) {
    String title = widget.tabBarTitleList[index];
    Color color = getTabBarItemTextColor(index);
    return Text(title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: SCFonts.f10, fontWeight: FontWeight.w400, color: color));
  }

  /// tabBar-item-icon
  Widget getTabBarItemIcon(int index) {
    String path = '';
    if (currentIndex == index) {
      path = widget.tabBarSelectImageList[index];
    } else {
      path = widget.tabBarNormalImageList[index];
    }
    return Image.asset(
      path,
      width: 24.0,
      height: 24.0,
      excludeFromSemantics: true,
      gaplessPlayback: true,
    );
  }

  /*底部tabBar点击*/
  void tabBarItemTap(int index) {
    if (index < widget.tabBarTitleList.length - 1 && index != currentIndex) {
      setState(() {
        widget.onTap?.call(index);
        currentIndex = index;
      });
    }
  }
}
