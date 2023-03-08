import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../../Constants/sc_enum.dart';
import '../../../../ApplicationModule/MaterialEntry/Model/sc_material_entry_model.dart';
import '../../../../ApplicationModule/MaterialEntry/View/MaterialEntry/sc_material_entry_cell.dart';
import '../../GetXController/sc_workbench_controller.dart';
import '../PageView/sc_workbench_empty_view.dart';

/// 工作台物资listView

class SCWorkBenchMaterialListView extends StatelessWidget {
  SCWorkBenchMaterialListView(
      {Key? key,
      required this.dataList,
      required this.state,
      required this.type,
      required this.isLast,
      this.detailAction,
      this.submitAction,
      this.callAction})
      : super(key: key);

  final List dataList;

  /// 工作台controller
  final SCWorkBenchController state;

  /// 是否是最后一页
  final bool isLast;

  /// type
  final SCWarehouseManageType type;

  /// 详情
  final Function(SCMaterialEntryModel model)? detailAction;

  /// 提交
  final Function(SCMaterialEntryModel model)? submitAction;

  /// 拨号
  final Function(String phone)? callAction;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    if (dataList.isNotEmpty) {
      var value = dataList.first;
      if (value is SCMaterialEntryModel) {
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
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        shrinkWrap: true,
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
    SCMaterialEntryModel model = dataList[index];
    return SCMaterialEntryCell(
      model: model,
      type: type,
      detailTapAction: () {
        detail(model);
      },
      btnTapAction: () {
        submit(model);
      },
      callAction: (String phone) {
        call(phone);
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
    state.loadMore().then((value) {
      if (isLast) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
    });
  }

  /// 详情
  detail(model) {
    detailAction?.call(model);
  }

  /// 提交
  submit(model) {
    submitAction?.call(model);
  }

  /// 拨号
  call(phone) {
    callAction?.call(phone);
  }
}
