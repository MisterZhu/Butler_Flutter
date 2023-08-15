import 'package:smartcommunity/Constants/sc_default_value.dart';
import 'package:smartcommunity/Constants/sc_enum.dart';

/// 环境配置

class SCConfig {
  /// 环境
  static SCEnvironment env = SCEnvironment.develop;

  /// 生产环境是否支持抓包
  static bool isSupportProxyForProduction = false;

  /// iOS是否支持平方SC字体
  static bool isSupportPFSCForIOS = true;

  static String URL_R = "/api";

  /// base url
  static String get BASE_URL {
    switch (env) {
      case SCEnvironment.develop:
        //return "https://saasdev.wisharetec.com";
        return "https://jmtest.wisharetec.com";
      case SCEnvironment.pretest:
        return "https://saastest.wisharetec.com";
      case SCEnvironment.production:
        return "https://saas.wisharetec.com";
      case SCEnvironment.production_yyc:
        return "https://yayun.wisharetec.com";
      default:
        return "https://saasdev.wisharetec.com";
    }
  }

  /// base h5 url
  static String get BASE_H5_URL {
    switch (env) {
      case SCEnvironment.develop:
        return "https://saasdev.wisharetec.com";
      case SCEnvironment.pretest:
        return "https://saastest.wisharetec.com";
      case SCEnvironment.production:
        return "https://saas.wisharetec.com";
      case SCEnvironment.production_yyc:
        return "https://yayun.wisharetec.com";
      default:
        return "https://saasdev.wisharetec.com";
    }
  }

  /// 图片url
  static String getImageUrl(String url) {
    return BASE_URL + SCDefaultValue.files + url;
  }

  /// 图片url
  static String getImageUrlNonValue(String url) {
    return BASE_URL + url;
  }

  /// h5 url
  static String getH5Url(String url) {
    if (url.contains('http')) {
      return url;
    } else {
      return BASE_H5_URL + url;
    }
  }

  /// 亚运村特有属性，租户id
  static String yycTenantId() {
    if (env == SCEnvironment.production) {
      return '126034790258008';
    } else {
      return '124561229994101';
    }
  }

  /// iOS平方SC配置
  static List<String> getPFSCForIOS() {
    if (isSupportPFSCForIOS) {
      return ["PingFang SC"];
    } else {
      return [];
    }
  }
}
