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

/// 消息listview
class SCPatrolRouteListView extends StatelessWidget {

  /// SCMessageController
  final ScPatrolRouteController state;

  /// RefreshController
  final RefreshController refreshController;


  const SCPatrolRouteListView({Key? key, required this.state, required this.refreshController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<PlaceList>? data = state.model1.checkObject?.placeList;
    return SmartRefresher(
        controller: refreshController,
        enablePullUp: false,
        enablePullDown: false,
        header: const SCCustomHeader(
          style: SCCustomHeaderStyle.noNavigation,
        ),
        onRefresh: onRefresh,
        onLoading: loadMore,
        child: data!=null && data.isNotEmpty ? listView() : emptyView()
    );
  }

  Widget listView() {
    List<PlaceList>? data =state.model1.checkObject?.placeList;
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


  Widget body(List<PlaceList>? data,int index) {
    return GestureDetector(
      onTap: () {
        var model = data!=null? data[index]:null;
        SCRouterHelper.pathPage(SCRouterPath.patrolDetailPage, {"procInstId": model?.tenantId ?? '',"nodeId":  '',"type":"POLICED_WATCH"});
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
              children:  [
                const Padding(padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                  child:DecoratedBox(
                    decoration: BoxDecoration(
                      color: SCColors.color_4285F4
                    ),
                    child: SizedBox(
                      width: 2,
                      height: 15,
                    ),
                  )
                ),
                Text(
                    data!=null ? ("巡更点${index+1}") : "",
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
                height: 10.0,
              ),
            Text(
                data!=null ? (data[index].placeName ?? "") : "",
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

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               const Text(
                    "巡更方式",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style:  TextStyle(
                        fontSize: SCFonts.f16,
                        fontWeight: FontWeight.w400,
                        color: SCColors.color_8D8E99)),
                Text(
                    data!=null ? (data[index].execWay ?? "") : "",
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
    /*if (state.currentIndex == 0) {
      state.loadAllData(
          isMore: false,
          completeHandler: (bool success) {
            refreshController.refreshCompleted();
            refreshController.loadComplete();
          });
    } else if (state.currentIndex == 1) {
      state.loadUnreadData(
          isMore: false,
          completeHandler: (bool success) {
            refreshController.refreshCompleted();
            refreshController.loadComplete();
          });
    }*/
  }

  /// 上拉加载
  void loadMore() async {
   /* if (state.currentIndex == 0) {
      state.loadAllData(
          isMore: true,
          completeHandler: (bool success) {
            refreshController.loadComplete();
          });
    } else if (state.currentIndex == 1) {
      state.loadUnreadData(
          isMore: true,
          completeHandler: (bool success) {
            refreshController.loadComplete();
          });
    }*/
  }

}