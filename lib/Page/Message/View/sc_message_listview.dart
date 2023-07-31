import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import '../../../Network/sc_config.dart';
import '../../../Utils/Date/sc_date_utils.dart';
import '../../../Utils/Router/sc_router_helper.dart';
import '../../../Utils/Router/sc_router_path.dart';
import '../../../Utils/sc_utils.dart';
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

  SCMessageListView(
      {Key? key,
      required this.state,
      required this.type,
      required this.refreshController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<SCMessageCardModel> data =
        type == 1 ? state.unreadDataList : state.allDataList;
    return SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        enablePullDown: true,
        header: const SCCustomHeader(
          style: SCCustomHeaderStyle.noNavigation,
        ),
        onRefresh: onRefresh,
        onLoading: loadMore,
        child: data.isNotEmpty ? listView() : emptyView());
  }

  Widget listView() {
    List<SCMessageCardModel> data =
        type == 1 ? state.unreadDataList : state.allDataList;
    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          SCMessageCardModel model = data[index];
          List list = [];
          int cardType = 0; // 卡片类型,0-只显示一行内容,1-显示两行内容,2-显示图片+内容+内容描述
          // noticeCardType卡片类型 1:数据卡片形式; 2:文章消息卡片
          if (model.noticeCardType == 2) {
            // 2:文章消息卡片
            cardType = 2; // 2-显示图片+内容+内容描述
          }
          String head = '';
          String content = '';
          if (model.displayItems != null) {
            if (model.displayItems!.isNotEmpty) {
              List displayItems = model.displayItems!;
              DisplayItems firstItem = displayItems.first;
              if (firstItem.noticeConsumerMobileCardItemDisplayType == 1) {
                //1值换行+加粗
                cardType == 1;
              }
              head = firstItem.head ?? '';
              content = firstItem.content ?? '';
              if (model.displayItems!.length > 1) {
                for (int i = 1; i < displayItems.length; i++) {
                  DisplayItems item = displayItems[i];
                  list.add({'title': item.head, 'content': item.content});
                }
              }
            }
          }
          if(model.noticeCardType == 1 && model.category == '待办通知'){
            // head = firstItem.head ?? '';
            cardType == 1;
            content = model.content ?? '';
          }
          return SCMessageCardCell(
            type: cardType,
            title: model.category,
            icon: model.icon?.fileKey != null
                ? SCConfig.getImageUrl(model.icon?.fileKey ?? '')
                : SCAsset.iconMessageType,
            time: SCDateUtils.relativeDateFormat(
                DateTime.parse(model.noticeTime ?? '')),
            isUnread: type == 1 ? true : false,
            head: head,
            content: content,
            contentIcon: model.linkImage?.fileKey != null
                ? SCConfig.getImageUrl(model.linkImage?.fileKey ?? '')
                : SCAsset.iconMessageContentDefault,
            bottomContentList: list,
            detailTapAction: () {
              if(model.noticeCardType == 1 && model.category == '待办通知'){
                print('123待办通知待办通知待办通知待办通知未开发！！');
                debugPrint('1111=====${model}');
                SCRouterHelper.pathPage(SCRouterPath.messageNeedHandlePage, {
                  "taskMsg": model?.taskMsg,
                  "content": model.content,
                });
                return;
              }
              if (model.ext != '""') {
                if (model.ext != null) {
                  // String jsonString =
                  //     "\"{\\\"annexFile\\\":{\\\"download\\\":false,\\\"files\\\":[{\\\"fileKey\\\":\\\"tmp/eb1e1ad8-85af-42d0-ba3c-21229be19009/20230713/1689235351742109.pdf\\\",\\\"name\\\":\\\"关于开展深入学习贯彻集团半年度会议宋卫平董事长“以人为本，以终为始，全面推进集团高质量发展”讲话精神的通知（绿城服务通〔2023〕147号）.pdf\\\",\\\"size\\\":192479,\\\"suffix\\\":\\\"pdf\\\"}]},\\\"jumpUrl\\\":\\\"/h5Manage/#/notification/notificationDetail?id=13214716299661\\\",\\\"tags\\\":[{\\\"code\\\":2,\\\"name\\\":\\\"公告\\\"}]}\"";
                  String jsonString = model.ext ?? "";
                  var ext = jsonDecode(jsonString);
                  var jumpStr = "";
                  // 判断字符串是否被双引号包裹
                  if (jsonString.startsWith("\"") &&
                      jsonString.endsWith("\"")) {
                    // 去掉外层的双引号和转义字符
                    jsonString = jsonString.replaceAll("\\", "");
                    jsonString = jsonString.replaceAll('{', '');
                    jsonString = jsonString.replaceAll('}', '');
                    jsonString = jsonString.replaceAll('[', '');
                    jsonString = jsonString.replaceAll(']', '');
                    jsonString = jsonString.replaceAll('"', '');
                    print("jsonString =" + jsonString);
                    List<String> itemsList = jsonString.split(',');
                    for (String fruit in itemsList) {
                      if (fruit.contains("jumpUrl")) {
                        List<String> parts = fruit.split(':');
                        jumpStr = parts.last;
                        break;
                      }
                    }
                    print("jumpUrl111 =" + jumpStr);
                  } else {
                    jumpStr = ext['jumpUrl'] ?? "";
                    print("jumpUrl222 =" + jumpStr);
                  }

                  if (jumpStr.isNotEmpty) {
                    if (model.cardCode == 'CONTENT_MESSAGE') {
                      // 跳转到站内信详情h5
                      String jumpUrl = SCConfig.getH5Url(jumpStr);
                      if (jumpUrl.contains("?")) {
                        jumpUrl =
                            "${SCConfig.getH5Url(jumpStr)}&noticeArriveId=${model.noticeArriveId}";
                      } else {
                        jumpUrl =
                            "${SCConfig.getH5Url(jumpStr)}?noticeArriveId=${model.noticeArriveId}";
                      }
                      String url = SCUtils.getWebViewUrl(
                          url: jumpUrl, title: '通知公告', needJointParams: true);
                      SCRouterHelper.pathPage(SCRouterPath.webViewPath,
                          {'title': '通知公告', 'url': url});
                    }
                  } else if (model.noticeArriveId != null) {
                    state.loadDetailData(model.noticeArriveId!);
                  }
                }
              }
              if (model.noticeArriveId != null) {
                state.loadDetailData(model.noticeArriveId!);
              }
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 10.0,
          );
        },
        itemCount: data.length);
  }

  /// emptyView
  Widget emptyView() {
    if ((type == 0 && state.loadCompleted1 == true) ||
        (type == 1 && state.loadCompleted2 == true)) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 124.0,
          ),
          Image.asset(
            SCAsset.iconMessageEmpty,
            width: 120.0,
            height: 120.0,
          ),
          const SizedBox(
            height: 2.0,
          ),
          const Text(
            "暂无消息",
            style: TextStyle(
                fontSize: SCFonts.f14,
                fontWeight: FontWeight.w400,
                color: SCColors.color_8D8E99),
          )
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  /// 下拉刷新
  Future onRefresh() async {
    if (state.currentIndex == 0) {
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
    }
  }

  /// 上拉加载
  void loadMore() async {
    if (state.currentIndex == 0) {
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
    }
  }
}
