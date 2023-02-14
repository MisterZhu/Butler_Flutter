import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/Controller/sc_material_entry_controller.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Constants/sc_key.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../View/MaterialEntry/sc_material_entry_view.dart';

/// 物资入库page

class SCMaterialEntryPage extends StatefulWidget {
  @override
  SCMaterialEntryPageState createState() => SCMaterialEntryPageState();
}

class SCMaterialEntryPageState extends State<SCMaterialEntryPage> {

  /// SCMaterialEntryController
  late SCMaterialEntryController entryController;

  /// SCMaterialEntryController - tag
  String entryControllerTag = '';

  /// notify
  late StreamSubscription subscription;

  @override
  initState() {
    super.initState();
    entryControllerTag = SCScaffoldManager.instance
        .getXControllerTag((SCMaterialEntryPage).toString());
    entryController = Get.put(SCMaterialEntryController(), tag: entryControllerTag);
    entryController.loadEntryListData(isMore: false);
    addNotification();
  }

  @override
  dispose() {
    subscription.cancel();
    SCScaffoldManager.instance.deleteGetXControllerTag(pageName(), entryControllerTag);
    entryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "物资入库", centerTitle: true, elevation: 0, body: body());
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: GetBuilder<SCMaterialEntryController>(
          tag: entryControllerTag,
          init: entryController,
          builder: (state) {
            return SCMaterialEntryView(state: state,);
          }),
    );
  }

  /// pageName
  String pageName() {
    return (SCMaterialEntryPage).toString();
  }

  /// 通知
  addNotification() {
    subscription = SCScaffoldManager.instance.eventBus.on().listen((event) {
      String key = event['key'];
      if (key == SCKey.kRefreshMaterialEntryPage) {
        entryController.loadEntryListData(isMore: false);
      }
    });
  }
}
