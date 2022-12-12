import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/PageView/sc_workbench_time_view.dart';

/// 工作台-listView

class SCWorkBenchListView extends StatefulWidget {
  const SCWorkBenchListView({
    Key? key,
    this.detailAction,
    this.moreAction,
    this.likeAction,
    this.callAction,
    this.acceptAction
  }) : super(key: key);

  /// 详情
  final Function(int index)? detailAction;

  /// 更多
  final Function(int index)? moreAction;

  /// 收藏
  final Function(int index)? likeAction;

  /// 打电话
  final Function(int index)? callAction;

  /// 立即接单
  final Function(int index)? acceptAction;

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
      footer: const ClassicFooter(loadingText: '加载中...', idleText: '加载更多', noDataText: '到底了', failedText: '加载失败', canLoadingText: '加载更多',),
      child: ListView.separated(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, top: 0, bottom: 0),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return cell(index);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 12.0);
          },
          itemCount: timeList.length),
    );
  }

  /// cell
  Widget cell(int index) {
    return GestureDetector(
      onTap: () {
        widget.detailAction?.call(index);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
            color: SCColors.color_FFFFFF,
            borderRadius: BorderRadius.circular(4.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            titleView(index),
            const SizedBox(
              height: 12.0,
            ),
            contentView(index),
            const SizedBox(
              height: 6.0,
            ),
            addressInfoView(index),
            const SizedBox(
              height: 12.0,
            ),
            line(),
            const SizedBox(
              height: 12.0,
            ),
            timeView(index)
          ],
        ),
      ),
    );
  }

  /// title
  Widget titleView(int index) {
    String title = '居家维修/门锁';
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
                    ), onPressed: (){
                      widget.likeAction?.call(index);
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
                widget.moreAction?.call(index);
              })
        ],
      ),
    );
  }

  /// content
  Widget contentView(int index) {
    String title = '家里大门的智能锁失灵，一时打开一时打不开，有时自动开，请专业人员来查看...';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Text(
        title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
            fontSize: SCFonts.f14,
            fontWeight: FontWeight.w400,
            color: SCColors.color_1B1D33),
      ),
    );
  }

  /// 地址等信息
  Widget addressInfoView(int index) {
    String address = '慧享生活馆-1幢-3单元-201';
    String name = '李大明';
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
                widget.callAction?.call(index);
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
  Widget timeView(int index) {
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
                  widget.acceptAction?.call(index);
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
