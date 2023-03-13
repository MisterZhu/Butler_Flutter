import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/PurchaseSearch/sc_purchase_listview.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/PurchaseSearch/sc_search_view.dart';

import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../Controller/sc_purchase_search_controller.dart';

/// 搜索采购需求单page

class SCPurchaseSearchPage extends StatefulWidget {
  @override
  SCPurchaseSearchPageState createState() => SCPurchaseSearchPageState();
}

class SCPurchaseSearchPageState extends State<SCPurchaseSearchPage> {
  /// SCMaterialSearchController
  late SCPurchaseSearchController controller;

  /// SCMaterialSearchController - tag
  String controllerTag = '';

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance
        .getXControllerTag((SCPurchaseSearchPage).toString());
    controller = Get.put(SCPurchaseSearchController(), tag: controllerTag);
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "搜索",
        centerTitle: true,
        elevation: 0,
        resizeToAvoidBottomInset: false,
        body: body());
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: Column(
        children: [searchView(), listView()],
      ),
    );
  }

  /// 搜索框
  Widget searchView() {
    return SCSearchView(
      searchAction: (value) {},
    );
  }

  /// 采购单列表
  Widget listView() {
    return Expanded(
        child: GetBuilder<SCPurchaseSearchController>(
            tag: controllerTag,
            init: controller,
            builder: (state) {
              return SCPurchaseListView();
            }));
  }
}
