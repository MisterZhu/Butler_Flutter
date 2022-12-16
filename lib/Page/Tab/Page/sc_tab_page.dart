import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:smartcommunity/Page/AddressBook/Home/Page/sc_addressbook_page.dart';
import 'package:smartcommunity/Page/Application/Home/Page/sc_application_page.dart';
import 'package:smartcommunity/Page/Mine/Home/Page/sc_mine_page.dart';
import 'package:smartcommunity/Page/Tab/View/sc_tab_floating_button.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Page/sc_workbench_page.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/AppBar/sc_bottom_appbar.dart';
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
      SCUtils().changeStatusBarStyle(style: SystemUiOverlayStyle.light);
    } else if (index == 1) {
      SCUtils().changeStatusBarStyle(style: SystemUiOverlayStyle.dark);
    } else if (index == 2) {
      SCUtils().changeStatusBarStyle(style: SystemUiOverlayStyle.dark);
    } else {
      SCUtils().changeStatusBarStyle(style: SystemUiOverlayStyle.dark);
    }
  }

  /// floating点击，弹出
  floatingAction() {
    List testList = [
      {"icon": {"fileKey": "", "name": SCAsset.iconApplicationWorkOrder}, "id": 1, "name": "工单调度", "url": ""},
      {"icon": {"fileKey": "", "name": SCAsset.iconApplicationVehicleRegistration}, "id": 2, "name": "车访登记", "url": ""},
      {"icon": {"fileKey": "", "name": SCAsset.iconApplicationReportRepair}, "id": 3, "name": "报事报修", "url": ""},
    ];
    List<MenuServerList> list = testList.map((e) => MenuServerList.fromJson(e)).toList();

    SCUtils.getCurrentContext(completionHandler: (BuildContext context) {
      SCDialogUtils().showCustomBottomDialog(
          isDismissible: true,
          context: context,
          widget: SCQuickApplicationAlert(
            list: list,
            tapAction: (id, text) {
              Navigator.of(context).pop();
              if (id == 0) {
                SCRouterHelper.pathPage(SCRouterPath.applicationPath, null);
              }
            },
          ));
    });
  }
}
