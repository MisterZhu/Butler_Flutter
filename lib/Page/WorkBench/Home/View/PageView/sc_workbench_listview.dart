import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/PageView/sc_workbench_empty_view.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/PageView/sc_workbench_time_view.dart';

import '../../Model/sc_work_order_model.dart';

/// 工作台-listView

class SCWorkBenchListView extends StatefulWidget {
  const SCWorkBenchListView(
      {Key? key,
      required this.dataList,
      this.detailAction,
      this.moreAction,
      this.likeAction,
      this.callAction,
      this.acceptAction})
      : super(key: key);

  final List<SCWorkOrderModel> dataList;

  /// 详情
  final Function(String orderId)? detailAction;

  /// 更多
  final Function(String orderId)? moreAction;

  /// 收藏
  final Function(String orderId)? likeAction;

  /// 打电话
  final Function(String mobile)? callAction;

  /// 立即接单
  final Function(String orderId)? acceptAction;

  @override
  SCWorkBenchListViewState createState() => SCWorkBenchListViewState();
}

class SCWorkBenchListViewState extends State<SCWorkBenchListView>
    with AutomaticKeepAliveClientMixin {
  List timeList = [
    61,
    61,
    61,
    61,
    61,
    61,
    61,
    61,
    61,
    61,
  ];

  late Timer timer;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      enablePullDown: false,
      enablePullUp: true,
      onLoading: onLoading,
      footer: const ClassicFooter(
        loadingText: '加载中...',
        idleText: '加载更多',
        noDataText: '到底了',
        failedText: '加载失败',
        canLoadingText: '加载更多',
      ),
      child: listView(),
    );
  }

  Widget listView() {
    if (widget.dataList.isNotEmpty) {
      return ListView.separated(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 0, bottom: 0),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            SCWorkOrderModel model = widget.dataList[index];
            return cell(index, model);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 12.0);
          },
          itemCount: widget.dataList.length);
    } else {
      return SCWorkBenchEmptyView();
    }
  }

  /// cell
  Widget cell(int index, SCWorkOrderModel model) {
    return GestureDetector(
      onTap: () {
        widget.detailAction?.call(model.orderId ?? '');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
            color: SCColors.color_FFFFFF,
            borderRadius: BorderRadius.circular(4.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleView(model),
            const SizedBox(
              height: 12.0,
            ),
            contentView(model.description ?? ''),
            const SizedBox(
              height: 6.0,
            ),
            addressInfoView(model),
            const SizedBox(
              height: 12.0,
            ),
            line(),
            const SizedBox(
              height: 12.0,
            ),
            timeView(index, model)
          ],
        ),
      ),
    );
  }

  /// title
  Widget titleView(SCWorkOrderModel model) {
    String title = model.categoryName ?? '';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(children: [
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Image.asset(
                    SCAsset.iconWorkOrderCommon,
                    width: 18.0,
                    height: 18.0,
                  ),
                ),
                const WidgetSpan(
                    child: SizedBox(
                      width: 6.0,
                    )),
                TextSpan(
                    text: title,
                    style: const TextStyle(
                        fontSize: SCFonts.f16,
                        fontWeight: FontWeight.w500,
                        color: SCColors.color_1B1D33)),
                const WidgetSpan(
                    child: SizedBox(
                  width: 4.0,
                )),
                WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: CupertinoButton(
                        minSize: 22.0,
                        padding: EdgeInsets.zero,
                        child: Image.asset(
                          SCAsset.iconLikeSelect,
                          width: 22.0,
                          height: 22.0,
                        ),
                        onPressed: () {
                          widget.likeAction?.call(model.orderId ?? '');
                        }))
              ])),
          CupertinoButton(
              minSize: 20.0,
              padding: EdgeInsets.zero,
              child: Image.asset(
                SCAsset.iconGreyMore,
                width: 20.0,
                height: 20.0,
              ),
              onPressed: () {
                widget.moreAction?.call(model.orderId ?? '');
              })
        ],
      ),
    );
  }

  /// content
  Widget contentView(String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Text(
        content,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.left,
        style: const TextStyle(
            fontSize: SCFonts.f16,
            fontWeight: FontWeight.w500,
            color: SCColors.color_1B1D33),
      ),
    );
  }

  /// 地址等信息
  Widget addressInfoView(SCWorkOrderModel model) {
    String address = model.address ?? '';
    String name = model.reportUserName ?? '';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: [
          Image.asset(
            SCAsset.iconAddress,
            width: 16.0,
            height: 16.0,
          ),
          const SizedBox(
            width: 4.0,
          ),
          Expanded(
              child: Text(
            address,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: SCFonts.f12,
                fontWeight: FontWeight.w400,
                color: SCColors.color_5E5F66),
          )),
          CupertinoButton(
              minSize: 16.0,
              padding: EdgeInsets.zero,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    SCAsset.iconPhone,
                    width: 16.0,
                    height: 16.0,
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: SCFonts.f12,
                        fontWeight: FontWeight.w400,
                        color: SCColors.color_5E5F66),
                  )
                ],
              ),
              onPressed: () {
                widget.callAction?.call(model.reportUserPhone ?? '');
              })
        ],
      ),
    );
  }

  /// 横线
  Widget line() {
    return const Padding(
      padding: EdgeInsets.only(left: 12.0),
      child: Divider(
        height: 0.5,
        color: SCColors.color_EDEDF0,
      ),
    );
  }

  /// 倒计时
  Widget timeView(int index, SCWorkOrderModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '剩余时间',
            style: TextStyle(
                fontSize: SCFonts.f14,
                fontWeight: FontWeight.w400,
                color: SCColors.color_5E5F66),
          ),
          const SizedBox(
            width: 6.0,
          ),
          SCWorkBenchTimeView(
            time: timeList[index],
          ),
          const Expanded(child: SizedBox()),
          SizedBox(
            width: 100.0,
            height: 40.0,
            child: CupertinoButton(
                alignment: Alignment.center,
                borderRadius: BorderRadius.circular(4.0),
                minSize: 40.0,
                color: SCColors.color_4285F4,
                padding: EdgeInsets.zero,
                child: const Text(
                  '立即接单',
                  style: TextStyle(
                      fontSize: SCFonts.f16,
                      fontWeight: FontWeight.w400,
                      color: SCColors.color_FFFFFF),
                ),
                onPressed: () {
                  widget.acceptAction?.call(model.orderId ?? '');
                }),
          )
        ],
      ),
    );
  }

  /// 定时器
  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        for (int i = 0; i < timeList.length; i++) {
          int subTime = timeList[i];
          if (subTime <= 0) {
            timeList[i] = 0;
          } else {
            timeList[i] = subTime - 1;
          }
        }
      });
    });
  }

  /// 加载更多
  Future onLoading() async {
    Future.delayed(const Duration(milliseconds: 1500), () {
      refreshController.loadComplete();
    });
  }

  @override
  dispose() {
    super.dispose();
    if (timer.isActive) {
      timer.cancel();
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
