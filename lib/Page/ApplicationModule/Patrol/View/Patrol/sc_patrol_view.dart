import 'dart:convert';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/PageView/sc_workbench_empty_view.dart';
import 'package:smartcommunity/Utils/Community/sc_selectcommunity_utils.dart';
import '../../../../../Constants/sc_asset.dart';
import '../../../../Mine/Home/Model/sc_community_alert_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/MaterialEntry/sc_material_search_item.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/MaterialEntry/sc_material_sift_item.dart';
import '../../../../../Utils/Router/sc_router_helper.dart';
import '../../../../../Utils/Router/sc_router_path.dart';
import '../../../../../Utils/sc_utils.dart';
import '../../../MaterialEntry/View/Alert/sc_sift_alert.dart';
import '../../../MaterialEntry/View/Alert/sc_sort_alert.dart';
import '../../../WarningCenter/Model/sc_warning_dealresult_model.dart';
import '../../../WarningCenter/View/Alert/sc_warningtype_alert.dart';
import '../../Controller/sc_patrol_controller.dart';
import '../../Model/sc_patrol_task_model.dart';
import '../../Other/sc_patrol_utils.dart';

/// 巡查view

class SCPatrolView extends StatefulWidget {
  /// SCPatrolController
  final SCPatrolController state;

  SCPatrolView({Key? key, required this.state}) : super(key: key);

  @override
  SCPatrolViewState createState() => SCPatrolViewState();
}

class SCPatrolViewState extends State<SCPatrolView> {
  bool showStatusAlert = false;

  bool showTypeAlert = false;

  bool showSortAlert = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  dispose() {
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
          name: '搜索任务',
          searchAction: () {
            SCRouterHelper.pathPage(SCRouterPath.searchPatrolPage, {'pageType': widget.state.pageType});
          },
        ),
        siftItem(),
        Expanded(child: contentItem())
      ],
    );
  }

  /// siftItem
  Widget siftItem() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: SCMaterialSiftItem(
          tagList: widget.state.siftList,
          tapAction: (index) {
            if (index == 0) {
              setState(() {
                showTypeAlert = !showTypeAlert;
                showStatusAlert = false;
                showSortAlert = false;
              });
            } else if (index == 1) {
              setState(() {
                showTypeAlert = false;
                showStatusAlert = !showStatusAlert;
                showSortAlert = false;
              });
            } else if (index == 2) {
              setState(() {
                showTypeAlert = false;
                showStatusAlert = false;
                showSortAlert = !showSortAlert;
              });
            }
          },
        ),),
        GestureDetector(
          onTap: () {
            setState(() {
              showTypeAlert = false;
              showStatusAlert = false;
              showSortAlert = false;
            });
            // 点击筛选空间
            selectCommunity();
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            color: SCColors.color_FFFFFF,
            width: 52,
            height: 44.0,
            alignment: Alignment.center,
            child: Image.asset(SCAsset.iconMonitorStatusSift, fit: BoxFit.cover, width: 20.0, height: 20.0,),
          ),
        )
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
          child: statusAlert(),
        ),
        Positioned(
          left: 0.0,
          right: 0.0,
          top: 0.0,
          bottom: 0.0,
          child: sortAlert(),
        ),
      ],
    );
  }

  /// listview
  Widget listview() {
    int count = widget.state.dataList.length;
    Widget item;
    bool isEmpty = false;
    if (widget.state.loadDataSuccess) {
      isEmpty = count > 0 ? false : true;
      item = count > 0
          ? ListView.separated(
          padding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return cell(index);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 10.0,
            );
          },
          itemCount: count)
          : const SCWorkBenchEmptyView(
        emptyIcon: SCAsset.iconEmptyRecord,
        emptyDes: '暂无任务',
        scrollPhysics: BouncingScrollPhysics(),
      );
    } else {
      item = const SizedBox();
    }
    return SmartRefresher(
        controller: widget.state.refreshController,
        enablePullUp: !isEmpty,
        enablePullDown: true,
        header: const SCCustomHeader(
          style: SCCustomHeaderStyle.noNavigation,
        ),
        onRefresh: onRefresh,
        onLoading: loadMore,
        child: item);
  }

  /// cell
  Widget cell(int index) {
    SCPatrolTaskModel model = widget.state.dataList[index];
    String btnText = '处理';
    if ((model.actionVo ?? []).isNotEmpty) {
      btnText = model.actionVo!.first;
    }
    return SCTaskCardCell(
      timeType: 0,
      remainingTime: 0,
      tagList: [],
      time: model.startTime,
      title: model.categoryName ?? '',
      titleIcon: SCAsset.iconPatrolTask,
      statusTitle: model.customStatus ?? '',
      statusTitleColor: SCPatrolUtils.getStatusColor(model.customStatusInt ?? -1),
      content: model.procInstName ?? '',
      contentMaxLines: 30,
      address: '地址',
      btnText: btnText,
      hideBtn: (model.actionVo ?? []).isEmpty,
      hideAddressRow: true,
      hideCallIcon: true,
      detailTapAction: () {
        detailAction(widget.state.dataList[index]);
      },
      btnTapAction: () {
        dealAction(name: btnText, taskId: model.taskId ?? '', procInstId: model.procInstId ?? '', nodeId: model.nodeId ?? '');
      },
    );
  }

  /// 状态弹窗
  Widget statusAlert() {
    List list = [];
    for (int i = 0; i < widget.state.statusList.length; i++) {
      SCWarningDealResultModel statusModel = widget.state.statusList[i];
      list.add(statusModel.name);
    }
    return Offstage(
      offstage: !showStatusAlert,
      child: SCSiftAlert(
        title: '状态',
        list: list,
        selectIndex: widget.state.selectStatusIndex,
        closeAction: () {
          setState(() {
            showStatusAlert = false;
          });
        },
        tapAction: (value) {
          if (widget.state.selectStatusIndex != value) {
            setState(() {
              showStatusAlert = false;
              widget.state.updateStatusIndex(value);
            });
          }
        },
      ),
    );
  }

  /// 分类弹窗
  Widget typeAlert() {
    List list = [];
    for (int i = 0; i < widget.state.typeList.length; i++) {
      SCWarningDealResultModel model = widget.state.typeList[i];
      list.add(model.name);
    }
    return Offstage(
      offstage: !showTypeAlert,
      child: SCWarningTypeView(
        list: widget.state.typeList,
        index1: widget.state.typeIndex1,
        index2: widget.state.typeIndex2,
        resetAction: () {
          widget.state.resetAction();
          setState(() {
            showTypeAlert = false;
          });
        },
        sureAction: (int index1, int index2) {
          widget.state.updateTypeIndex(index1, index2);
          setState(() {
            showTypeAlert = false;
          });
        },
        closeAction: () {
          setState(() {
            showTypeAlert = false;
          });
        },
      ),
    );
  }

  /// 排序弹窗
  Widget sortAlert() {
    return Offstage(
      offstage: !showSortAlert,
      child: SCSortAlert(
        selectIndex: widget.state.selectSortIndex,
        closeAction: () {
          setState(() {
            showSortAlert = false;
          });
        },
        tapAction: (index) {
          if (widget.state.selectSortIndex != index) {
            setState(() {
              showSortAlert = false;
              widget.state.selectSortIndex = index;
              widget.state.updateSort(index == 0 ? true : false);
            });
          }
        },
      ),
    );
  }

  /// 处理
  dealAction({required String name, required String taskId, required String procInstId, required String nodeId}) {
    SCPatrolUtils patrolUtils = SCPatrolUtils();
    patrolUtils.taskId = taskId;
    patrolUtils.procInstId = procInstId;
    patrolUtils.nodeId = nodeId;
    patrolUtils.taskAction(name: name);
  }

  /// 详情
  detailAction(SCPatrolTaskModel model) {
    if(widget.state.pageType==3){
      log('我的数据-------------------------------------此处执行了');
      log('我的数据===${model.formData?.checkObject?.type}');
      if(model.formData?.checkObject?.type == "route"){
        SCRouterHelper.pathPage(SCRouterPath.patrolRoutePage, {"place":model.formData,"procInstId": model.procInstId ?? '', "nodeId": model.nodeId ?? ''});
      }else{
        log('我的数据-------------------------------------此处执行了${model.procInstId??''}  ${model.nodeId??''}');
        SCRouterHelper.pathPage(SCRouterPath.patrolDetailPage, {"procInstId": model.procInstId ?? '', "nodeId": model.nodeId ?? ''});
       // SCRouterHelper.pathPage(SCRouterPath.patrolRoutePage, {"place":model.formData,"procInstId": model.procInstId ?? '', "nodeId": model.nodeId ?? ''});

      }
    }else{
      SCRouterHelper.pathPage(SCRouterPath.patrolDetailPage, {"procInstId": model.procInstId ?? '', "nodeId": model.nodeId ?? ''});
    }
  }

  /// 打电话
  call(String phone) {
    SCUtils.call(phone);
  }

  /// 下拉刷新
  Future onRefresh() async {
    widget.state.loadData(
        isMore: false,
        completeHandler: (bool success, bool last) {
          widget.state.refreshController.refreshCompleted();
          widget.state.refreshController.loadComplete();
        });
  }

  /// 上拉加载
  void loadMore() async {
    widget.state.loadData(
        isMore: true,
        completeHandler: (bool success, bool last) {
          if (last) {
            widget.state.refreshController.loadNoData();
          } else {
            widget.state.refreshController.loadComplete();
          }
        });
  }

  /// 选择项目
  void selectCommunity() {
    SCSelectCommunityUtils.showCommunityAlert(resultHandler: (SCCommunityAlertModel model, int index){
      widget.state.updateCommunityId(model.id ?? '', index);
    }, isShowSelectAll: true, currentIndex: widget.state.currentCommunityIndex);
  }
}
