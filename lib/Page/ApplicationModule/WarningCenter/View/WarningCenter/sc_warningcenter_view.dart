import 'package:flutter/widgets.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/PageView/sc_workbench_empty_view.dart';
import '../../../../../Constants/sc_asset.dart';
import '../../../MaterialEntry/View/Alert/sc_reject_alert.dart';
import '../../Controller/sc_warningcenter_controller.dart';
import '../../Model/sc_warning_dealresult_model.dart';
import '../../Model/sc_warningcenter_model.dart';
import '../Alert/sc_warningtype_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/MaterialEntry/sc_material_search_item.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/MaterialEntry/sc_material_sift_item.dart';
import '../../../../../Constants/sc_enum.dart';
import '../../../../../Utils/Router/sc_router_helper.dart';
import '../../../../../Utils/Router/sc_router_path.dart';
import '../../../../../Utils/sc_utils.dart';
import '../../../MaterialEntry/View/Alert/sc_sift_alert.dart';

/// 预警中心view

class SCWarningCenterView extends StatefulWidget {
  /// SCWarningCenterController
  final SCWarningCenterController state;

  SCWarningCenterView({Key? key, required this.state}) : super(key: key);

  @override
  SCWarningCenterViewState createState() => SCWarningCenterViewState();
}

class SCWarningCenterViewState extends State<SCWarningCenterView> {

  bool showTypeAlert = false;

  bool showGradeAlert = false;

  bool showStatusAlert = false;

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
        ),),
        GestureDetector(
          onTap: () {
            setState(() {
              showTypeAlert = false;
              showGradeAlert = false;
              showStatusAlert = false;
            });
            // 点击筛选空间
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
              emptyDes: '暂无预警信息',
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
    SCWarningCenterModel model = widget.state.dataList[index];
    return SCTaskCardCell(
      timeType: 0,
      remainingTime: 0,
      tagList: [model.levelName ?? ''],
      tagBGColorList: [widget.state.getLevelBGColor(model.levelId ?? 0)],
      tagTextColorList: [widget.state.getLevelTextColor(model.levelId ?? 0)],
      time: model.generationTime,
      title: model.ruleName,
      titleIcon: SCAsset.iconWarningTypeOrange,
      statusTitle: model.statusName,
      statusTitleColor:
      widget.state.getStatusColor(model.status ?? -1),
      content: model.alertContext,
      contentMaxLines: 30,
      address: '预警编号：${model.alertCode}',
      btnText: '处理',
      hideBtn: (model.status ?? -1) == 3,
      hideAddressIcon: true,
      hideCallIcon: true,
      detailTapAction: () {
        SCRouterHelper.pathPage(SCRouterPath.warningDetailPage, {'id': (model.id ?? 0).toString()});
      },
      btnTapAction: () {
        dealAction(model);
      },
    );
  }

  /// 预警类型弹窗
  Widget typeAlert() {
    List list = [];
    for (int i = 0; i < widget.state.warningTypeList.length; i++) {
      SCWarningDealResultModel model = widget.state.warningTypeList[i];
      list.add(model.name);
    }
    return Offstage(
      offstage: !showTypeAlert,
      child: SCWarningTypeView(
        list: widget.state.warningTypeList,
        index1: widget.state.warningTypeIndex1,
        index2: widget.state.warningTypeIndex2,
        resetAction: () {
          widget.state.resetAction();
          setState(() {
            showTypeAlert = false;
          });
        },
        sureAction: (int index1, int index2) {
          widget.state.updateWarningTypeIndex(index1, index2);
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

  /// 预警等级弹窗
  Widget gradeAlert() {
    List list = [];
    for (int i = 0; i < widget.state.warningGradeList.length; i++) {
      SCWarningDealResultModel model = widget.state.warningGradeList[i];
      list.add(model.name);
    }
    return Offstage(
      offstage: !showGradeAlert,
      child: SCSiftAlert(
        title: '预警等级',
        list: list,
        selectIndex: widget.state.warningGradeIndex,
        closeAction: () {
          setState(() {
            showGradeAlert = false;
          });
        },
        tapAction: (value) {
          if (widget.state.warningGradeIndex != value) {
            setState(() {
              showGradeAlert = false;
              widget.state.updateWarningGradeIndex(value);
            });
          }
        },
      ),
    );
  }

  /// 预警状态弹窗
  Widget statusAlert() {
    List list = [];
    for (int i = 0; i < widget.state.warningStatusList.length; i++) {
      SCWarningDealResultModel model = widget.state.warningStatusList[i];
      list.add(model.name);
    }
    return Offstage(
      offstage: !showStatusAlert,
      child: SCSiftAlert(
        title: '预警状态',
        list: list,
        selectIndex: widget.state.warningStatusIndex,
        closeAction: () {
          setState(() {
            showStatusAlert = false;
          });
        },
        tapAction: (value) {
          if (widget.state.warningStatusIndex != value) {
            setState(() {
              showStatusAlert = false;
              widget.state.updateWarningStatusIndex(value);
            });
          }
        },
      ),
    );
  }

  /// 处理
  dealAction(SCWarningCenterModel centerModel) {
    widget.state.loadDictionaryCode(centerModel.alertType ?? '' ,(success, list) {
      if (success) {
        List<String> tagList = [];
        for (SCWarningDealResultModel model in list) {
          tagList.add(model.name ?? '');
        }
        SCUtils.getCurrentContext(completionHandler: (BuildContext context) {
          SCDialogUtils().showCustomBottomDialog(
              isDismissible: true,
              context: context,
              widget: SCRejectAlert(
                title: '处理',
                resultDes: '处理结果',
                reasonDes: '处理说明',
                isRequired: true,
                tagList: tagList,
                hiddenTags: true,
                showNode: true,
                sureAction: (int index, String value, List imageList) {
                  SCWarningDealResultModel model = list[index];
                  widget.state.deal(value, int.parse(model.code ?? '0'),
                      centerModel.id ?? 0, imageList, centerModel.status ?? 0);
                },
              ));
        });
      }
    });
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
}
