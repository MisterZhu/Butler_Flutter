import 'package:flutter/widgets.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/PageView/sc_workbench_empty_view.dart';

import '../../../../../Constants/sc_asset.dart';
import '../../../MaterialEntry/View/Alert/sc_reject_alert.dart';
import '../../Controller/sc_warningcenter_controller.dart';
import '../Alert/sc_warningtype_alert.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/Model/sc_material_entry_model.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/MaterialEntry/sc_material_entry_cell.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/MaterialEntry/sc_material_search_item.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/MaterialEntry/sc_material_sift_item.dart';
import '../../../../../Constants/sc_enum.dart';
import '../../../../../Utils/Router/sc_router_helper.dart';
import '../../../../../Utils/Router/sc_router_path.dart';
import '../../../../../Utils/sc_utils.dart';
import '../../../MaterialEntry/View/Alert/sc_sift_alert.dart';
import '../../../MaterialEntry/View/Alert/sc_sort_alert.dart';
import '../../../MaterialEntry/View/MaterialEntry/sc_add_entry_button.dart';

/// 预警中心view

class SCWarningCenterView extends StatefulWidget {
  /// SCWarningCenterController
  final SCWarningCenterController state;

  SCWarningCenterView({Key? key, required this.state}) : super(key: key);

  @override
  SCWarningCenterViewState createState() => SCWarningCenterViewState();
}

class SCWarningCenterViewState extends State<SCWarningCenterView> {
  List typeList = ['全部'];

  int selectGrade1 = 0;

  int selectStatus1 = 0;

  bool showTypeAlert = false;

  bool showGradeAlert = false;

  bool showStatusAlert = false;

  /// RefreshController
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    widget.state.loadOutboundType(() {
      List list = widget.state.outboundList.map((e) => e.name).toList();
      setState(() {
        typeList.addAll(list);
      });
    });
  }

  @override
  dispose() {
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SCMaterialSearchItem(
          name: '搜索预警编号',
          searchAction: () {
            SCRouterHelper.pathPage(SCRouterPath.entrySearchPage,
                {'type': SCWarehouseManageType.propertyMaintenance});
          },
        ),
        SCMaterialSiftItem(
          tagList: widget.state.siftList,
          tapAction: (index) {
            if (index == 0) {
              setState(() {
                showTypeAlert = !showTypeAlert;
                showGradeAlert = false;
                showStatusAlert = false;
              });
            } else if (index == 1) {
              setState(() {
                showTypeAlert = false;
                showGradeAlert = !showGradeAlert;
                showStatusAlert = false;
              });
            } else if (index == 2) {
              setState(() {
                showTypeAlert = false;
                showGradeAlert = false;
                showStatusAlert = !showStatusAlert;
              });
            }
          },
        ),
        Expanded(child: contentItem())
      ],
    );
  }

  /// contentItem
  Widget contentItem() {
    return Stack(
      children: [
        Positioned(left: 0, top: 0, right: 0, bottom: 0, child: listview()),
        Positioned(
          left: 0.0,
          right: 0.0,
          top: 0.0,
          bottom: 0.0,
          child: typeAlert(),
        ),
        Positioned(
          left: 0.0,
          right: 0.0,
          top: 0.0,
          bottom: 0.0,
          child: gradeAlert(),
        ),
        Positioned(
          left: 0.0,
          right: 0.0,
          top: 0.0,
          bottom: 0.0,
          child: statusAlert(),
        ),
      ],
    );
  }

  /// listview
  Widget listview() {
    // int count = widget.state.dataList.length;
    int count = 10;
    return SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        enablePullDown: true,
        header: const SCCustomHeader(
          style: SCCustomHeaderStyle.noNavigation,
        ),
        onRefresh: onRefresh,
        onLoading: loadMore,
        child: count > 0 ? ListView.separated(
            padding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return SCTaskCardCell(
                timeType: 0,
                remainingTime: 0,
                tagList: ['严重'],
                tagBGColorList: [SCColors.color_FFF1F0],
                tagTextColorList: [SCColors.color_FF4040],
                time: '2023-1-1',
                title: '标题',
                statusTitle: '处理中',
                content: '内容',
                address: '预警编号：ABC1',
                btnText: '处理',
                hideBtn: false,
                hideAddressIcon: true,
                hideCallIcon: true,
                detailTapAction: () {},
                btnTapAction: () {
                  dealAction();
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 10.0,
              );
            },
            itemCount: 10) : const SCWorkBenchEmptyView(
          emptyIcon: SCAsset.iconEmptyRecord,
          emptyDes: '暂无预警信息',
          scrollPhysics: BouncingScrollPhysics(),
        ));
  }

  /// 预警类型弹窗
  Widget typeAlert() {
    List list = [];
    for (int i = 0; i < widget.state.statusList.length; i++) {
      list.add(widget.state.statusList[i]['name']);
    }
    return Offstage(
      offstage: !showTypeAlert,
      child: SCWarningTypeView(
        index1: widget.state.index1,
        index2: widget.state.index2,
        resetAction: () {
          widget.state.resetAction();
        },
        sureAction: () {},
        onTap1: (int value) {
          widget.state.updateIndex1(value);
        },
        onTap2: (int value) {
          widget.state.updateIndex2(value);
        },
        closeAction: () {
          setState(() {
            showTypeAlert = false;
          });
        },
      ),
    );
  }

  /// 预警等级弹窗
  Widget gradeAlert() {
    return Offstage(
      offstage: !showGradeAlert,
      child: SCSiftAlert(
        title: '预警等级',
        list: typeList,
        selectIndex: selectGrade1,
        closeAction: () {
          setState(() {
            showGradeAlert = false;
          });
        },
        tapAction: (value) {
          if (selectGrade1 != value) {
            setState(() {
              showGradeAlert = false;
              selectGrade1 = value;
              widget.state.siftList[1] = value == 0 ? '预警等级' : typeList[value];
              widget.state.updateType(value == 0
                  ? -1
                  : widget.state.outboundList[value - 1].code ?? -1);
            });
          }
        },
      ),
    );
  }

  /// 预警状态弹窗
  Widget statusAlert() {
    return Offstage(
      offstage: !showStatusAlert,
      child: SCSiftAlert(
        title: '预警状态',
        list: typeList,
        selectIndex: selectStatus1,
        closeAction: () {
          setState(() {
            showStatusAlert = false;
          });
        },
        tapAction: (value) {
          if (selectStatus1 != value) {
            setState(() {
              showStatusAlert = false;
              selectStatus1 = value;
              widget.state.siftList[1] = value == 0 ? '预警状态' : typeList[value];
              widget.state.updateType(value == 0
                  ? -1
                  : widget.state.outboundList[value - 1].code ?? -1);
            });
          }
        },
      ),
    );
  }

  /// 处理
  dealAction() {
      SCUtils.getCurrentContext(completionHandler: (BuildContext context) {
        SCDialogUtils().showCustomBottomDialog(
            isDismissible: true,
            context: context,
            widget: SCRejectAlert(
              title: '处理',
              resultDes: '处理结果',
              reasonDes: '处理说明',
              isRequired: true,
              tagList: const ['节点1', '节点2', '节点3'],
              showNode: true,
              sureAction: (int index, String value, List list) {

              },
            ));
      });
  }

  /// 打电话
  call(String phone) {
    SCUtils.call(phone);
  }

  /// 提交
  submit(int index) {
    SCMaterialEntryModel model = widget.state.dataList[index];
    widget.state.submit(
        id: model.id ?? '',
        completeHandler: (bool success) {
          widget.state.loadData(isMore: false);
        });
  }

  /// 下拉刷新
  Future onRefresh() async {
    widget.state.loadData(
        isMore: false,
        completeHandler: (bool success, bool last) {
          refreshController.refreshCompleted();
          refreshController.loadComplete();
        });
  }

  /// 上拉加载
  void loadMore() async {
    widget.state.loadData(
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
