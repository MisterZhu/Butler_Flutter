import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:smartcommunity/Constants/sc_key.dart';
import 'package:smartcommunity/Network/sc_config.dart';
import 'package:smartcommunity/Utils/Router/sc_router_path.dart';
import 'package:smartcommunity/Utils/sc_sp_utils.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Utils/sc_utils.dart';
import '../../../../Constants/sc_default_value.dart';
import '../../../../Constants/sc_h5.dart';
import '../../../../Skin/Tools/sc_scaffold_manager.dart';
import '../../../../Skin/View/sc_custom_scaffold.dart';
import '../../../../Utils/Router/sc_router_helper.dart';
import '../GetXController/sc_application_controller.dart';
import '../View/sc_application_listView.dart';

/// 全部应用-page

class SCApplicationPage extends StatefulWidget {
  @override
  SCApplicationPageState createState() => SCApplicationPageState();
}

class SCApplicationPageState extends State<SCApplicationPage>
    with AutomaticKeepAliveClientMixin {
  /// SCApplicationController
  late SCApplicationController state;

  /// SCApplicationController-tag
  late String tag;

  /// pageName
  late String pageName;

  late StreamSubscription subscription;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    pageName = (SCApplicationPage).toString();
    tag = SCScaffoldManager.instance.getXControllerTag(pageName);
    state = Get.put(SCApplicationController(), tag: tag);
    loadData();
    addNotification();
  }

  @override
  dispose() {
    super.dispose();
    subscription.cancel;
    SCScaffoldManager.instance.deleteGetXControllerTag(pageName, tag);
    refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(
        title: "全部应用",
        centerTitle: true,
        navBackgroundColor: SCColors.color_F2F3F5,
        elevation: 0,
        body: body());
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: GetBuilder<SCApplicationController>(
          tag: tag,
          init: state,
          builder: (state) {
            return SCApplicationListView(
              appList: state.moduleList,
              state: state,
              tag: tag,
              refreshController: refreshController,
              itemTapAction: (title, url) {
                /// 应用icon点击跳转
                itemDetail(title, url);
              },
              refreshAction: () {
                state.loadAppListData();
              },
            );
          }),
    );
  }

  /// 获取数据
  loadData() {
    state.loadAppListData();
  }

  /// 应用详情
  itemDetail(String title, String url) async {
    if (Platform.isAndroid) {
      String realUrl = SCUtils.getWebViewUrl(url: url, needJointParams: true);

      /// 调用Android WebView
      var params = {"title": title, "url": realUrl};
      var channel = SCScaffoldManager.flutterToNative;
      var result =
          await channel.invokeMethod(SCScaffoldManager.android_webview, params);

      /// todo 刷新控制台数据
      print("-------$result-------");
    } else {
      SCRouterHelper.pathPage(SCRouterPath.webViewPath,
          {"title": title, "url": url, "needJointParams": true});
    }
  }

  /// 通知
  addNotification() {
    subscription = SCScaffoldManager.instance.eventBus.on().listen((event) {
      String key = event['key'];
      if (key == SCKey.kSwitchEnterprise) {
        state.loadAppListData();
      }
    });
  }
}
