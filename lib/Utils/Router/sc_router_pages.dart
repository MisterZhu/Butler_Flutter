import 'package:get/get.dart';
import 'package:smartcommunity/Page/AddressBook/Home/Page/sc_addressbook_page.dart';
import 'package:smartcommunity/Page/Application/Home/Page/sc_application_page.dart';
import 'package:smartcommunity/Page/Base/Scan/Page/sc_scan_page.dart';
import 'package:smartcommunity/Page/Login/Home/Page/sc_login_page.dart';
import 'package:smartcommunity/Page/Login/Privacy/Page/sc_privacy_alert_page.dart';
import 'package:smartcommunity/Page/Mine/Home/Page/sc_mine_page.dart';
import 'package:smartcommunity/Page/Mine/Home/Page/sc_setting_page.dart';
import 'package:smartcommunity/Page/Mine/Home/Page/sc_switch_tenant_page.dart';
import 'package:smartcommunity/Page/Tab/Page/sc_tab_page.dart';
import 'package:smartcommunity/Page/Webview/Page/sc_webview_page.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Page/sc_workbench_detail_page.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Page/sc_workbench_page.dart';
import '../../Page/ApplicationModule/HouseInspect/Page/sc_formal_house_inspect_detail_page.dart';
import '../../Page/ApplicationModule/HouseInspect/Page/sc_formal_house_inspect_page.dart';
import '../../Page/ApplicationModule/HouseInspect/Page/sc_house_inspect_form_page.dart';
import '../../Page/ApplicationModule/HouseInspect/Page/sc_house_inspect_problem_page.dart';
import '../../Page/Mine/Home/Page/sc_personal_info_page.dart';
import 'sc_router_path.dart';

/// 路由-pages
class SCRouterPages {
  /*根据path使用路由*/
  static final List<GetPage> getPages = [
    /*用户协议和隐私政策弹窗*/
    GetPage(name: SCRouterPath.basePrivacyPath, page: () => SCPrivacyAlertPage()),
    /*登录*/
    GetPage(name: SCRouterPath.loginPath, page: () => SCLoginPage()),
    /*tab*/
    GetPage(name: SCRouterPath.tabPath, page: () => SCTabPage()),
    /*工作台*/
    GetPage(name: SCRouterPath.workBenchPath, page: () => SCWorkBenchPage()),
    /*通讯录*/
    GetPage(name: SCRouterPath.addressBookPath, page: () => SCAddressBookPage()),
    /*应用*/
    GetPage(name: SCRouterPath.applicationPath, page: () => SCApplicationPage()),
    /*我的*/
    GetPage(name: SCRouterPath.minePath, page: () => SCMinePage()),
    /*扫一扫*/
    GetPage(name: SCRouterPath.scanPath, page: () => SCScanPage()),
    /*webView*/
    GetPage(name: SCRouterPath.webViewPath, page: () => SCWebViewPage()),
    /*工作台详情*/
    GetPage(name: SCRouterPath.workBenchDetailPath, page: () => SCWorkBenchDetailPage()),
    /*设置*/
    GetPage(name: SCRouterPath.settingPath, page: () => SCSettingPage()),
    /*切换身份*/
    GetPage(name: SCRouterPath.switchIdentityPath, page: () => SCSwitchTenantPage()),
    /*个人资料*/
    GetPage(name: SCRouterPath.personalInfoPath, page: () => SCPersonalInfoPage()),
    /*正式验房*/
    GetPage(name: SCRouterPath.formalHouseInspectPage, page: () => SCFormalHouseInspectPage()),
    /*正式验房-详情*/
    GetPage(name: SCRouterPath.formalHouseInspectDetailPage, page: () => SCFormalHouseInspectDetailPage()),
    /*验房单*/
    GetPage(name: SCRouterPath.houseInspectFormPage, page: () => SCHouseInspectFormPage()),
    /*验房-问题*/
    GetPage(name: SCRouterPath.houseInspectProblemPage, page: () => SCHouseInspectProblemPage()),
  ];

  /*根据code使用路由*/
  static var pageCode = {
    /******************** 登录 ********************/
    /// 用户协议和隐私政策
    10000 : SCRouterPath.basePrivacyPath,
    /// 登录
    10001 : SCRouterPath.loginPath,
    /// tab
    10002 : SCRouterPath.tabPath,
    /// webView
    10003 : SCRouterPath.webViewPath,
    /******************** 工作台 ********************/
    /// 工作台
    20000 : SCRouterPath.workBenchPath,
    /// 扫一扫
    20001 : SCRouterPath.scanPath,
    /// 详情
    20002 : SCRouterPath.workBenchDetailPath,
    /******************** 通讯录 ********************/
    /// 通讯录
    30000 : SCRouterPath.addressBookPath,
    /******************** 应用 ********************/
    /// 应用
    40000 : SCRouterPath.applicationPath,
    /******************** 我的 ********************/
    /// 我的
    50000 : SCRouterPath.minePath,
    /// 设置
    50001 : SCRouterPath.settingPath,
  };
}