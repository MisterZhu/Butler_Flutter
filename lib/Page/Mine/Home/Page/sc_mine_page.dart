import 'package:flutter/material.dart';
import 'package:smartcommunity/Skin/View/sc_custom_scaffold.dart';

/// 我的-page

class SCMinePage extends StatefulWidget {
  @override
  SCMinePageState createState() => SCMinePageState();
}

class SCMinePageState extends State<SCMinePage> {
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