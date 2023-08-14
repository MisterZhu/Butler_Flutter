import 'dart:developer';

import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/Alert/check_cell_alert.dart';
import 'package:smartcommunity/Page/ApplicationModule/Patrol/Model/sc_patrol_detail_model.dart';
import 'package:smartcommunity/Page/ApplicationModule/Patrol/View/widgets/sc_task_log_page_view.dart';
import '../../../../../Constants/sc_h5.dart';
import '../../../../../Constants/sc_type_define.dart';
import '../../../../../Delegate/sc_sticky_tabbar_delegate.dart';
import '../../../../../Network/sc_config.dart';
import '../../../../../Utils/Router/sc_router_helper.dart';
import '../../../../../Utils/Router/sc_router_path.dart';
import '../../../../../Utils/sc_utils.dart';
import '../../../../WorkBench/Home/Model/sc_todo_model.dart';
import '../../../../WorkBench/Home/View/AppBar/sc_workbench_tabbar.dart';
import '../../../../WorkBench/Other/sc_todo_utils.dart';
import '../../Controller/sc_patrol_detail_controller.dart';
import '../../Model/sc_form_data_model.dart';
import '../widgets/sc_patrol_detail_tabbar.dart';
import 'package:sc_uikit/src/constant/sc_cell_type.dart';

/// 巡查详情view

class SCPatrolDetailV2View extends StatefulWidget {
  /// SCPatrolDetailController
  final SCPatrolDetailController state;

  /// 组件高度
  final double height;


  const SCPatrolDetailV2View({Key? key, required this.state, required this.height}) : super(key: key);

  @override
  SCPatrolDetailV2ViewState createState() => SCPatrolDetailV2ViewState();
}

class SCPatrolDetailV2ViewState extends State<SCPatrolDetailV2View> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin  {

  TabController? tabController;

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    // widget.state.tabBarViewList.replaceRange(0, 1, [checkCell([
    //   SCUIDetailCellModel(type: SCCellType.sc_cell_type7, title: '草地是否有杂草', content: "未查", titleColor: Colors.black, titleFontSize: 16, rightIcon: 'images/common/icon_arrow_right.png', contentFontSize: 14, contentColor: SCColors.color_8D8E99),
    //   SCUIDetailCellModel(type: SCCellType.sc_cell_type3),
    //   SCUIDetailCellModel(type: SCCellType.sc_cell_type7, title: '草地是否有杂草', content: "未查", titleColor: Colors.black, titleFontSize: 16, rightIcon: 'images/common/icon_arrow_right.png', contentFontSize: 14, contentColor: SCColors.color_8D8E99),
    //   SCUIDetailCellModel(type: SCCellType.sc_cell_type3),
    //   SCUIDetailCellModel(type: SCCellType.sc_cell_type7, title: '草地是否有杂草', content: "未查", titleColor: Colors.black, titleFontSize: 16, rightIcon: 'images/common/icon_arrow_right.png', contentFontSize: 14, contentColor: SCColors.color_8D8E99),
    // ])]);

    // widget.state.tabBarViewList.replaceRange(0, 1, [getCell(myType: SCTypeDefine.SC_PATROL_TYPE_CHECK)]);
    // widget.state.tabBarViewList.replaceRange(3, 4, [getCell(myType: SCTypeDefine.SC_PATROL_TYPE_LOG)]);



    // widget.state.tabBarViewList.replaceRange(1, 2, [cell1([
    //   SCUIDetailCellModel(type: SCCellType.sc_cell_type2, title: '编号', content: "UY138947184618164716",  titleFontSize: 14, rightIcon: SCAsset.iconNewCopy, contentFontSize: 14, contentColor: SCColors.color_1B1D33),
    //   SCUIDetailCellModel(type: SCCellType.sc_cell_type2, title: '巡查对象', content: "巡查地点", titleFontSize: 14, contentFontSize: 14, contentColor: SCColors.color_1B1D33),
    //   SCUIDetailCellModel(type: SCCellType.sc_cell_type2, title: '巡查点分类', content: "保洁巡查-大堂卫生", titleFontSize: 14, contentFontSize: 14, contentColor: SCColors.color_1B1D33),
    //   SCUIDetailCellModel(type: SCCellType.sc_cell_type2, title: '来源', content: "计划发起", titleFontSize: 14, contentFontSize: 14, contentColor: SCColors.color_1B1D33),
    //   SCUIDetailCellModel(type: SCCellType.sc_cell_type2, title: '发起时间', content: "2022-12-02 12:00:00", titleFontSize: 14, contentFontSize: 14, contentColor: SCColors.color_1B1D33),
    //
    //   // SCUIDetailCellModel(type: SCCellType.sc_cell_type7, title: '草地是否有杂草', content: "未查", titleColor: Colors.black, titleFontSize: 16, rightIcon: 'images/common/icon_arrow_right.png', contentFontSize: 14, contentColor: SCColors.color_8D8E99),
    // ])]);

    double headerHeight = 44.0;
    double contentHeight = widget.height - headerHeight;
    return ExtendedNestedScrollView(
        controller: ScrollController(),
        onlyOneScrollInBody: true,
        pinnedHeaderSliverHeightBuilder: () {
          return headerHeight;
        },
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[scrollHeader(), stickyTabBar(headerHeight)];
        },
        body: pageView(contentHeight));
    // return ListView.separated(
    //     padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
    //     shrinkWrap: true,
    //     itemBuilder: (BuildContext context, int index) {
    //       return getCell(index: index);
    //     },
    //     separatorBuilder: (BuildContext context, int index) {
    //       return const SizedBox(
    //         height: 10.0,
    //       );
    //     },
    //     itemCount: widget.state.dataList.length);
  }

  Widget scrollHeader() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children:
        // widget.state.dataList.map((e) {
        //   return Text("data");
        // }).toList(),
        [
          SCDetailCell(
            list: widget.state.dataList[0]['data'],
            leftAction: (String value, int index) {},
            rightAction: (String value, int index) {},
            imageTap: (int imageIndex, List imageList, int index) {
              // SCImagePreviewUtils.previewImage(imageList: [imageList[index]]);
            },
          )
        ],
      ).marginAll(12),
    );
  }

  /// tabBar
  Widget stickyTabBar(double height) {
    return SliverPersistentHeader(
        pinned: true,
        floating: false,
        delegate:
        SCStickyTabBarDelegate(child: headerView(height), height: height));
  }

  /// header
  Widget headerView(double height) {
    List tabTitleList = [];
    if (widget.state.tabBarData.containsKey("巡查点任务")) {
      tabTitleList.add("巡查点任务");
    }
    if (widget.state.tabBarData.containsKey("检查项")) {
      tabTitleList.add("检查项");
    }
    if (widget.state.tabBarData.containsKey("详细信息")) {
      tabTitleList.add("详细信息");
    }
    if (widget.state.tabBarData.containsKey("工单")) {
      tabTitleList.add("工单");
    }
    if (widget.state.tabBarData.containsKey("日志")) {
      tabTitleList.add("日志");
    }
    tabController ??= TabController(
        length: widget.state.tabBarData.length, vsync: this);
    return DecoratedBox(
      decoration: const BoxDecoration(color: SCColors.color_F2F3F5),
      child: SizedBox(
        width: double.infinity,
        height: height,
        child: SCPatrolDetailTabBar(
          tabController: tabController!,
          tabTitleList: tabTitleList,
          currentTabIndex: widget.state.currentTabIndex,
        ),
      ),
    );
  }


  /// pageView
  Widget pageView(double height) {
    List<Widget> tabBarViewList = [];
    if (widget.state.tabBarData.containsKey("巡查点任务")) {
      tabBarViewList.add(placeListBody(widget.state.tabBarData['巡查点任务'] as List<PlaceList>));
    }
    if (widget.state.tabBarData.containsKey("检查项")) {
      tabBarViewList.add(getCell(type: SCTypeDefine.SC_PATROL_TYPE_CHECK, list: widget.state.tabBarData['检查项'] as List));
    }
    if (widget.state.tabBarData.containsKey("详细信息")) {
      tabBarViewList.add(getCell(type: SCTypeDefine.SC_PATROL_TYPE_INFO, list: widget.state.tabBarData['详细信息'] as List));
    }
    if (widget.state.tabBarData.containsKey("工单")) {
      tabBarViewList.add(scToDoModelCellListView(widget.state.tabBarData['工单'] as List));
    }
    if (widget.state.tabBarData.containsKey("日志")) {
      tabBarViewList.add(getCell(type: SCTypeDefine.SC_PATROL_TYPE_LOG, list: widget.state.tabBarData['日志'] as List));
    }
    tabController ??= TabController(
          length: widget.state.tabBarData.length, vsync: this);//controller.tabTitleList.length
    Widget tabBarView = SizedBox(
      height: height,
      child:
      TabBarView(controller: tabController, children: tabBarViewList),
    );
    return tabBarView;
  }

  /// cell
  Widget getCell({required int type, required List list}) {
    // int type = widget.state.dataList[index]['type'];
    // List list = widget.state.dataList[index]['data'];
    if (type == SCTypeDefine.SC_PATROL_TYPE_TITLE) {
      return cell1(list);
    } else if (type == SCTypeDefine.SC_PATROL_TYPE_LOG) {
      return SCTaskLogPageView(bizId: widget.state.procInstId);
    } else if (type == SCTypeDefine.SC_PATROL_TYPE_CHECK) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.all(16),
        color: SCColors.color_F2F3F5,
        child: checkCell(list),
      );
    } else if (type == SCTypeDefine.SC_PATROL_TYPE_INFO) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.all(16),
        color: SCColors.color_F2F3F5,
        child: cell1(list),
      );
    } else if (type == SCTypeDefine.SC_PATROL_TYPE_PINGFEN) {
      return cell1(list);
    }  else {
      return const SizedBox();
    }
  }
  // Widget getCell({required int myType}) {
  //   for (int i = 0; i < widget.state.dataList.length; i++) {
  //     int type = widget.state.dataList[i]['type'];
  //     List list = widget.state.dataList[i]['data'];
  //     if (type == SCTypeDefine.SC_PATROL_TYPE_TITLE && myType == type) {
  //       return cell1(list);
  //     } else if (type == SCTypeDefine.SC_PATROL_TYPE_LOG  && myType == type) {
  //       return logCell(list);
  //     } else if (type == SCTypeDefine.SC_PATROL_TYPE_CHECK  && myType == type) {
  //       return checkCell(list);
  //     } else if (type == SCTypeDefine.SC_PATROL_TYPE_INFO && myType == type) {
  //       return cell1(list);
  //     }
  //   }
  //   return const SizedBox();
  //
  // }

  /// cell1
  Widget cell1(List list) {
    return SCDetailCell(
      list: list,
      leftAction: (String value, int index) {},
      rightAction: (String value, int index) {},
      imageTap: (int imageIndex, List imageList, int index) {
        // SCImagePreviewUtils.previewImage(imageList: [imageList[index]]);
      },
    );
  }

  /// 任务日志cell
  Widget logCell(List list) {
    return SCDetailCell(
      list: list,
      leftAction: (String value, int index) {},
      rightAction: (String value, int index) {},
      imageTap: (int imageIndex, List imageList, int index) {
        // SCImagePreviewUtils.previewImage(imageList: [imageList[index]]);
      },
      detailAction: (int subIndex) {
        // 任务日志
        SCRouterHelper.pathPage(
            SCRouterPath.taskLogPage, {'bizId': widget.state.procInstId});
      },
    );
  }

  /// 检查项cell
  Widget checkCell(List list) {
    return SCDetailCell(
      list: list,
      leftAction: (String value, int index) {},
      rightAction: (String value, int index) {},
      imageTap: (int imageIndex, List imageList, int index) {},
      detailAction: (int subIndex) {
        if ((widget.state.model.customStatusInt??0) >= 40) {
          return;
        }
        // if (widget.state.model.isScanCode == false) {// 任务扫码前，不可对检查项进行报事
        //   SCToast.showTip('请先扫码');
        //   return;
        // }
        var checkItem =
        widget.state.model.formData?.checkObject!.checkList![subIndex];
        SCUIDetailCellModel detailCellModel = list[subIndex];
        SCPatrolDetailModel model = widget.state.model;
        if ((checkItem?.evaluateResult ?? '').isEmpty) {
          SCDialogUtils().showCustomBottomDialog(
              isDismissible: true,
              context: context,
              widget: CheckCellAlert(
                title: '检查',
                resultDes: '检查结果',
                reasonDes: '意见',
                isRequired: true,
                checkName: detailCellModel.title ?? '',
                hiddenTags: true,
                sureAction: (int index, String value, List imageList,String type) {
                  widget.state
                      .loadData(checkItem?.id.toString() ?? '', model, imageList,value,type);
                },
              ));
        } else {
          widget.state.loadCheckCellDetailData(widget.state.model,checkItem?.id.toString() ?? '');
        }
        // if (widget.state.model.customStatusInt! >= 40) {//已完成的任务，不能进行报事
        //   return;
        // }
        // if (widget.state.model.isScanCode == false) {// 任务扫码前，不可对检查项进行报事
        //   SCToast.showTip('请先扫码');
        //   return;
        // }
        // SCRouterHelper.pathPage(SCRouterPath.webViewPath, {
        //   "title": '快捷报事',
        //   "url": SCUtils.getWebViewUrl(
        //       url: SCConfig.getH5Url(SCH5.quickReportUrl),
        //       title: '快捷报事',
        //       needJointParams: true)
        // });
      },
    );
  }

  Widget getSCToDoModelCell(SCToDoModel model) {
    bool hideAddressRow = true;
    var cardStyle = SCToDoUtils().getCardStyle(model);
    // title
    String title = model.subTypeDesc ?? '';
    // content
    String content = '${model.title ?? ''}\n${model.content ?? ''}';
    // 按钮文字
    String btnTitle = cardStyle['btnTitle'];
    // 处理状态文字
    String statusTitle = cardStyle['statusTitle'];
    // 处理状态文字颜色
    Color statusColor = cardStyle['statusColor'];
    // 是否显示倒计时
    bool isShowTimer = cardStyle['isShowTimer'];
    // 剩余时间
    int remainingTime = cardStyle['remainingTime'];
    // 创建时间
    String createTime = cardStyle['createTime'];
    // 地址
    String address = model.contactAddress ?? '';
    // 联系人
    String userName = model.contact ?? '';
    // 手机号
    String phone = model.contactInform ?? '';
    return SCTaskCardCell(
      title: title,
      statusTitle: statusTitle,
      statusTitleColor: statusColor,
      content: content,
      tagList: const [],
      address: address,
      contactUserName: userName,
      remainingTime: remainingTime,
      time: createTime,
      timeType: isShowTimer ? 1 : 0,
      btnText: btnTitle,
      hideBtn: btnTitle.isEmpty,
      hideAddressRow: hideAddressRow,
      btnTapAction: () {//卡片button点击
        SCToDoUtils().dealAction(model, btnTitle);
      },
      detailTapAction: () {//整个卡片的点击
        SCToDoUtils().detail(model);
      },
      callAction: () {
        SCUtils.call(phone);
      },
    );
  }

  Widget scToDoModelCellListView(List data) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: const EdgeInsets.all(16),
      color: SCColors.color_F2F3F5,
      child: ListView.separated(
          // padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0, bottom: 12.0),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return getSCToDoModelCell(SCToDoModel.fromJson(data[index]));
          },
          separatorBuilder: (BuildContext context, int index) {
            return line(index);
          },
          itemCount: data.length),
    );
  }

  /// line
  Widget line(int index) {
    return const SizedBox(
      height: 10.0,
    );
  }

  Widget placeListBody(List<PlaceList>? data) {
    return GestureDetector(
      onTap: () {
        // var model = data!=null? data[index]:null;
        // SCRouterHelper.pathPage(SCRouterPath.patrolDetailPage, {"procInstId": model?.tenantId ?? '',"nodeId":  '',"type":"POLICED_WATCH"});
        //detailTapAction?.call();
      },
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
          decoration: BoxDecoration(
              color: SCColors.color_FFFFFF,
              borderRadius: BorderRadius.circular(4.0)
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children:  [
                  const Padding(padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                      child:DecoratedBox(
                        decoration: BoxDecoration(
                            color: SCColors.color_4285F4
                        ),
                        child: SizedBox(
                          width: 2,
                          height: 15,
                        ),
                      )
                  ),
                  Text(
                      data!=null ? ("巡更点") : "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: SCFonts.f16,
                          fontWeight: FontWeight.w500,
                          color: SCColors.color_1B1D33)),

                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                  data!=null ? (data[0].placeName ?? "") : "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: SCFonts.f16,
                      fontWeight: FontWeight.w500,
                      color: SCColors.color_1B1D33)),
              const SizedBox(
                height: 10.0,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                      "巡更方式",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style:  TextStyle(
                          fontSize: SCFonts.f16,
                          fontWeight: FontWeight.w400,
                          color: SCColors.color_8D8E99)),
                  Text(
                      data!=null ? (data[0].execWay ?? "") : "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: SCFonts.f16,
                          fontWeight: FontWeight.w500,
                          color: SCColors.color_1B1D33)),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
            ],
          )
      ),
    );
  }


  @override
  bool get wantKeepAlive => true;
}
