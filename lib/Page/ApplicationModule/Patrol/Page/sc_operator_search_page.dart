import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import 'package:smartcommunity/Skin/View/sc_custom_scaffold.dart';
import '../../../../Constants/sc_key.dart';
import '../Controller/sc_operator_search_controller.dart';
import '../View/Search/sc_operator_search_view.dart';

/// 搜索处理人page

class SCOperatorSearchPage extends StatefulWidget {
  @override
  SCOperatorSearchPageState createState() => SCOperatorSearchPageState();
}

class SCOperatorSearchPageState extends State<SCOperatorSearchPage> with AutomaticKeepAliveClientMixin{

  /// SCOperatorSearchController
  late SCOperatorSearchController controller;

  /// SCSearchPatrolController - tag
  String controllerTag = '';

  /// notify
  late StreamSubscription subscription;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  initState() {
    super.initState();
    controllerTag = SCScaffoldManager.instance.getXControllerTag((SCOperatorSearchPage).toString());
    controller = Get.put(SCOperatorSearchController(), tag: controllerTag);
    addNotification();
  }

  /// 通知
  addNotification() {
    subscription = SCScaffoldManager.instance.eventBus.on().listen((event) {
      String key = event['key'];
      if (key == SCKey.kRefreshPatrolPage) {
        controller.searchData(isMore: false);
      }
    });
  }

  @override
  dispose() {
    subscription.cancel();
    SCScaffoldManager.instance.deleteGetXControllerTag((SCOperatorSearchPage).toString(), controllerTag);
    controller.dispose();
    super.dispose();
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
      child: GetBuilder<SCOperatorSearchController>(
          tag: controllerTag,
          init: controller,
          builder: (state) {
            return SCOperatorSearchView(state: state);
          }),
    );
  }

}