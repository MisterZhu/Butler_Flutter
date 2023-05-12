import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/Patrol/Other/sc_patrol_utils.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Model/sc_todo_model.dart';
import 'package:smartcommunity/Page/WorkBench/Other/sc_todo_utils.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';

import '../../../../../Constants/sc_h5.dart';
import '../../../../../Constants/sc_key.dart';
import '../../../../../Network/sc_config.dart';
import '../../../../../Network/sc_http_manager.dart';
import '../../../../../Network/sc_url.dart';
import '../../../../../Utils/Router/sc_router_helper.dart';
import '../../../../../Utils/Router/sc_router_path.dart';
import '../../../../../Utils/sc_utils.dart';
import '../PageView/sc_workbench_empty_view.dart';

/// 工作台-待办listview

class SCWorkBenchToDoListView extends StatelessWidget {
  /// 数据源
  final List data;

  /// refreshController
  final RefreshController refreshController;

  /// 下拉刷新
  final Function? onRefreshAction;

  /// 加载更多
  final Function? loadMoreAction;

  const SCWorkBenchToDoListView(
      {Key? key,
      required this.data,
      required this.refreshController,
      this.onRefreshAction,
      this.loadMoreAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (data.isNotEmpty) {
      body = listView();
    } else {
      body = const SCWorkBenchEmptyView(
        scrollPhysics: NeverScrollableScrollPhysics(),
      );
    }
    return SmartRefresher(
      controller: refreshController,
      enablePullDown: true,
      enablePullUp: data.isNotEmpty,
      onRefresh: onRefresh,
      onLoading: onLoading,
      header: const SCCustomHeader(),
      footer: const ClassicFooter(
        loadingText: '加载中...',
        idleText: '加载更多',
        noDataText: '到底了',
        failedText: '加载失败',
        canLoadingText: '加载更多',
      ),
      child: body,
    );
  }

  /// listView
  Widget listView() {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return getCell(index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return line(index);
        },
        itemCount: data.length);
  }

  /// cell
  Widget getCell(int index) {
    SCToDoModel model = data[index];
    // todo 暂时固定
    model.statusValue = '2';
    String status = model.statusValue ?? '0';
    bool hideAddressRow = true;
    // 按钮文字
    String btnText = '';
    if ((model.operationList ?? []).isNotEmpty) {
      btnText = model.operationList?.first;
    }
    return SCTaskCardCell(
      timeType: index,
      title: model.title,
      statusTitle: model.statusName,
      statusTitleColor: SCColors.color_4285F4,
      content: model.content,
      tagList: const [],
      address: '',
      contactUserName: '',
      remainingTime: 0,
      time: model.createTime,
      btnText: btnText,
      // btnText: SCUtils.getWorkOrderButtonText(
      //     int.parse(status.isEmpty ? '0' : status)),
      hideBtn: (model.operationList ?? []).isEmpty,
      hideAddressRow: hideAddressRow,
      btnTapAction: () {
        SCToDoUtils().dealPatrolTask(model, btnText);
      },
      detailTapAction: () {
        SCToDoUtils().detail(model);
      },
    );
  }

  /// line
  Widget line(int index) {
    return const SizedBox(
      height: 10.0,
    );
  }

  /// 下拉刷新
  Future onRefresh() async {
    onRefreshAction?.call();
    // widget.state.loadMore().then((value) {
    //   refreshController.loadComplete();
    // });
  }

  /// 加载更多
  Future onLoading() async {
    loadMoreAction?.call();
    // widget.state.loadMore().then((value) {
    //   refreshController.loadComplete();
    // });
  }

  // /// 详情
  // detailAction(SCToDoModel model) async{
  //   String statusValue = model.statusValue ?? '0';
  //   int status = int.parse(statusValue.isEmpty ? '0' : statusValue);
  //   String title = SCUtils.getWorkOrderButtonText(status);
  //   String url =
  //       "${SCConfig.BASE_URL}${SCH5.workOrderUrl}?isFromWorkBench=1&status=$status&orderId=${model.id}";
  //   String realUrl = SCUtils.getWebViewUrl(url: url, title: title, needJointParams: true);
  //   SCRouterHelper.pathPage(SCRouterPath.webViewPath, {
  //     "title": model.title ?? '',
  //     "url": realUrl,
  //     "needJointParams": false
  //   })?.then((value) {
  //     SCScaffoldManager.instance.eventBus.fire({"key" : SCKey.kRefreshWorkBenchPage});
  //   });
  // }
}
