import 'package:flutter/material.dart';
import 'package:smartcommunity/Skin/View/sc_custom_scaffold.dart';

/// 应用-page

class SCApplicationPage extends StatefulWidget {
  @override
  SCApplicationPageState createState() => SCApplicationPageState();
}

class SCApplicationPageState extends State<SCApplicationPage> {
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