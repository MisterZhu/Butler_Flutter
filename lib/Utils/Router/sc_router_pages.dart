import 'package:get/get.dart';
import 'package:smartcommunity/Page/AddressBook/Home/Page/sc_addressbook_page.dart';
import 'package:smartcommunity/Page/Application/Home/Page/sc_application_page.dart';
import 'package:smartcommunity/Page/ApplicationModule/HouseInspect/Page/sc_house_inspect_signature_page.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/Page/sc_material_entry_detail_page.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialOutbound/Page/sc_add_outbound_page.dart';
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
import '../../Page/ApplicationModule/HouseInspect/Page/sc_enter_house_inspect_page.dart';
import '../../Page/ApplicationModule/HouseInspect/Page/sc_formal_house_inspect_detail_page.dart';
import '../../Page/ApplicationModule/HouseInspect/Page/sc_formal_house_inspect_page.dart';
import '../../Page/ApplicationModule/HouseInspect/Page/sc_house_inspect_form_page.dart';
import '../../Page/ApplicationModule/HouseInspect/Page/sc_house_inspect_problem_page.dart';
import '../../Page/ApplicationModule/HouseInspect/Page/sc_house_inspect_select_page.dart';
import '../../Page/ApplicationModule/HouseInspect/Page/sc_to_be_upload_page.dart';
import '../../Page/ApplicationModule/MaterialEntry/Page/sc_add_material_page.dart';
import '../../Page/ApplicationModule/MaterialEntry/Page/sc_add_entry_page.dart';
import '../../Page/ApplicationModule/MaterialEntry/Page/sc_entry_search_page.dart';
import '../../Page/ApplicationModule/MaterialEntry/Page/sc_material_entry_page.dart';
import '../../Page/ApplicationModule/MaterialEntry/Page/sc_material_search_page.dart';
import '../../Page/ApplicationModule/MaterialFrmLoss/Page/sc_add_frmLoss_page.dart';
import '../../Page/ApplicationModule/MaterialFrmLoss/Page/sc_material_frmLoss_detail_page.dart';
import '../../Page/ApplicationModule/MaterialFrmLoss/Page/sc_material_frmLoss_page.dart';
import '../../Page/ApplicationModule/MaterialOutbound/Page/sc_material_outbound_detail_page.dart';
import '../../Page/ApplicationModule/MaterialOutbound/Page/sc_material_outbound_page.dart';
import '../../Page/ApplicationModule/MaterialOutbound/Page/sc_select_receiver_page.dart';
import '../../Page/ApplicationModule/MaterialTransfer/Page/sc_add_transfer_page.dart';
import '../../Page/ApplicationModule/MaterialTransfer/Page/sc_material_transfer_detail_page.dart';
import '../../Page/ApplicationModule/MaterialTransfer/Page/sc_material_transfer_page.dart';
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
    /*入伙验房-选择房号*/
    GetPage(name: SCRouterPath.houseInspectSelectPath, page: () => SCHouseInspectSelectPage()),
    /*入伙验房*/
    GetPage(name: SCRouterPath.enterHouseInspectPage, page: () => SCEnterHouseInspectPage()),
    /*正式验房*/
    GetPage(name: SCRouterPath.formalHouseInspectPage, page: () => SCFormalHouseInspectPage()),
    /*正式验房-详情*/
    GetPage(name: SCRouterPath.formalHouseInspectDetailPage, page: () => SCFormalHouseInspectDetailPage()),
    /*验房单*/
    GetPage(name: SCRouterPath.houseInspectFormPage, page: () => SCHouseInspectFormPage()),
    /*验房-问题*/
    GetPage(name: SCRouterPath.houseInspectProblemPage, page: () => SCHouseInspectProblemPage()),
    /*待上传事项*/
    GetPage(name: SCRouterPath.toBeUploadPage, page: () => SCToBeUploadPage()),
    /*签名*/
    GetPage(name: SCRouterPath.signaturePage, page: () => SCHouseInspectSignaturePage()),
    /*物资入库*/
    GetPage(name: SCRouterPath.materialEntryPage, page: () => SCMaterialEntryPage()),
    /*新增入库*/
    GetPage(name: SCRouterPath.addEntryPage, page: () => SCAddEntryPage()),
    /*入库详情*/
    GetPage(name: SCRouterPath.entryDetailPage, page: () => SCMaterialEntryDetailPage()),
    /*添加物资*/
    GetPage(name: SCRouterPath.addMaterialPage, page: () => SCAddMaterialPage()),
    /*搜索物资*/
    GetPage(name: SCRouterPath.materialSearchPage, page: () => SCMaterialSearchPage()),
    /*新增出库*/
    GetPage(name: SCRouterPath.addOutboundPage, page: () => SCAddOutboundPage()),
    /*选择领用人*/
    GetPage(name: SCRouterPath.selectReceiverPage, page: () => SCSelectReceiverPage()),
    /*物资出库*/
    GetPage(name: SCRouterPath.materialOutboundPage, page: () => SCMaterialOutboundPage()),
    /*出库详情*/
    GetPage(name: SCRouterPath.outboundDetailPage, page: () => SCMaterialOutboundDetailPage()),
    /*搜索出入库*/
    GetPage(name: SCRouterPath.entrySearchPage, page: () => SCEntrySearchPage()),
    /*新增报损*/
    GetPage(name: SCRouterPath.addFrmLossPage, page: () => SCAddFrmLossPage()),
    /*物资报损*/
    GetPage(name: SCRouterPath.materialFrmLossPage, page: () => SCMaterialFrmLossPage()),
    /*报损详情*/
    GetPage(name: SCRouterPath.frmLossDetailPage, page: () => SCMaterialFrmLossDetailPage()),
    /*新增调拨*/
    GetPage(name: SCRouterPath.addTransferPage, page: () => SCAddTransferPage()),
    /*物资调拨*/
    GetPage(name: SCRouterPath.materialTransferPage, page: () => SCMaterialTransferPage()),
    /*调拨详情*/
    GetPage(name: SCRouterPath.transferDetailPage, page: () => SCMaterialTransferDetailPage()),
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