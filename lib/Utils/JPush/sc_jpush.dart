import 'package:flutter/services.dart';
import 'package:jpush_flutter/jpush_flutter.dart';

import '../../Constants/sc_default_value.dart';
import '../../Constants/sc_enum.dart';
import '../../Network/sc_config.dart';

/// 极光推送

class SCJPush {
  /// 初始化极光推送
  static initJPush() {
    JPush jPush = JPush();
    jPushEventHandler(jPush);
    setupJPush(jPush);
    clearNotification(jPush);
    clearBadge(jPush);
  }

  /// 设置极光配置
  static setupJPush(JPush jPush) {
    bool production = (SCConfig.env == SCEnvironment.production);

    jPush.setAuth(enable: true);
    jPush.setup(
      appKey: SCDefaultValue.kJPushAppKey,
      channel: SCDefaultValue.kJPushChannel,
      production: production,
      debug: true,
    );
    jPush.applyPushAuthority(const NotificationSettingsIOS(sound: true, alert: true, badge: true));

    // Platform messages may fail, so we use a try/catch PlatformException.
    jPush.getRegistrationID().then((rid) {
      print("flutter get registration id : $rid");
      // setState(() {
      //   debugLable = "flutter getRegistrationID: $rid";
      // });
    });
  }

  /// 接收推送消息
  static jPushEventHandler(JPush jPush) {
    try {
      jPush.addEventHandler(
          onReceiveNotification: (Map<String, dynamic> message) async {
            print("flutter onReceiveNotification: $message");
            // setState(() {
            //   debugLable = "flutter onReceiveNotification: $message";
            // });
          }, onOpenNotification: (Map<String, dynamic> message) async {
        print("flutter onOpenNotification: $message");
        // setState(() {
        //   debugLable = "flutter onOpenNotification: $message";
        // });
      }, onReceiveMessage: (Map<String, dynamic> message) async {
        print("flutter onReceiveMessage: $message");
        // setState(() {
        //   debugLable = "flutter onReceiveMessage: $message";
        // });
      }, onReceiveNotificationAuthorization:
          (Map<String, dynamic> message) async {
        print("flutter onReceiveNotificationAuthorization: $message");
        // setState(() {
        //   debugLable = "flutter onReceiveNotificationAuthorization: $message";
        // });
      },onNotifyMessageUnShow:
          (Map<String, dynamic> message) async {
        print("flutter onNotifyMessageUnShow: $message");
        // setState(() {
        //   debugLable = "flutter onNotifyMessageUnShow: $message";
        // });
      });
    } on PlatformException {
      // platformVersion = 'Failed to get platform version.';
    }
  }

  /// 绑定别名
  static bindAlias(String alias) {
    JPush jPush = JPush();
    jPush.setAlias(alias);
  }

  /// 删除别名
  static Future<Map<dynamic, dynamic>> deleteAlias() {
    JPush jPush = JPush();
    return jPush.deleteAlias();
  }

  /// 清除通知
  static clearNotification(JPush jPush) {
    jPush.clearAllNotifications();
  }

  /// 清空Badge
  static clearBadge(JPush jPush) {
    jPush.setBadge(0);
  }

  /// 获取RegistrationID
  static Future<String> getRegistrationID() async{
    JPush jPush = JPush();
    return jPush.getRegistrationID();
  }
}