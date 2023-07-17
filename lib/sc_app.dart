
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Base/sc_all_binding.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';
import 'package:smartcommunity/Utils/Router/sc_router_pages.dart';
import 'package:smartcommunity/Utils/WeChat/sc_wechat_utils.dart';
import 'package:smartcommunity/Utils/sc_sp_utils.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void startApp() async {

  await SCScaffoldManager.instance.initBase();

  SCLoadingUtils.initLoading();

  WidgetsFlutterBinding.ensureInitialized();

  /// 路由的basePath
  String basePath = await SCScaffoldManager.instance.getRouterBasePath();

  RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  // Android设备设置沉浸式
  if(Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ));
  }

  runApp(GetMaterialApp(
    theme: ThemeData(
        primaryColor: Colors.white,
        colorScheme: const ColorScheme(brightness: Brightness.light, primary: Colors.white, onPrimary: SCColors.color_1B1C33, secondary: SCColors.color_1B1C33, onSecondary: Colors.white, error: Colors.white, onError: Colors.white, background: Colors.white, onBackground: Colors.white, surface: Colors.white, onSurface: Colors.white)
    ),
    navigatorKey: navigatorKey,
    debugShowCheckedModeBanner: false,
    getPages: SCRouterPages.getPages,
    initialRoute: basePath,
    initialBinding: SCAllBinding(),
    defaultTransition: Transition.cupertino,
    builder: EasyLoading.init(builder: (context, widget) {
      return MediaQuery(
        // 设置文字大小不随系统设置改变
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: widget ?? const SizedBox(),
      );
    },),
    navigatorObservers: [routeObserver],
    locale: const Locale("zh", "CH"),
    fallbackLocale: const Locale('en', 'US'),
    supportedLocales: const [
      Locale("zh", "CH"),
      Locale('en', 'US')
    ],
    localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      SfGlobalLocalizations.delegate
    ],
  ));

  SCWeChatUtils.init();
}

