/// 路由-path

class SCRouterPath {
  /// 根目录默认登录页面
  static String root = "/lib/Page/Login/Home/Page/sc_login_page";

  /***************************** 登录 ******************************/
  /// 登录
  static String loginPath = "/lib/Page/Login/Home/Page/sc_login_page";
  /// 用户协议和隐私政策弹窗
  static String basePrivacyPath = "/lib/Page/Login/Privacy/sc_privacy_page";
  //static String basePrivacyPath = "/lib/Page/Login/Privacy/Page/sc_privacy_alert_new_page";

  /// tabPage
  static String tabPath = "/lib/Page/Tab/Page/sc_tab_page";
  /// flutter-webView
  static String webViewPath = "/lib/Page/WebView/Page/sc_webview_page";
  /// native-webView
  static String nativeWebViewPath = "/lib/Page/WebView/Page/sc_native_webview_age";

  /***************************** 工作台 ******************************/
  /// 工作台
  static String workBenchPath = "/lib/Page/WorkBench/Home/Page/sc_workbench_page";
  /// 扫一扫
  static String scanPath = "/lib/Page/Home/Home/Page/sc_scan_page";

  static String scanPathMeterReading = "/lib/Page/Home/Home/Page/sc_scan_page_read";

  /// 详情
  static String workBenchDetailPath = "/lib/Page/WorkBench/Home/Page/sc_workbench_detail_page";

  /// 搜索
  static String workBenchSearchPage = "/lib/Page/WorkBench/Home/Page/sc_workbench_search_page";
  /// 编辑工作台
  static String workBenchEditPage = "/lib/Page/WorkBench/Home/Page/sc_workbench_edit_page";


  /***************************** 通讯录 ******************************/
  /// 通讯录
  static String addressBookPath = "/lib/Page/AddressBook/Home/Page/sc_addressbook_page";

  /***************************** 应用 ******************************/
  /// 全部应用
  static String applicationPath = "/lib/Page/Application/Home/Page/sc_application_page";

  /***************************** 我的 ******************************/
  /// 我的
  static String minePath = "/lib/Page/Mine/Home/Page/sc_mine_page";
  /// 设置
  static String settingPath = "/lib/Page/Mine/Home/Page/sc_setting_page";
  /// 切换身份
  static String switchIdentityPath = "/lib/Page/Mine/Home/Page/sc_switch_identity_page";
  /// 个人资料
  static String personalInfoPath = "/lib/Page/Mine/Home/Page/sc_personal_info_page";
  /// 抓包设置
  static String proxyPage = "/lib/Page/Mine/Home/Page/sc_proxy_page";

  /*************************** 入伙验房 ******************************/

  /// 选择房号
  static String houseInspectSelectPath = "/lib/Page/ApplicationModule/Page/sc_house_inspect_select_page";

  /// 入伙验房
  static String enterHouseInspectPage = "/lib/Page/HouseInspect/Page/sc_enter_house_inspect_page";

  /// 正式验房
  static String formalHouseInspectPage = "/lib/Page/HouseInspect/Page/sc_formal_house_inspect_page";

  /// 正式验房-详情
  static String formalHouseInspectDetailPage = "/lib/Page/HouseInspect/Page/sc_formal_house_inspect_detail_page";

  /// 验房单
  static String houseInspectFormPage = "/lib/Page/HouseInspect/Page/sc_house_inspect_form_page";

  /// 问题
  static String houseInspectProblemPage = "/lib/Page/HouseInspect/Page/sc_house_inspect_problem_page";

  /// 待上传事项
  static String toBeUploadPage = "/lib/Page/HouseInspect/Page/sc_to_be_upload_page";

  /// 签名
  static String signaturePage = "/lib/Page/HouseInspect/Page/sc_house_inspect_signature_page";

  /*************************** 物资入库 ******************************/

  /// 物资入库
  static String materialEntryPage = "/lib/Page/MaterialEntry/Page/sc_material_entry_page";

  /// 新增入库
  static String addEntryPage = "/lib/Page/MaterialEntry/Page/sc_add_entry_page";

  /// 入库详情
  static String entryDetailPage = "/lib/Page/MaterialEntry/Page/sc_material_entry_detail_page";

  /// 添加物资
  static String addMaterialPage = "/lib/Page/materialEntry/Page/sc_add_material_page";

  /// 搜索物资
  static String materialSearchPage = "/lib/Page/materialEntry/Page/sc_material_search_page";

  /// 出入库搜索
  static String entrySearchPage = "/lib/Page/materialEntry/Page/sc_entry_search_page";

  /// 采购需求单搜索
  static String purchaseSearchPage = "/lib/Page/materialEntry/Page/sc_purchase_search_page";

  /// 采购单选择物资
  static String purchaseSelectMaterialPage = "/lib/Page/materialEntry/Page/sc_purchase_selectmaterial_page";

  /*************************** 物资出库 ******************************/

  /// 物资出库
  static String materialOutboundPage = "/lib/Page/MaterialOutbound/Page/sc_material_outbound_page";

  /// 新增出库
  static String addOutboundPage = "/lib/Page/MaterialOutbound/Page/sc_add_outbound_page";

  /// 选择领用人
  static String selectReceiverPage = "/lib/Page/MaterialOutbound/Page/sc_select_receiver_page";

  /// 出库详情
  static String outboundDetailPage = "/lib/Page/MaterialOutbound/Page/sc_material_outbound_detail_page";

  /*************************** 物资报损 ******************************/

  /// 物资报损
  static String materialFrmLossPage = "/lib/Page/MaterialFrmLoss/Page/sc_material_frmLoss_page";

  /// 新增报损
  static String addFrmLossPage = "/lib/Page/MaterialFrmLoss/Page/sc_add_frmLoss_page";

  /// 报损详情
  static String frmLossDetailPage = "/lib/Page/MaterialFrmLoss/Page/sc_material_frmLoss_detail_page";

  /*************************** 物资调拨 ******************************/

  /// 物资调拨
  static String materialTransferPage = "/lib/Page/MaterialTransfer/Page/sc_material_transfer_page";

  /// 新增调拨
  static String addTransferPage = "/lib/Page/MaterialTransfer/Page/sc_add_transfer_page";

  /// 调拨详情
  static String transferDetailPage = "/lib/Page/MaterialTransfer/Page/sc_material_transfer_detail_page";

  /*************************** 盘点任务 ******************************/

  /// 盘点任务
  static String materialCheckPage = "/lib/Page/MaterialCheck/Page/sc_material_check_page";

  /// 新增任务
  static String addCheckPage = "/lib/Page/MaterialCheck/Page/sc_add_check_page";

  /// 盘点详情
  static String checkDetailPage = "/lib/Page/MaterialCheck/Page/sc_material_check_detail_page";

  /// 选择分类
  static String checkSelectCategoryPage = "/lib/Page/MaterialCheck/Page/sc_material_check_category_page";

  /// 盘点-物资详情
  static String checkMaterialDetailPage = "/lib/Page/MaterialCheck/Page/sc_check_material_detail_page";


  /*************************** 领料物资出入任务 ******************************/

  /// 领料出入库
  static String materialRequisitionPage = "/lib/Page/MaterialCheck/Page/sc_material_requisition_page";

  /// *************************** 固定资产报损 ******************************/

  /// 固定资产报损
  static String propertyFrmLossPage = "/lib/Page/PropertyFrmLoss/Page/sc_property_frmLoss_page";

  /// 新增固定资产报损
  static String addPropertyFrmLossPage = "/lib/Page/PropertyFrmLoss/Page/sc_add_property_frmLoss_page";

  /// 固定资产报损详情
  static String propertyFrmLossDetailPage = "/lib/Page/PropertyFrmLoss/Page/sc_property_frmLoss_detail_page";

 /*************************** 物资调拨 ******************************/


  /*************************** 资产 ******************************/

  /*************************** 固定资产盘点 ******************************/
  /// 固定资产盘点
  static String fixedCheckPage = "/lib/Page/PropertyFrmLoss/Page/sc_fixedcheck_page";

  /// 新增固定资产盘点任务
  static String addFixedCheckPage = "/lib/Page/PropertyFrmLoss/Page/sc_add_fixedcheck_page";

  /// 固定资产盘点-物资详情
  static String fixedCheckMaterialDetailPage = "/lib/Page/PropertyFrmLoss/Page/sc_fixedcheck_material_detail_page";

  /*************************** 消息 ******************************/

  /// 消息
  static String messagePage = "/lib/Page/Message/Page/sc_message_page";

  /*************************** 在线监控 ******************************/

  /// 在线监控
  static String onlineMonitorPage = "/lib/Page/OnlineMonitor/Page/sc_online_monitor_page";
  /// 监控搜索
  static String monitorSearchPage = "/lib/Page/OnlineMonitor/Page/sc_monitor_search_page";

  /*************************** 任务 ******************************/

  /// 任务
  static String taskPage = "/lib/Page/Message/Page/sc_task_page";

  /*************************** 资产维保 ******************************/

  /// 资产维保记录
  static String propertyRecordPage = "/lib/Page/PropertyMaintenance/Page/sc_peroperty_record_page";
  /// 资产维保登记
  static String addPropertyRecordPage = "/lib/Page/PropertyMaintenance/Page/sc_add_propertymaintenance_page";
  /// 资产维保详情
  static String propertyMaintenanceDetailPage = "/lib/Page/PropertyMaintenance/Page/sc_propertymaintenance_detail_page";

  /*************************** 预警中心 ******************************/

  /// 预警中心
  static String warningCenterPage = "/lib/Page/WarningCenter/Page/sc_warningcenter_page";
  /// 预警中心-搜索
  static String searchWarningPage = "/lib/Page/WarningCenter/Page/sc_warning_search_page";
  /// 预警详情
  static String warningDetailPage = "/lib/Page/WarningCenter/Page/sc_warning_detail_page";

  /*************************** 巡查 ******************************/

  /// 巡查列表
  static String patrolPage = "/lib/Page/Patrol/Page/sc_patrol_page";

  /// 任务日志
  static String taskLogPage = "/lib/Page/Patrol/Page/sc_task_log_page";

  /// 巡查详情
  static String patrolDetailPage = "/lib/Page/Patrol/Page/sc_patrol_detail_page";

  /// 搜索巡查
  static String searchPatrolPage = "/lib/Page/Patrol/Page/sc_patrol_search_page";

  /// 巡查转派
  static String patrolTransferPage = "/lib/Page/Patrol/Page/sc_patrol_transfer_page";

  /// 处理人搜索
  static String operatorSearchPage = "/lib/Page/Patrol/Page/sc_operator_search_page";

  ///巡查路线
  static String patrolRoutePage = "/lib/Page/Patrol/Page/sc_patrol_route_page";

  /// 检查项编辑页面
  static String patrolCheckCellEditPage = "/lib/Page/Patrol/Page/sc_check_cell_page";

  ///检查项详情
  static String patrolCheckCellDetailPage = "/lib/Page/Patrol/Page/sc_check_cell_detail_page";

  /*************************** 电子巡更 ******************************/

  /// 巡更列表
  static String electronicPatrolPage = "/lib/Page/ElectronicPatrol/Page/sc_electronic_patrol_page";


  /// 待办通知
  static String messageNeedHandlePage = "/lib/Page/Message/Page/sc_handle_message_page";


}