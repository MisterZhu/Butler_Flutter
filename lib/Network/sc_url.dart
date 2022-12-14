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

  /************************* 登录 *************************/

  /// 用户信息url
  static const String kUserInfoUrl = '/api/user/info';

  /// 用户默认配置url
  static const String kUserDefaultConfigUrl = '/api/user/defaultConfig';

 /************************* 服务 *************************/

  /// 应用列表url
  static const String kServiceAppListUrl = '/api/applet/user/list';

  /// 上传头像url
  static const String kUploadHeadPicUrl = "/api/user/upload/headPic";
}