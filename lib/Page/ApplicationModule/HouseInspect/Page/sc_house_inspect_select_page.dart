import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/HouseInspect/View/SelectHouse/sc_house_inspect_listview.dart';
import 'package:smartcommunity/Skin/View/sc_custom_scaffold.dart';

import '../../../../UIModule/Tab/sc_tabbar.dart';
import '../../../../UIModule/Tab/sc_tabview.dart';

/// 入伙验房-选择房号page

class SCHouseInspectSelectPage extends StatefulWidget {
  @override
  SCHouseInspectSelectPageState createState() => SCHouseInspectSelectPageState();
}

class SCHouseInspectSelectPageState extends State<SCHouseInspectSelectPage> with SingleTickerProviderStateMixin{

  /// tabController
  late TabController tabController;

  /// tab-title
  List<String> tabTitleList = ['第一苑', '第二苑', '第三苑', '第四苑', '第五苑'];

  @override
  initState() {
    super.initState();
    tabController = TabController(length: tabTitleList.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
      title: '选择房号',
        body: body()
    );
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_FFFFFF,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tabBar(),
          tabBarView()
        ],
      ),
    );
  }

  /// tabBar
  Widget tabBar() {
    return SCTabBar(tabController: tabController, titleList: tabTitleList);
  }

  /// tabBarView
  Widget tabBarView() {
    return Expanded(child: SCTabBarView(tabController: tabController, pages: pages()));
  }

  /// 测试页面
  List<Widget> pages() {
    List<Widget> list = [];
    for (int i=0; i<tabTitleList.length; i++) {
      list.add(SCSelectHouseListView());
    }
    return list;
  }
}