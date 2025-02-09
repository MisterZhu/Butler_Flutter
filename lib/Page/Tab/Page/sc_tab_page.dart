import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:smartcommunity/Constants/sc_default_value.dart';
import 'package:smartcommunity/Constants/sc_h5.dart';
import 'package:smartcommunity/Constants/sc_key.dart';
import 'package:smartcommunity/Network/sc_config.dart';
import 'package:smartcommunity/Network/sc_url.dart';
import 'package:smartcommunity/Page/AddressBook/Home/Page/sc_addressbook_page.dart';
import 'package:smartcommunity/Page/Application/Home/Page/sc_application_page.dart';
import 'package:smartcommunity/Page/Mine/Home/Page/sc_mine_page.dart';
import 'package:smartcommunity/Page/Tab/View/sc_tab_floating_button.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Page/sc_workbench_page.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/AppBar/sc_bottom_appbar.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import 'package:smartcommunity/Utils/Router/sc_router_path.dart';
import '../../../Utils/sc_utils.dart';
import '../../Application/Home/Model/sc_application_module_model.dart';
import '../../WorkBench/Home/View/Alert/sc_quick_application_alert.dart';

/// tab-page

class SCTabPage extends StatefulWidget {
  @override
  SCTabState createState() => SCTabState();
}

class SCTabState extends State<SCTabPage> with TickerProviderStateMixin {
  late TabController tabController;
  late PageController pageController;
  late List<Widget> pageList;

  /// tabBar默认图片列表
  late List<String> tabBarNormalImageList;

  /// tabBar选中图片列表
  late List<String> tabBarSelectImageList;

  /// tabBar-title
  late List<String> tabBarTitleList;

  /// page-index
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabBarNormalImageList = [
      SCAsset.iconTabWorkBenchNormal,
      //SCAsset.iconTabAddressBookNormal,
      SCAsset.iconTabApplicationNormal,
      SCAsset.iconTabMineNormal,
      ''
    ];
    tabBarSelectImageList = [
      SCAsset.iconTabWorkBenchselect,
      //SCAsset.iconTabAddressBookSelect,
      SCAsset.iconTabApplicationSelect,
      SCAsset.iconTabMineSelect,
      ''
    ];
    tabBarTitleList = ['工作台', '应用', '我的', ''];
    pageList = [
      SCWorkBenchPage(),
      //SCAddressBookPage(),
      SCApplicationPage(),
      SCMinePage(),
      emptyPage()
    ];
    tabController = TabController(length: pageList.length, vsync: this);
    pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: pageList,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: SCTabFloatingButton(
        onPressed: () {
          floatingAction();
        },
      ),
      bottomNavigationBar: SCBottomAppBar(
        tabBarTitleList: tabBarTitleList,
        tabBarNormalImageList: tabBarNormalImageList,
        tabBarSelectImageList: tabBarSelectImageList,
        defaultIndex: currentIndex,
        onTap: (int index) {
          currentIndex = index;
          pageController.jumpToPage(index);
          updateStatusBar(index);
        },
      ),
    );
  }

  /// 空白页面
  Widget emptyPage() {
    return Container(
      color: Colors.white,
    );
  }

  /// 更新状态栏
  updateStatusBar(int index) {
    if (index == 0) {
      SCUtils().changeStatusBarStyle(style: SystemUiOverlayStyle.dark);
      updateWorkBench();
    } else if (index == 1) {
      SCUtils().changeStatusBarStyle(style: SystemUiOverlayStyle.dark);
    } else if (index == 2) {
      SCUtils().changeStatusBarStyle(style: SystemUiOverlayStyle.dark);
    } else {
      SCUtils().changeStatusBarStyle(style: SystemUiOverlayStyle.dark);
    }
  }

  /// 刷新工作台
  updateWorkBench() {
    var params = {"key": SCKey.kSwitchEnterprise};
    SCScaffoldManager.instance.eventBus.fire(params);
  }

  /// floating点击，弹出
  floatingAction() {
    List testList = [
      {
        "icon": {"fileKey": "", "name": SCAsset.iconApplicationQuickReport},
        "id": 1,
        "name": "快捷报事",
        "url": SCConfig.getH5Url(SCH5.quickReportUrl)
      },
      // {
      //   "icon": {
      //     "fileKey": "",
      //     "name": SCAsset.iconApplicationVehicleRegistration
      //   },
      //   "id": 2,
      //   "name": "车访登记",
      //   "url": ""
      // },
      // {
      //   "icon": {"fileKey": "", "name": SCAsset.iconApplicationReportRepair},
      //   "id": 3,
      //   "name": "报事报修",
      //   "url": ""
      // },
    ];
    List<SCMenuItemModel> list =
        testList.map((e) => SCMenuItemModel.fromJson(e)).toList();

    /// todo 亚运村项目临时修改
    if (SCConfig.yycTenantId() ==
            (SCScaffoldManager.instance.defaultConfigModel?.tenantId ?? '') &&
        SCScaffoldManager.instance.user.mobileNum != '13695805827') {
      list = [];
    }

    SCUtils.getCurrentContext(completionHandler: (BuildContext context) {
      SCDialogUtils().showCustomBottomDialog(
          isDismissible: true,
          context: context,
          widget: SCQuickApplicationAlert(
            list: list,
            tapAction: (id, text, url) {
              // if (id == 0) {
              //   Navigator.of(context).pop();
              //   SCRouterHelper.pathPage(SCRouterPath.applicationPath, null);
              // } else {

              debugPrint(
                  'The answer url: ${SCUtils.getWebViewUrl(url: url, title: text, needJointParams: true)}');
              SCRouterHelper.pathPage(SCRouterPath.webViewPath, {
                "title": text,
                "url": SCUtils.getWebViewUrl(
                    url: url, title: text, needJointParams: true)
              });
              // }
            },
          ));
    });
  }
}
