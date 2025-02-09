import 'dart:async';
import 'dart:convert';
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
import '../../../../Constants/sc_flutter_key.dart';
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

class SCApplicationPageState extends State<SCApplicationPage> with AutomaticKeepAliveClientMixin {
  /// SCApplicationController
  late SCApplicationController state;

  /// SCApplicationController-tag
  late String tag;

  /// pageName
  late String pageName;

  /// notify
  late StreamSubscription subscription;

  RefreshController refreshController = RefreshController(initialRefresh: false);

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
    if (title == "物资入库") {
      SCRouterHelper.pathPage(SCRouterPath.materialEntryPage, null);
      return;
    } else if (title == "物资出库") {
      SCRouterHelper.pathPage(SCRouterPath.materialOutboundPage, null);
      return;
    } else if (title == "物资调拨") {
      SCRouterHelper.pathPage(SCRouterPath.materialTransferPage, null);
      return;
    } else if (title == "物资报损") {
      SCRouterHelper.pathPage(SCRouterPath.materialFrmLossPage, null);
      return;
    } else if (title == "物资盘点") {
      SCRouterHelper.pathPage(SCRouterPath.materialCheckPage, null);
      return;
    } else if (title == "领料出入库") {
      SCRouterHelper.pathPage(SCRouterPath.materialRequisitionPage, null);
      return;
    } else if (title == "资产报损") {
      SCRouterHelper.pathPage(SCRouterPath.propertyFrmLossPage, null);
      return;
    } else if (title == "资产盘点") {
      SCRouterHelper.pathPage(SCRouterPath.fixedCheckPage, null);
      return;
    } else if (title == "预警中心") {
      SCRouterHelper.pathPage(SCRouterPath.warningCenterPage, null);
      return;
    } else if (title == "鹰眼服务") {
      SCRouterHelper.pathPage(SCRouterPath.onlineMonitorPage, null);
      return;
    } else if (title == "巡查") {
      SCRouterHelper.pathPage(SCRouterPath.patrolPage, {"pageType": 0});
      return;
    }else if (title == "巡检") {
      SCRouterHelper.pathPage(SCRouterPath.patrolPage, {"pageType": 2});
      return;
    }else if (title == "巡更") {
      SCRouterHelper.pathPage(SCRouterPath.patrolPage, {"pageType": 3});
      return;
    }

    if (Platform.isAndroid) {
      String realUrl =
          SCUtils.getWebViewUrl(url: url, title: title, needJointParams: true);
      SCRouterHelper.pathPage(SCRouterPath.webViewPath, {
        "title": title,
        "url": realUrl,
        "needJointParams": false
      })?.then((value) {
        if (value != null) {
          var params = jsonDecode(value);
          if (params.containsKey("orderId")) {
            SCLoadingUtils.show();
            Future.delayed(const Duration(milliseconds: 1000), () {
              SCLoadingUtils.hide();
              SCRouterHelper.pathPage(SCRouterPath.addOutboundPage,
                  {"isLL": true, "llData": params});
            });
          }
        }
      });
    } else if (Platform.isIOS) {
      String realUrl =
          SCUtils.getWebViewUrl(url: url, title: title, needJointParams: true);
      SCRouterHelper.pathPage(SCRouterPath.webViewPath, {
        "title": title,
        "url": realUrl,
        "needJointParams": false
      })?.then((value) {
        if (value != null && value is Map) {
          if (value.containsKey("key")) {
            String key = value['key'];
            if (key == SCFlutterKey.kGotoMaterialKey) {
              SCLoadingUtils.show();
              Future.delayed(const Duration(milliseconds: 1000), () {
                SCLoadingUtils.hide();
                SCRouterHelper.pathPage(SCRouterPath.addOutboundPage,
                    {"isLL": true, "llData": jsonDecode(value['data'])});
              });
            }
          }
        }
      });
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
