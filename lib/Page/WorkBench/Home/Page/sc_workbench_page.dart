import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/sc_workbench_view.dart';

/// 工作台-page

class SCWorkBenchPage extends StatefulWidget {
  @override
  SCWorkBenchPageState createState() => SCWorkBenchPageState();
}

class SCWorkBenchPageState extends State<SCWorkBenchPage> with SingleTickerProviderStateMixin {

  @override
  initState() {
    super.initState();
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
      color: Colors.white,
      child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
        return SCWorkBenchView(
          height: constraints.maxHeight,
        );
      }),
    );
  }

}