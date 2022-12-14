import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../GetXController/sc_switch_tenant_controller.dart';
import '../View/sc_switch_tenant_listview.dart';

/// 切换身份page

class SCSwitchTenantPage extends StatefulWidget {
  @override
  SCSwitchTenantPageState createState() => SCSwitchTenantPageState();
}

class SCSwitchTenantPageState extends State<SCSwitchTenantPage> {

  SCSwitchTenantController state = Get.put(SCSwitchTenantController());

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(navBackgroundColor: SCColors.color_F2F3F5, centerTitle: true, elevation: 0, body: body());
  }

  @override
  void initState() {
    super.initState();
    state.loadTenantListData();
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: SCSwitchTenantListView(),
    );
  }

}