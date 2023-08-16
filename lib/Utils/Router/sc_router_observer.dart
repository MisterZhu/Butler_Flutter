import 'package:flutter/material.dart';

class SCAppRouteObserver {
  //这是实际上的路由监听器
  static final RouteObserver<ModalRoute<void>> _routeObserver =
  RouteObserver<ModalRoute<void>>();
  //这是个单例
  static final SCAppRouteObserver _appRouteObserver =
  SCAppRouteObserver._internal();

  SCAppRouteObserver._internal() {}

  //通过单例的get方法轻松获取路由监听器
  RouteObserver<ModalRoute<void>> get routeObserver {
    return _routeObserver;
  }

  factory SCAppRouteObserver() {
    return _appRouteObserver;
  }
}
