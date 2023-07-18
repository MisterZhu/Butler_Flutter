/*皮肤管理工具*/

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartcommunity/Constants/sc_flutter_key.dart';
import 'package:smartcommunity/Network/sc_http_manager.dart';
import 'package:smartcommunity/Page/Login/Home/Model/sc_user_model.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Model/sc_default_config_model.dart';
import 'package:smartcommunity/Utils/JPush/sc_jpush.dart';
import 'package:smartcommunity/Utils/Router/sc_router_path.dart';
import '../../Constants/sc_default_value.dart';
import '../../Constants/sc_key.dart';
import '../../Utils/Colors/sc_color_hex.dart';
import '../../Constants/sc_skin_key.dart';
import '../../Constants/sc_skin_value.dart';
import '../../Utils/Router/sc_router_helper.dart';
import '../../Utils/sc_sp_utils.dart';
import '../GetXController/sc_scaffold_controller.dart';
import '../Model/sc_scaffold_model.dart';
import 'package:event_bus/event_bus.dart';

class SCScaffoldManager {
  factory SCScaffoldManager() => _instance;

  static SCScaffoldManager get instance => _instance;

  static final SCScaffoldManager _instance = SCScaffoldManager._internal();

  static late SCScaffoldModel _scaffoldModel;

  static late SCUserModel _user;

  static bool _isLogin = false;

  static late SharedPreferences _preferences;

  static late List _getXTagList;

  /// 默认配置数据
  static SCDefaultConfigModel? _defaultConfigModel;

  /// 空间id
  static String? _spaceIds;

  /// eventBus
  static late EventBus _eventBus;

  /// 经度
  static late double _latitude;

  /// 纬度
  static late double _longitude;

  /// 未读消息数量
  static late int _unreadMessageCount;

  /// flutter调用原生的channel
  static MethodChannel flutterToNative = const MethodChannel(SCFlutterKey.kFlutterToNative);

  /// 原生调用flutter的channel
  static EventChannel _nativeToFlutter = const EventChannel(SCFlutterKey.kNativeToFlutter);

  /// flutter调用原生的channel 方法名
  static String android_webview = "android_webview";
  static String android_baidu_ocr = "android_baidu_ocr";

  /// 极光
  static late JPush _jPush;

  SCScaffoldManager._internal() {
    _scaffoldModel = SCScaffoldModel();
    _user = SCUserModel();
  }

  SCScaffoldModel get scaffoldModel => _scaffoldModel;

  EventChannel get nativeToFlutter => _nativeToFlutter;

  SCUserModel get user => _user;

  bool get isLogin => _isLogin;

  SharedPreferences get preferences => _preferences;

  List get getXTagList => _getXTagList;

  SCDefaultConfigModel? get defaultConfigModel => _defaultConfigModel;

  String? get spaceIds => _spaceIds;

  EventBus get eventBus => _eventBus;

  double get latitude => _latitude;

  double get longitude => _longitude;

  int get unreadMessageCount => _unreadMessageCount;

  JPush get jPush => _jPush;

  /// 初始化
  Future initBase() {
    _longitude = 120.2155118;
    _latitude = 30.25308298;
    _unreadMessageCount = 0;
    listenNativeToFlutterChannel();
    Get.put(SCCustomScaffoldController());
    return SCScaffoldManager.instance.initScaffold();
  }

  /// set user
  set user(SCUserModel user) {
    // TODO: implement user=
    _user = user;
    cacheUserData(user.toJson());
  }

  /// set login
  set isLogin(bool isLogin) {
    // TODO: implement isLogin=
    _isLogin = isLogin;
    cacheUserIsLogin(isLogin);
  }

  /// set defaultConfigModel
  set defaultConfigModel(SCDefaultConfigModel? model) {
    // TODO: implement SCDefaultConfigModel=
    _defaultConfigModel = model;
  }

  /// set spaceIds
  set spaceIds(String? spaceIds) {
    // TODO: implement spaceIds=
    _spaceIds = spaceIds;
  }

  /// set latitude
  set latitude(double latitude) {
    // TODO: implement latitude=
    _latitude = latitude;
  }

  /// set longitude
  set longitude(double longitude) {
    // TODO: implement longitude=
    _longitude = longitude;
  }

  /// set unreadMessageCount
  set unreadMessageCount(int unreadMessageCount) {
    _unreadMessageCount = unreadMessageCount;
  }

  /// set jPush
  set jPush(JPush jPush) {
    _jPush = jPush;
  }

  /// 初始化scaffold数据
  Future initScaffold() async {
    _getXTagList = [];
    _preferences = await SharedPreferences.getInstance();
    _eventBus = EventBus();

    bool hasScaffoldKey = _preferences.containsKey(SkinDefaultKey.scaffold_key);

    /// 是否同意用户协议
    bool agreeProtocol = _preferences.containsKey(SCKey.isShowPrivacyAlert);

    if (hasScaffoldKey) {
      String? scaffoldJsonString =
          _preferences.getString(SkinDefaultKey.scaffold_key);
      var localJson = jsonDecode(scaffoldJsonString ?? '');
      _scaffoldModel = SCScaffoldModel.fromJson(localJson);
    } else {
      _scaffoldModel = SCScaffoldModel.fromJson(scaffoldJson);
      _preferences.setString(
          SkinDefaultKey.scaffold_key, jsonEncode(scaffoldJson));
    }

    final state = Get.find<SCCustomScaffoldController>();
    Color color = SCHexColor(_scaffoldModel.navBackgroundColor ??
        scaffoldJson['navBackgroundColor']);
    state.setPrimaryColor(color);
    state.setTitleColor(
        SCHexColor(_scaffoldModel.titleColor ?? scaffoldJson['titleColor']));

    getUserData();
    initJPush(agreeProtocol);
    return _preferences;
  }

  /// 初始化极光
  initJPush(bool agreeProtocol) {
    if (agreeProtocol) {
      SCJPush.initJPush();
    }
  }

  /// 获取Router的BasePath
  Future<String> getRouterBasePath() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool isShowPrivacy = preferences.getBool(SCKey.isShowPrivacyAlert) ?? false;

    String basePath = SCRouterPath.loginPath;

    bool contains = SCSpUtil.containsKey(SCKey.kIsLogin);
    if (contains == true) {
      _isLogin = SCSpUtil.getBool(SCKey.kIsLogin);
    }

    if (isShowPrivacy == true) {
      basePath = SCRouterPath.basePrivacyPath;
    } else {
      if (_isLogin) {
        basePath = SCRouterPath.tabPath;
      }
    }

    return Future(() => basePath);
  }

  /*修改Nav背景颜色*/
  void changeNavBackgroundColor(Color color) async {
    _scaffoldModel.navBackgroundColor = SCHexColor.colorToString(color);
    final state = Get.find<SCCustomScaffoldController>();
    state.setPrimaryColor(color);

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(SkinDefaultKey.scaffold_key, jsonEncode(_scaffoldModel.toJson()));
  }

  /*修改title颜色*/
  void changeTitleColor(Color color) async {
    _scaffoldModel.titleColor = SCHexColor.colorToString(color);
    final state = Get.find<SCCustomScaffoldController>();
    state.setTitleColor(color);

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(SkinDefaultKey.scaffold_key, jsonEncode(_scaffoldModel.toJson()));
  }

  /*缓存用户登录状态*/
  cacheUserIsLogin(bool login) {
    SCSpUtil.setBool(SCKey.kIsLogin, login);
  }

  /*缓存用户信息*/
  cacheUserData(dynamic data) async {
    print("缓存用户信息:$data");
    SCSpUtil.setMap(SCKey.kUserData, data);
  }

  /*退出登录*/
  logout({bool? isAfterTip, Duration? tipDuration}) {
    _user = SCUserModel();
    _isLogin = false;
    SCSpUtil.remove(SCKey.kIsLogin);
    SCSpUtil.remove(SCKey.kUserData);
    SCHttpManager.instance.updateHeaders(headers: {
      'Content-Type': 'application/json; charset=utf-8',
      'client': SCDefaultValue.client
    });
    SCJPush.deleteAlias();

    bool isAfterTipStatus = isAfterTip ?? false;

    if (isAfterTipStatus == false) {
      SCRouterHelper.pathOffAllPage(SCRouterPath.loginPath, null);
    } else {
      Duration duration = tipDuration ?? EasyLoading.instance.displayDuration;
      Future.delayed(duration,() {
        SCRouterHelper.pathOffAllPage(SCRouterPath.loginPath, null);
      });
    }
  }

  /*清空用户信息*/
  clearUserData() {
    SCSpUtil.remove(SCKey.kUserData);
  }

  /*获取用户信息*/
  getUserData() {
    bool contains = SCSpUtil.containsKey(SCKey.kUserData);
    if (contains == true) {
      var data = SCSpUtil.getMap(SCKey.kUserData);
      _user = SCUserModel.fromJson(data);
      print('本地数据：${_user.toJson()}');
      return _user;
    }
  }

  /// 获取GetXController-tag
  String getXControllerTag(String pageName) {
    bool isContainPage = false;
    int pageIndex = 0;
    String tag = "$pageName$pageIndex";
    for (int i = 0; i < getXTagList.length; i++) {
      var json = getXTagList[i];
      String subPageName = json['pageName'];
      if (subPageName == pageName) {
        isContainPage = true;
        pageIndex = i;
        break;
      }
    }

    if (isContainPage) {
      /// page已存在
      var json = getXTagList[pageIndex];
      int index = json['index'];
      List tagList = json['tagList'];
      index += 1;
      tag = "$pageName$index";
      tagList.add(tag);
      json['index'] = index;
      json['tagList'] = tagList;
      getXTagList[pageIndex] = json;
    } else {
      /// page不存在
      var json = {
        "pageName": pageName,
        "index": 0,
        "tagList": [tag]
      };
      getXTagList.add(json);
    }
    return tag;
  }

  /// 删除GetXController-tag
  bool deleteGetXControllerTag(String pageName, String tag) {
    bool success = false;
    bool isContainPage = false;
    int pageIndex = 0;
    for (int i = 0; i < getXTagList.length; i++) {
      var json = getXTagList[i];
      String subPageName = json['pageName'];
      if (subPageName == pageName) {
        isContainPage = true;
        pageIndex = i;
        break;
      }
    }

    if (isContainPage) {
      var json = getXTagList[pageIndex];
      int index = json['index'];
      List list = json['tagList'];
      success = list.remove(tag);
      if (success) {
        index -= 1;
      }
      json['tagList'] = list;
      json['index'] = index;
      getXTagList[pageIndex] = json;
    }
    return success;
  }

  /// 监听原生调用flutter的消息
  listenNativeToFlutterChannel() {
    nativeToFlutter.receiveBroadcastStream().listen(nativeToFlutterAction, onError: nativeToFlutterError);
  }

  /*原生调用flutter*/
  void nativeToFlutterAction(dynamic data) {
    print('原生传递过来的消息:${data.toString()}');
    SCToast.showTip('原生调用了flutter');
    // Map<String, dynamic> baseParams = new Map<String, dynamic>.from(data);
    // String? key = baseParams['key'];
    // Map<String, dynamic> params =
    // new Map<String, dynamic>.from(baseParams['data']);
    // if (key == flutter_headerParams_key) {
    //   MJAppInit.initHttp(params);
    //   setState(() {
    //     nativeHeaderState = true;
    //   });
    // }
  }

  /*原生调用flutter错误*/
  void nativeToFlutterError(Object err) {
    print('原生调用失败');
  }

  /// flutter调用原生
  Future flutterToNativeAction(String methodName ,dynamic params) {
    return flutterToNative.invokeMethod(methodName, params);
  }
}
