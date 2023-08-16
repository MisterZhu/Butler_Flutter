import 'package:flutter/material.dart';

/// tabBarView

class SCTabBarView extends StatelessWidget {

  const SCTabBarView({
    Key? key,
    required this.tabController,
    required this.pages
  }) : super(key: key);

  /// tabController
  final TabController tabController;

  /// 页面
  final List<Widget> pages;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
        controller: tabController,
        children: pages);
  }
}