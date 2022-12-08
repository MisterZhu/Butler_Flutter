import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Skin/View/sc_custom_scaffold.dart';

import '../../../../Utils/Router/sc_router_helper.dart';
import '../../../../Utils/Router/sc_router_path.dart';

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
      child: loginItem(),
    );
  }

  Widget loginItem() {
    return Padding(
      padding: const EdgeInsets.only(top: 150, left: 50.0),
      child: GestureDetector(
          onTap: () {
            SCRouterHelper.pathOffAllPage(SCRouterPath.loginPath, null);
          },
          child: const Text(
            '登录',
            style: TextStyle(
              fontSize: SCFonts.f16,
              fontWeight: FontWeight.w600,
              color: SCColors.color_1B1D33,),
          )
      ),
    );
  }
}