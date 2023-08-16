import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/src/delegate/sc_sticky_tabbar_delegate.dart';
import 'package:sc_uikit/src/styles/sc_colors.dart';
import 'package:sc_uikit/src/ui/detail/combination/sc_detail_cell.dart';
import 'package:sc_uikit/src/ui/tabbar/sc_base_tabbar.dart';

/// 详情view-tab类型
class SCDetailTabView extends StatelessWidget {
  /// tabController
  final TabController tabController;

  /// scrollController
  final ScrollController scrollController;

  /// tabBar-titleList
  final List<String> tabTitleList;

  /// tabBarView-list
  final List<Widget> tabBarViewList;

  /// header数据源
  final List headerList;

  /// content数据源
  final List contentList;

  /// 图片点击
  final Function(int imageIndex, List imageList, int section, int row)?
      imageTap;

  const SCDetailTabView(
      {Key? key,
      required this.tabController,
      required this.scrollController,
      required this.tabTitleList,
        required this.tabBarViewList,
        required this.headerList,
      required this.contentList,
      this.imageTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return ExtendedNestedScrollView(
        controller: scrollController,
        onlyOneScrollInBody: true,
        pinnedHeaderSliverHeightBuilder: () {
          return 40;
        },
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[scrollHeader(), stickyTabBar()];
        },
        body: TabBarView(
          controller: tabController,
          children: tabBarViewList,
        ));
  }

  /// scrollHeader
  Widget scrollHeader() {
    return SliverToBoxAdapter(
      child: header(0),
    );
  }

  /// tabbar
  Widget stickyTabBar() {
    return SliverPersistentHeader(
        pinned: true,
        floating: false,
        delegate: SCStickyTabBarDelegate(child: tabBarItem(), height: 40.0));
  }

  /// tabBar
  Widget tabBarItem() {
    return Padding(
      padding: const EdgeInsets.only(left: .0, right: .0),
      child: DecoratedBox(
        decoration: const BoxDecoration(
            color: SCColors.color_FFFFFF,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4.0), topRight: Radius.circular(4.0))),
        child: SCBaseTabBar(
            padding: EdgeInsets.zero,
            tabController: tabController,
            titleList: tabTitleList),
      ),
    );
  }

  /// tabBar-line
  Widget tabBarLine() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: .0),
        child: Container(
          height: 0.5,
          color: SCColors.color_E5E6EB,
        ),
      ),
    );
  }

  /// header
  Widget header(int index) {
    return Padding(
      padding: const EdgeInsets.only(left: .0, right: .0, bottom: 10.0),
      child: SCDetailCell(
        list: headerList,
        leftAction: (String value, int subIndex) {},
        rightAction: (String value, int subIndex) {},
        imageTap: (int imageIndex, List imageList, int subIndex) {
          /// todo 图片预览
          imageTap?.call(imageIndex, imageList, index, subIndex);
        },
      ),
    );
  }
}
