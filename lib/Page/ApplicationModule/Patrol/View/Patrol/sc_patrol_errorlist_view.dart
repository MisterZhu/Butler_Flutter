import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:smartcommunity/Page/ApplicationModule/Patrol/Model/sc_form_data_model.dart';
import '../../../../../Network/sc_config.dart';
import '../../../../../Utils/Date/sc_date_utils.dart';
import '../../../../../Utils/Router/sc_router_helper.dart';
import '../../../../../Utils/Router/sc_router_path.dart';
import '../../../../../Utils/sc_utils.dart';
import '../../Controller/sc_patrol_route_controller.dart';
import '../../Model/sc_patrol_task_model.dart';

/// 消息listview
class SCPatrolErrorListView extends StatelessWidget {

  /// SCMessageController
  final ScPatrolRouteController state;

  /// RefreshController
  final RefreshController refreshController;


  const SCPatrolErrorListView({Key? key, required this.state, required this.refreshController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<SCPatrolTaskModel>? data = state.dataList1;
    return SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        enablePullDown: true,
        header: const SCCustomHeader(
          style: SCCustomHeaderStyle.noNavigation,
        ),
        onRefresh: onRefresh,
        onLoading: loadMore,
        child: data!=null && data.isNotEmpty ? listView() : emptyView()
    );
  }

  Widget listView() {
    List<SCPatrolTaskModel> data =state.dataList1;
    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return body(data,index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 10.0,);
        },
        itemCount: data!=null? data.length:0);
  }


  Widget body(List<SCPatrolTaskModel>? data,int index) {
    return GestureDetector(
      onTap: () {
        var model = data!=null? data[index]:null;
        SCRouterHelper.pathPage(SCRouterPath.patrolDetailPage, {"procInstId": model?.procInstId ?? '',"nodeId":model?.nodeId??"","type":"POLICED_WATCH"});
        //detailTapAction?.call();
      },
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
          decoration: BoxDecoration(
              color: SCColors.color_FFFFFF,
              borderRadius: BorderRadius.circular(4.0)
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                      "任务状态",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style:  TextStyle(
                          fontSize: SCFonts.f16,
                          fontWeight: FontWeight.w500,
                          color: SCColors.color_1B1D33)),
                  Text(
                      data!=null ? (data[index].customStatus ?? "") : "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: SCFonts.f16,
                          fontWeight: FontWeight.w500,
                          color: SCColors.color_1B1D33)),
                ],
              ),
             const SizedBox(
                height: 10,
              ),
              Text(
                  data!=null ? (data[index].procInstName?? "") : "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: SCFonts.f16,
                      fontWeight: FontWeight.w500,
                      color: SCColors.color_1B1D33)),
              const SizedBox(
                height: 10.0,
              ),
            ],
          )
      ),
    );
  }



  /// emptyView
  Widget emptyView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 124.0,
        ),
        Image.asset(SCAsset.iconMessageEmpty, width: 120.0, height: 120.0,),
        const SizedBox(
          height: 2.0,
        ),
        const Text("暂无消息", style: TextStyle(
            fontSize: SCFonts.f14,
            fontWeight: FontWeight.w400,
            color: SCColors.color_8D8E99
        ),)
      ],
    );
  }

  /// 下拉刷新
  Future onRefresh() async {
    state.loadData(
        isMore: false,
        completeHandler: (bool success,bool last) {
          refreshController.refreshCompleted();
          refreshController.loadComplete();
        });
  }

  /// 上拉加载
  void loadMore() async {
    state.loadData(
        isMore: true,
        completeHandler: (bool success,bool last) {
          refreshController.loadComplete();
        });
  }

}