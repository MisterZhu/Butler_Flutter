import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/WorkBench/sc_workbench_view.dart';

/// 工作台-page

class SCWorkBenchPage extends StatefulWidget {
  @override
  SCWorkBenchPageState createState() => SCWorkBenchPageState();
}

class SCWorkBenchPageState extends State<SCWorkBenchPage>
    with SingleTickerProviderStateMixin {
  /// tab-title
  List<String> tabTitleList = ['待办', '处理中'];

  /// 分类
  List<String> classificationList = [
    '工单处理',
    '订单处理',
    '居民审核',
    '维保维修',
    '三巡一保',
    '报事报修',
    '工单处理'
  ];

  /// tabController
  late TabController tabController;

  @override
  initState() {
    super.initState();
    tabController = TabController(length: tabTitleList.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SCColors.color_FFFFFF,
      body: body(),
    );
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return SCWorkBenchView(
          height: constraints.maxHeight,
          tabTitleList: tabTitleList,
          classificationList: classificationList,
          tabController: tabController,
        );
      }),
    );
  }
}
