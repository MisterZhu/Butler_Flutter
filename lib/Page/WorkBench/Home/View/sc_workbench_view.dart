import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';

/// 工作台-view

class SCWorkBenchView extends StatelessWidget {

  SCWorkBenchView({
    Key? key,
    required this.height
  }) : super(key: key);

  /// 组件高度
  final double height;

  RefreshController refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        controller: refreshController,
        enablePullUp: false,
        enablePullDown: true,
        header: const SCCustomHeader(style: SCCustomHeaderStyle.noNavigation,),
        onRefresh: onRefresh,
        child: listView(),
    );
  }

  /// listView
  Widget listView() {
    return ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index){
          return SCStickyHeader(header: Container(
            height: 120,
            color: Colors.orange,
          ), content: Container(
            height: height - 120.0,
            color: Colors.cyan,
          ));
        }, separatorBuilder: (BuildContext context, int index){
      return const SizedBox();
    }, itemCount: 1);
  }

  /// 下拉刷新
  Future onRefresh() async {
    Future.delayed(const Duration(milliseconds: 1500), () {
      refreshController.refreshCompleted();
    });
  }
}