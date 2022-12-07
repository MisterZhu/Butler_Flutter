import 'package:flutter/material.dart';
import 'package:smartcommunity/Skin/View/sc_custom_scaffold.dart';

/// 工作台-page

class SCWorkBenchPage extends StatefulWidget {
  @override
  SCWorkBenchPageState createState() => SCWorkBenchPageState();
}

class SCWorkBenchPageState extends State<SCWorkBenchPage> {
  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(body: body());
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
    );
  }
}