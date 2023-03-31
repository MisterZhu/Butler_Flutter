import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
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
    JPush jPush = new JPush();
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
      int type = -1;
      String url = '';
      String title = '';
      print("1111111");
      if (Platform.isIOS) {
        extras = message['extras'];
        alert = message['aps']['alert'];
        if (alert.containsKey('title')) {
          title = alert['title'];
        }
      } else {
        extras = jsonDecode(message['extras']['cn.jpush.android.EXTRA']);
        title = message['title'];
      }
      print("222222222===$extras");
      if (extras.containsKey('type')) {
        type = extras['type'];
      }
      if (extras.containsKey('url')) {
        url = extras['url'];
      }
      print("3333333:url===$url");
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
      var params = {"title": title, "url": realUrl};
      var channel = SCScaffoldManager.flutterToNative;
      var result =
          await channel.invokeMethod(SCScaffoldManager.android_webview, params);
    } else {
      String realUrl =
          SCUtils.getWebViewUrl(url: url, title: title, needJointParams: true);
      SCRouterHelper.pathPage(SCRouterPath.webViewPath, {
        "title": title,
        "url": realUrl,
        "needJointParams": false
      })?.then((value) {});
    }
  }
}
