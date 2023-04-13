import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';

/// 预警中心常用数据处理

class SCWarningCenterUtils{
  /// 处理状态文本颜色
  static Color getStatusColor(int status) {
    if (status == 1) {// 待处理
      return SCColors.color_FF8A00;
    } else if (status == 2) {// 处理中
      return SCColors.color_4285F4;
    } else if (status == 3) {// 已处理
      return SCColors.color_1B1D33;
    } else {
      return SCColors.color_1B1D33;
    }
  }

  /// 预警等级文本颜色
  static Color getLevelTextColor(int level) {
    // 预警等级:1-提醒,2-一般,3-严重,4-非常严重
    if (level == 1) {// 提醒
      return SCColors.color_4285F4;
    } else if (level == 2) {// 一般
      return SCColors.color_4285F4;
    } else if (level == 3) {// 严重
      return SCColors.color_FF4040;
    } else if (level == 4) {// 非常严重
      return SCColors.color_FF4040;
    }else {
      return SCColors.color_FF4040;
    }
  }

  /// 预警等级背景颜色
  static Color getLevelBGColor(int level) {
    // 预警等级:1-提醒,2-一般,3-严重,4-非常严重
    if (level == 1) {// 提醒
      return SCColors.color_EBF2FF;
    } else if (level == 2) {// 一般
      return SCColors.color_EBF2FF;
    } else if (level == 3) {// 严重
      return SCColors.color_FFF1F0;
    } else if (level == 4) {// 非常严重
      return SCColors.color_FFF1F0;
    }else {
      return SCColors.color_FFF1F0;
    }
  }
}