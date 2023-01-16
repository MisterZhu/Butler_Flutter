/// 实地核验listview

import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Model/sc_verification_order_model.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Model/sc_work_order_model.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/PageView/sc_workbench_empty_view.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/RealVerification/sc_realverification_cell.dart';

/// 实地核验listview

class SCRealVerificationListView extends StatelessWidget {
  SCRealVerificationListView({Key? key, required this.dataList, this.callAction, this.doneAction}) : super(key: key);

  final List dataList;

  /// 打电话
  final Function(String phone)? callAction;

  /// 完成
  final Function(SCVerificationOrderModel model)? doneAction;

  RefreshController refreshController =
  RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    if (dataList.isNotEmpty) {
      var value = dataList.first;
      if (value is SCVerificationOrderModel) {
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
      } else {
        return SCWorkBenchEmptyView();
      }
    } else {
      return SCWorkBenchEmptyView();
    }
  }

  /// listView
  Widget listView() {
    return ListView.separated(
        shrinkWrap: true,
        padding:
        const EdgeInsets.only(left: 16.0, right: 16.0, top: 0, bottom: 0),
        itemBuilder: (BuildContext context, int index) {
          return cell(index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return line(index);
        },
        itemCount: dataList.length);
  }

  /// cell
  Widget cell(int index) {
    return SCRealVerificationCell(
      model: dataList[index],
      callAction: (value) {
        callAction?.call(value);
      },
      doneAction: (SCVerificationOrderModel model) {
        doneAction?.call(model);
      },
    );
  }

  /// line
  Widget line(int index) {
    return const SizedBox(
      height: 10.0,
    );
  }

  /// 加载更多
  Future onLoading() async {
    Future.delayed(const Duration(milliseconds: 1500), () {
      refreshController.loadComplete();
    });
  }
}
