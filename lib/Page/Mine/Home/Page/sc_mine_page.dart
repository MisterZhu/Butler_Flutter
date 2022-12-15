import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Utils/Router/sc_router_helper.dart';
import '../../../../Utils/Router/sc_router_path.dart';
import '../../../../utils/sc_utils.dart';
import '../View/sc_mine_listview.dart';

/// 我的page
class SCMinePage extends StatefulWidget {
  @override
  SCMinePageState createState() => SCMinePageState();
}

class SCMinePageState extends State<SCMinePage> {
  @override
  Widget build(BuildContext context) {
    return body();
  }

  @override
  initState() {
    super.initState();
    SCUtils().changeStatusBarStyle(style: SystemUiOverlayStyle.light);
  }

  /// body
  Widget body() {
    return Scaffold(
      body: Container(
        color: SCColors.color_F2F3F5,
        width: double.infinity,
        height: double.infinity,
        child: SCMineListView(
          qrCodeTapAction: () {
            SCRouterHelper.pathPage(SCRouterPath.scanPath, null);
          },
          settingTapAction: () {
            SCRouterHelper.pathPage(SCRouterPath.settingPath, null);
          },
          avatarTapAction: () {
            SCRouterHelper.pathPage(SCRouterPath.personalInfoPath, null);
          },
          switchTapAction: () {
            SCRouterHelper.pathPage(SCRouterPath.switchIdentityPath, null);
          },
          userInfoTapAction: () {
            SCRouterHelper.pathPage(SCRouterPath.personalInfoPath, null);
          },
        ),
      ),
    );
  }
}
