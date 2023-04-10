import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import '../Controller/sc_message_controller.dart';
import '../Model/sc_message_card_model.dart';

/// 消息listview
class SCMessageListView extends StatelessWidget {

  /// SCMessageController
  final SCMessageController state;

  /// 类型，0全部，1未读
  final int type;

  /// RefreshController
  final RefreshController refreshController;

  SCMessageListView({Key? key, required this.state, required this.type, required this.refreshController}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        enablePullDown: true,
        header: const SCCustomHeader(
          style: SCCustomHeaderStyle.noNavigation,
        ),
        onRefresh: onRefresh,
        onLoading: loadMore,
        child: type == 0 ? listView() : emptyView()
    );
  }

  Widget listView() {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          //SCMessageModel model = state.dataList[index];
          return SCMessageCardCell(
            type: index,
            title: '交易提醒标题最长',
            icon: SCAsset.iconMessageType,
            time: '2023-01-22',
            isUnread: false,
            showMoreBtn: false,
            content: '订单状态更新',
            head: '交易金额',
            contentIcon: SCAsset.iconMessageContentDefault,
            bottomContentList: [{'title': '订单编号', 'content': '12345678901111'}, {'title': '备注', 'content': '已关闭'}],
            detailTapAction: () {

            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 10.0,);
        },
        itemCount: 5);
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
        completeHandler: (bool success, bool last) {
          refreshController.refreshCompleted();
          refreshController.loadComplete();
        });
  }

  /// 上拉加载
  void loadMore() async {
    state.loadData(
        isMore: true,
        completeHandler: (bool success, bool last) {
          if (last) {
            refreshController.loadNoData();
          } else {
            refreshController.loadComplete();
          }
        });
  }

}