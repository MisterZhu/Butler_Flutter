/// API

class SCUrl {
  /// 高德逆地理编码url
  static const String kReGeoCodeUrl = 'https://restapi.amap.com/v3/geocode/regeo';


  /************************* 登录 *************************/

  /// 发送验证码url
  static const String kSendCodeUrl = '/api/user/sms';

  /// 验证码登录url
  static const String kPhoneCodeLoginUrl = '/api/user/loginByCode';

  /// 退出登录url
  static const String kLogoutUrl = '/api/user/loginOut';

  /// 绑定极光RegistrationId
  static const String kBindJPushRegistrationIdUrl = '/api/user/bindRegistrationId';

  /************************* 工作台 *************************/

  /// 用户信息url
  static const String kUserInfoUrl = '/api/user/info';

  /// 用户默认配置url
  static const String kUserDefaultConfigUrl = '/api/user/defaultConfig';

  /// 实地核验工单点击url
  static const String kDealActualVerifyUrl = '/api/stylestay/house/actualVerify/dealActualVerify';

  /************************* 工单 *************************/

  /// 工单数量url
  static const String kWorkOrderNumberUrl = '/api/workorder/task/query/routine/count';

  /// 工单处理工单url
  static const String kWorkOrderListUrl = '/api/workorder/task/query/page';

  /// 获取管理空间树
  static const String kSpaceTreeUrl = '/api/space/space/manageTree';

  /// 实地核验工单url
  static const String kActualVerifyUrl = '/api/stylestay/house/actualVerify/getActualVerifyList';

  /// 订单处理工单url
  static const String kOrderFormUrl = '/api//stylestay/microapp/hotel/pageOrderList';

  /************************* 服务 *************************/

  /// 应用列表url
  static const String kApplicationListUrl = '/api/auth/menuServer/menuServerTree';

  /************************* 我的 *************************/

  /// 租户列表url
  static const String kSwitchTenantUrl = '/api/user/switchTenant';

  /// 项目列表
  static const String kCommunityListUrl = '/api/space/community/list/per';

  /// 我的房号列表url
  static const String kMyHouseUrl = '/api/space/resident/user/housing/list';

  /// 新增房号接口
  static const String kAddHouseUrl = '/api/space/resident/user/bind';

  /// 当前房屋详情接口
  static const String kCurrentHouseInfoUrl = '/api/space/resident/user/housing/info';

  /// 解除绑定房号接口url
  static const String kUnbindHouseUrl = '/api/space/resident/user/unbind';

  /// 通过项目Id获取房号数据url
  static const String kGetSpaceNodesUrl = '/api/space/space/getSpaceNodes';

  /// 获取用户身份
  static const String kResidentUserIdentity = '/api/space/resident/user/community/identity';

  /// 绑定房产
  static const String kBindAsset = '/api/space/resident/user/bind';

  /// 居民档案审核通过
  static const String kExaminePass = '/api/space/archive/examine/pass';

  /// 居民档案审核拒绝
  static const String kExamineReject = '/api/space/archive/examine/refuse';

  /// 上传头像url
  static const String kUploadHeadPicUrl = "/api/user/upload/headPic";

  /// 修改用户信息
  static const String kModifyUserInfoUrl = "/api/user/info/modifyAccount";

  /// 注销
  static const String kLogOffUrl = "/api/user/info/stateBatch";


  /************************* 物资入库 *************************/
  /// 入库列表
  static const String kMaterialEntryListUrl = "/api/warehouse/app/in/selectWareHouseInList";

  /// 选择搜索仓库列表
  static const String kWareHouseListUrl = "/api/warehouse/manage/warehouse/chooseWareHouseList";

  /// 选择类型
  static const String kWareHouseTypeUrl = "/api/config/dictionary/listTree";

  /// 物资列表-分页
  static const String kMaterialListUrl = "/api/warehouse/manage/material/chooseMaterialListByPage";

  /// 物资列表-不分页
  static const String kAllMaterialListUrl = "/api/warehouse/manage/material/chooseMaterialList";

  /// 新增入库-资产列表
  static const String kAddEntryPropertyListUrl = "/api/warehouse/fixedMaterialAccount/page";

  /// 编辑的物资列表
  static const String kMaterialEditListUrl = "/api/warehouse/manage/materialInRelation/selectMaterialInRelationListByPage";

  /// 新增入库
  static const String kAddEntryUrl = "/api/warehouse/app/in/addWareHouseIn";

  /// 编辑入库基础信息
  static const String kEditAddEntryBaseInfoUrl = "/api/warehouse/app/in/editWareHouseIn";

  /// 物资入库-编辑-新增物资
  static const String kEditAddEntryMaterialUrl = "/api/warehouse/manage/materialInRelation/addMaterialInRelationList";

  /// 物资入库-编辑-删除物资
  static const String kEditDeleteEntryMaterialUrl = "/api/warehouse/manage/materialInRelation/deleteMaterialInRelation";

  /// 物资入库-编辑-编辑物资
  static const String kEditEntryMaterialUrl = "/api/warehouse/manage/materialInRelation/editMaterialInRelation";

  /// 入库详情
  static const String kMaterialEntryDetailUrl = "/api/warehouse/app/in/detailWareHouseIn";

  /// 提交入库
  static const String kSubmitMaterialUrl = "/api/warehouse/app/in/submitWareHouseIn";

  /// 物资分类
  static const String kMaterialSortUrl = "/api/warehouse/manage/materialClass/tree";

  /// 物资分类-需要带仓库ID
  static const String kMaterialSortWithWareHouseUrl = "/api/warehouse/manage/materialClass/treeByWareHouseId";

  /// 搜索采购需求单
  static const String kPurchaseSearchUrl = "/api/warehouse/mange/wareHousePurchase/getAllPurchaseIdSearch";

  /// 物资采购关联详情(不分页)
  static const String kPurchaseDetailUrl = "/api/warehouse/manger/materialPurchaseRelation/detailApp";

  /// 不分页查询物资出库列表
  static const String kMaterialOutListUrl = "/api/warehouse/manage/materialOutRelation/selectMaterialOutRelationList";

  /************************* 物资出库 *************************/

  /// 出库列表
  static const String kMaterialOutboundListUrl = "/api/warehouse/app/out/selectWareHouseOutList";

  /// 新增出库
  static const String kAddOutboundUrl = "/api/warehouse/app/out/addWareHouseOut";

  /// 编辑出库基础信息
  static const String kEditOutboundBaseInfoUrl = "/api/warehouse/app/out/editWareHouseOut";

  /// 物资出库-编辑-新增物资
  static const String kEditOutMaterialUrl = "/api/warehouse/manage/materialOutRelation/addMaterialOutRelationList";

  /// 物资出库-编辑-删除物资
  static const String kEditDeleteOutEntryUrl = "/api/warehouse/manage/materialOutRelation/deleteMaterialOutRelation";

  /// 物资出库-编辑-编辑物资
  static const String kEditOutEntryUrl = "/api/warehouse/manage/materialOutRelation/editMaterialOutRelation";

  /// 出库详情
  static const String kMaterialOutboundDetailUrl = "/api/warehouse/app/out/detailWareHouseOut";

  /// 提交出库
  static const String kSubmitOutboundUrl = "/api/warehouse/app/out/submitWareHouseOut";

  /// 领用人
  static const String kReceiverListUrl = "/api/workorder/common/query/org/persons";

  /// 领用部门
  static const String kDepartmentListUrl = "/api/org/orgInfo/listTree";

  /// 出库确认
  static const String kOutboundConfirmUrl = "/api/warehouse/manage/materialOutRelation/outCheck";

  /************************* 物资报损 *************************/

  /// 报损列表
  static const String kMaterialFrmLossListUrl = "/api/warehouse/app/warehouse/report/pageFront";

  /// 新增报损
  static const String kAddFrmLossUrl = "/api/warehouse/app/warehouse/report/save";

  /// 报损详情
  static const String kMaterialFrmLossDetailUrl = "/api/warehouse/app/warehouse/report/detail";

  /// 上传图片url
  static const String kMaterialUploadPicUrl = "/api/warehouse/file/upload";

  /// 编辑物资报损基础信息
  static const String kEditAddFrmLossBaseInfoUrl = "/api/warehouse/app/warehouse/report/edit";

  /// 物资报损-编辑-删除物资
  static const String kEditDeleteFrmLossMaterialUrl = "/api/warehouse/manage/materialReportRelation/deleteMaterialReportRelation";

  /// 物资报损-编辑-新增物资
  static const String kEditAddFrmLossMaterialUrl = "/api/warehouse/manage/materialReportRelation/addMaterialReportRelationList";

  /// 物资报损-编辑-编辑物资
  static const String kEditFrmLossMaterialUrl = "/api/warehouse/manage/materialReportRelation/editMaterialReportRelation";

  /// 物资报损物资列表-分页
  static const String kFrmLossMaterialListUrl = "/api/warehouse/manage/materialReportRelation/selectMaterialReportRelationListByPage";

  /// 提交报损
  static const String kSubmitFrmLossUrl = "/api/warehouse/app/warehouse/report/submitWareHouseReport";

  /************************* 物资调拨 *************************/

  /// 调出仓库列表
  static const String kAllWareHouseListUrl = "/api/warehouse/manage/warehouse/chooseAllWareHouseList";

  /// 调拨列表
  static const String kMaterialTransferListUrl = "/api/warehouse/app/warehouse/change/pageFront";

  /// 新增调拨
  static const String kAddTransferUrl = "/api/warehouse/app/warehouse/change/save";

  /// 调拨详情
  static const String kMaterialTransferDetailUrl = "/api/warehouse/app/warehouse/change/detail";

  /// 出库、报损、调拨、盘点物资列表
  static const String kOtherMaterialListUrl = "/api/warehouse/manage/warehouseAccount/chooseWareHouseAccountList";

  /// 物资调拨编辑-新增物资
  static const String kEditAddTransferMaterialUrl = "/api/warehouse/manage/materialChangeRelation/addMaterialChangeRelationList";

  /// 物资调拨-编辑-删除物资
  static const String kEditDeleteTransferMaterialUrl = "/api/warehouse/manage/materialChangeRelation/deleteMaterialChangeRelation";

  /// 物资调拨-编辑-编辑物资
  static const String kEditTransferMaterialUrl = "/api/warehouse/manage/materialChangeRelation/editMaterialChangeRelation";

  /// 编辑物资调拨基础信息
  static const String kEditTransferBaseInfoUrl = "/api/warehouse/app/warehouse/change/edit";

  /// 提交调拨
  static const String kSubmitTransferUrl = "/api/warehouse/app/warehouse/change/submitWareHouseChange";

  /************************* 盘点任务 *************************/
  /// 盘点列表
  static const String kMaterialCheckListUrl = "/api/warehouse/app/warehouse/check/pageFront";

  /// 新增盘点
  static const String kAddMaterialCheckUrl = "/api/warehouse/app/warehouse/check/save";

  /// 盘点详情
  static const String kMaterialCheckDetailUrl = "/api/warehouse/app/warehouse/check/detail/";

  /// 查询物资分类树
  static const String kMaterialClassTreeUrl = "/api/warehouse/manage/materialClass/tree";

  /// 开始盘点任务
  static const String kStartCheckTaskUrl = "/api/warehouse/app/warehouse/check/start/";

  /// 暂存或提交盘点任务
  static const String kCheckSubmitUrl = "/api/warehouse/app/warehouse/check/saveOrSubmit";

  /// 作废盘点任务
  static const String kCancelCheckTaskUrl = "/api/warehouse/app/warehouse/check/cancel";

  /// 删除盘点任务
  static const String kDeleteCheckTaskUrl = "/api/warehouse/app/warehouse/check/delete";

  /// 编辑盘点基础信息
  static const String kEditCheckBaseInfoUrl = "/api/warehouse/app/warehouse/check/update";

  /************************* 固定资产报损 *************************/

  /// 报损列表
  static const String kPropertyFrmLossListUrl = "/api/warehouse/app/asset/report/pageFront";

  /// 新增报损
  static const String kAddPropertyFrmLossUrl = "/api/warehouse/app/asset/report/save";

  /// 报损详情
  static const String kPropertyFrmLossDetailUrl = "/api/warehouse/app/asset/report/detail";

  /// 提交报损
  static const String kSubmitPropertyFrmLossUrl = "/api/warehouse/app/asset/report/submitWareHouseReport";

  /// 编辑物资报损基础信息
  static const String kEditAddPropertyFrmLossBaseInfoUrl = "/api/warehouse/app/asset/report/edit";

  /// 资产列表
  static const String kAddFrmLossPropertyListUrl = "/api/warehouse/fixedMaterialAccount/listAssets";

  /// 资产报损-编辑-删除资产
  static const String kEditDeleteFrmLossPropertyUrl = "/api/warehouse/assetReportRelation/remove";

  /// 资产报损-编辑-新增资产
  static const String kEditAddFrmLossPropertyUrl = "/api/warehouse/assetReportRelation/addAssetReportList";

  /************************* 固定资产盘点 *************************/
  /// 新增盘点
  static const String kAddFixedCheckUrl = "/api/warehouse/app/assetsCheck/save";

  /// 固定资产盘点列表
  static const String kFixedCheckListUrl = "/api/warehouse/app/assetsCheck/pageFront";

  /// 固定盘点详情
  static const String kFixedCheckDetailUrl = "/api/warehouse/app/assetsCheck/detail";

  /// 作废盘点任务
  static const String kCancelFixedCheckTaskUrl = "/api/warehouse/manage/assetsCheck/cancel";

  /// 删除盘点任务
  static const String kDeleteFixedCheckTaskUrl = "/api/warehouse/app/assetsCheck/delete";

  /// 编辑盘点基础信息
  static const String kEditFixedCheckBaseInfoUrl = "/api/warehouse/app/assetsCheck/update";

  /// 开始固定资产盘点盘点任务
  static const String kStartFixedCheckTaskUrl = "/api/warehouse/app/assetsCheck/start";

  /// 暂存或提交固定资产盘点任务
  static const String kFixedCheckSubmitUrl = "/api/warehouse/app/assetsCheck/submit";

  /************************* 消息 *************************/
  /// 消息列表
  static const String kMessageListUrl = "/api/msg/noticeBusiness/list";

  /// 获取详情并更新为已读
  static const String kMessageDetailUrl = "/api/msg/noticeBusiness";


  /************************* 在线监控 *************************/

  /// 监控视频详情
  static const String kMonitorDetailUrl = "/api/device-chentian/camera/detail/";

  /// 根据视频监控设备ID获取视频监控播放地址
  static const String kMonitorPlayUrl = "/api/device-chentian/camera/hls/";

  /// 查询视频监控设备列表
  static const String kMonitorListUrl = "/api/device-chentian/camera/search";

/// 分页查询视频设备
//static const String kMonitorListUrl = "/api/device-chentian/camera/searchCamera";

  /// 查询空间列表
  static const String kSpaceListUrl = "/api/space/component/space/select";

  /************************* 预警中心 *************************/
  /// 预警列表
  static const String kWarningCenterListUrl = "/api/alert/alert/getAlertsPage";

  /// 数据字典
  static const String kConfigDictionaryPidCodeUrl = "/api/config/dictionary/pidCode";

  /// 处理
  static const String kAlertDealUrl = "/api/alert/alert/alertDeal";

  /// 预警详情
  static const String kWarningDetailUrl = "/api/alert/alert/alertDetails/";

  /// 预警详情-空间信息
  static const String kWarningSpaceInfoUrl = "/api/space/community/getDetail";

  /// 预警-紧急联系人
  static const String kWarningEmergencyUrl = "/api/space/worker/0101/";

  /// 预警-通过id获取空间类型
  static const String kWarningSpaceTypeUrl = "/api/space/space/type/getDetail";


  /************************* 巡查 *************************/
  /// 巡查任务列表
  static const String kPatrolListUrl = "/api/quality/safetyProduction/task/frontPage";
  /// 巡查分类
  static const String kPatrolTypeUrl = "/api/quality/safetyProduction/task/fullTree";
  /// 巡查详情
  static const String kPatrolDetailUrl = "/api/quality/safetyProduction/task/getById";

}