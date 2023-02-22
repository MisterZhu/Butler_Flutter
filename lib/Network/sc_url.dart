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

  /// 选择搜索仓库类型
  static const String kWareHouseTypeUrl = "/api/config/dictionary/listTree";

  /// 物资列表-分页
  static const String kMaterialListUrl = "/api/warehouse/manage/material/chooseMaterialListByPage";

  /// 物资列表-不分页
  static const String kAllMaterialListUrl = "/api/warehouse/manage/material/chooseMaterialList";

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
  static const String kSubmitFrmLossUrl = "/api/warehouse/app/out/submitWareHouseOut";
}