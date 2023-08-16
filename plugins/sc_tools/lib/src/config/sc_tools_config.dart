
/// 环境配置

class SCToolsConfig {
  /// iOS是否支持平方SC字体
  static bool isSupportPFSCForIOS = true;

  /// iOS平方SC配置
  static List<String> getPFSCForIOS() {
    if (isSupportPFSCForIOS) {
      return ["PingFang SC"];
    } else {
      return [];
    }
  }

}