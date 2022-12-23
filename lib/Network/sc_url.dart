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

  /************************* 工单 *************************/

  /// 工单数量url
  static const String kWorkOrderNumberUrl = '/api/workorder/task/query/routine/count';

  /// 工单列表url
  static const String kWorkOrderListUrl = '/api/workorder/task/query/page';

  /// 获取管理空间树
  static const String kSpaceTreeUrl = '/api/space/space/manageTree';

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
}