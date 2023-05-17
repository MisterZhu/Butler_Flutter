import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_flutter_key.dart';
import 'package:smartcommunity/Utils/sc_utils.dart';

import '../../Constants/sc_default_value.dart';
import '../../Constants/sc_enum.dart';
import '../../Network/sc_config.dart';
import '../../Skin/Tools/sc_scaffold_manager.dart';
import '../Router/sc_router_helper.dart';
import '../Router/sc_router_path.dart';

/// 极光推送

class SCJPush {
  /// 初始化极光推送
  static initJPush() {
    JPush jPush = JPush();
    SCScaffoldManager.instance.jPush = jPush;
    jPushEventHandler(jPush);
    setupJPush(jPush);
    clearNotification(jPush);
    clearBadge();
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
    jPush.applyPushAuthority(
        const NotificationSettingsIOS(sound: true, alert: true, badge: true));

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
        dealJPush(message);
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
      }, onNotifyMessageUnShow: (Map<String, dynamic> message) async {
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
    SCScaffoldManager.instance.jPush.setAlias(alias);
  }

  /// 删除别名
  static Future<Map<dynamic, dynamic>> deleteAlias() {
    return SCScaffoldManager.instance.jPush.deleteAlias();
  }

  /// 清除通知
  static clearNotification(JPush jPush) {
    jPush.clearAllNotifications();
  }

  /// 清空Badge
  static clearBadge() {
    SCScaffoldManager.instance.jPush.setBadge(0);
  }

  /// 获取RegistrationID
  static Future<String> getRegistrationID() async {
    return SCScaffoldManager.instance.jPush.getRegistrationID();
  }

  /// APP活跃在前台时是否展示通知
  static setUnShowAtTheForeground(JPush jPush) {
    jPush.setUnShowAtTheForeground(unShow: true);
  }

  /// 处理推送
  static dealJPush(var message) {
    clearBadge();
    if (message.containsKey('extras')) {
      var extras;
      var alert;
      // int type = -1;
      String url = '';
      String title = '';
      if (Platform.isIOS) {
        extras = message['extras'];
      } else {
        extras = jsonDecode(message['extras']['cn.jpush.android.EXTRA']);
      }
      if (message.containsKey('title')) {
        title = message['title'];
      }
      if (extras.containsKey('url')) {
        url = extras['url'];
      }
      if (url.isNotEmpty) {
        detailAction(title, url);
      }
    }
  }

  /// 详情
  static detailAction(String title, String url) async {
    if (Platform.isAndroid) {
      String realUrl =
          SCUtils.getWebViewUrl(url: url, title: title, needJointParams: true);

      /// 调用Android WebView
      SCRouterHelper.pathPage(SCRouterPath.webViewPath, {
        "title": title,
        "url": realUrl,
        "needJointParams": false
      })?.then((value) {
        if (value != null) {
          var params = jsonDecode(value);
          if (params.containsKey("orderId")) {
            SCLoadingUtils.show();
            Future.delayed(const Duration(milliseconds: 1000), () {
              SCLoadingUtils.hide();
              SCRouterHelper.pathPage(SCRouterPath.addOutboundPage,
                  {"isLL": true, "llData": params});
            });
          }
        }
      });
    } else {
      String realUrl =
          SCUtils.getWebViewUrl(url: url, title: title, needJointParams: true);
      SCRouterHelper.pathPage(SCRouterPath.webViewPath, {
        "title": title,
        "url": realUrl,
        "needJointParams": false
      })?.then((value) {
        if (value != null && value is Map) {
          if (value.containsKey("key")) {
            String key = value['key'];
            if (key == SCFlutterKey.kGotoMaterialKey) {
              SCLoadingUtils.show();
              Future.delayed(const Duration(milliseconds: 1000), () {
                SCLoadingUtils.hide();
                SCRouterHelper.pathPage(SCRouterPath.addOutboundPage,
                    {"isLL": true, "llData": jsonDecode(value['data'])});
              });
            }
          }
        }
      });
    }
  }
}
