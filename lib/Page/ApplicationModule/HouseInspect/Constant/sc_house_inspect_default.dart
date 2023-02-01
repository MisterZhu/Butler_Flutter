import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';

/// 入伙验房默认数据

class SCHouseInspectDefault {
  /// 交付状态，1-已交付，2-待交付，3-交付中
  /// 已交付
  static const int deliveryStatusSuccess = 1;

  /// 待交付
  static const int deliveryStatusWait = 2;

  /// 交付中
  static const int deliveryStatusDoing = 3;

  /// 交付状态圆圈颜色
  Color getDeliveryStatusCircleColor(int status) {
    if (status == deliveryStatusSuccess) {
      return SCColors.color_F5F6F8;
    } else if (status == deliveryStatusWait) {
      return SCColors.color_EBF2FF;
    } else if (status == deliveryStatusDoing) {
      return SCColors.color_FFF7D4;
    } else {
      return SCColors.color_F5F6F8;
    }
  }

  /// 交付状态文字颜色
  Color getDeliveryStatusTextColor(int status) {
    if (status == deliveryStatusSuccess) {
      return SCColors.color_5E5F66;
    } else if (status == deliveryStatusWait) {
      return SCColors.color_4285F4;
    } else if (status == deliveryStatusDoing) {
      return SCColors.color_C5910D;
    } else {
      return SCColors.color_5E5F66;
    }
  }
}