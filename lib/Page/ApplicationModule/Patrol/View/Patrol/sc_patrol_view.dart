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
import '../../../WarningCenter/Other/sc_warning_utils.dart';
import '../../Controller/sc_patrol_controller.dart';

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
          name: '搜索预警编号',
          searchAction: () {
            SCRouterHelper.pathPage(SCRouterPath.searchWarningPage, {});
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
    //SCWarningCenterModel model = widget.state.dataList[index];
    return SCTaskCardCell(
      timeType: 0,
      remainingTime: 0,
      tagList: [],
      time: '2023-4-12 10:12',
      title: '标题',
      titleIcon: SCAsset.iconWarningTypeOrange,
      statusTitle: '处理中',
      statusTitleColor: SCWarningCenterUtils.getStatusColor(1 ?? -1),
      content: '家里大门的智能锁失灵，一时打开一时打不开，有时自动开，请专业人员来查看...',
      contentMaxLines: 30,
      address: '地址',
      btnText: '开始处理',
      hideBtn: false,
      hideAddressIcon: false,
      hideCallIcon: true,
      detailTapAction: () {

      },
      btnTapAction: () {
        dealAction();
      },
    );
  }

  /// 状态弹窗
  Widget statusAlert() {
    List list = [];
    for (int i = 0; i < widget.state.statusList.length; i++) {
      list.add(widget.state.statusList[i]['name']);
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
              widget.state.selectStatusIndex = value;
              widget.state.siftList[0] = value == 0 ? '状态' : widget.state.statusList[value]['name'];
              widget.state.updateStatus(widget.state.statusList[value]['code']);
            });
          }
        },
      ),
    );
  }

  /// 分类弹窗
  Widget typeAlert() {
    return Offstage(
      offstage: !showTypeAlert,
      child: SCSiftAlert(
        title: '分类',
        list: widget.state.typeList,
        selectIndex: widget.state.selectTypeIndex,
        closeAction: () {
          setState(() {
            showTypeAlert = false;
          });
        },
        tapAction: (value) {
          if (widget.state.selectTypeIndex != value) {
            setState(() {
              showTypeAlert = false;
              widget.state.selectTypeIndex = value;
              widget.state.siftList[1] = value == 0 ? '分类' : widget.state.typeList[value];
              widget.state.updateType(value == 0 ? -1 : widget.state.typeList[value - 1].code ?? -1);
            });
          }
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
  dealAction() {

    /// 测试
    SCRouterHelper.pathPage(SCRouterPath.taskLogPage, null);

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
