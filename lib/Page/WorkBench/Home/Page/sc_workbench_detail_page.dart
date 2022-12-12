import 'package:flutter/cupertino.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/PageView/sc_workbench_listview.dart';
import 'package:smartcommunity/Skin/View/sc_custom_scaffold.dart';

/// 详情-page

class SCWorkBenchDetailPage extends StatefulWidget {
  @override
  SCWorkBenchDetailPageState createState() => SCWorkBenchDetailPageState();
}

class SCWorkBenchDetailPageState extends State<SCWorkBenchDetailPage> {
  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(body: Container(
      width: double.infinity,
      height: double.infinity,
      child: const SCWorkBenchListView(),
    ));
  }
}