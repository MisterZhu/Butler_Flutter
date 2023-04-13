
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/WarningCenter/View/Detail/sc_warning_detail_dealDetail_view.dart';
import 'package:smartcommunity/Page/ApplicationModule/WarningCenter/View/Detail/sc_warning_detail_spaceInfo_view.dart';
import 'package:smartcommunity/Page/ApplicationModule/WarningCenter/View/Detail/sc_warning_detail_warnDetail_view.dart';
import '../../Controller/sc_warning_detail_controller.dart';

/// 预警详情-middleView
class SCWarningDetailMiddleView extends StatelessWidget {

  /// SCWarningDetailController
  final SCWarningDetailController state;

  final TabController tabController;

  SCWarningDetailMiddleView({Key? key, required this.state, required this.tabController}): super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: SCColors.color_F2F3F5,
          borderRadius: BorderRadius.circular(4.0)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          topItem(),
          lineItem(),
          Expanded(child: TabBarView(
            controller: tabController,
            children: [
              SCWarningDetailWarnDetailView(state: state),
              SCWarningDetailSpaceInfoView(state: state),
              SCWarningDetailDealDetailView(state: state),
            ]
          ))
        ]
      )
    );
  }

  /// topItem
  Widget topItem() {
    List titleList = ['预警明细', '空间信息', '处理明细'];
    List<Tab> tabItemList = [];
    for (String title in titleList) {
      tabItemList.add(Tab(text: title,));
    }
    return Container(
      decoration: BoxDecoration(
          color: SCColors.color_FFFFFF,
          borderRadius: BorderRadius.circular(4.0)),
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      width: double.infinity,
      height: 44.0,
      child: PreferredSize(
          preferredSize: Size.fromHeight(44.0),
          child: Material(
            color: Colors.transparent,
            child: Theme(
                data: ThemeData(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent),
                child: TabBar(
                    controller: tabController,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                    isScrollable: true, //为false时不能滚动，标题会平分宽度显示，为true时会紧凑排列
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: SCColors.color_4285F4,
                    unselectedLabelColor: SCColors.color_5E5E66,
                    labelColor: SCColors.color_1B1D33,
                    indicatorWeight: 2.0,
                    labelStyle:
                    const TextStyle(fontSize: SCFonts.f14, fontWeight: FontWeight.w500),
                    unselectedLabelStyle: const TextStyle(
                        fontSize: SCFonts.f14, fontWeight: FontWeight.w400),
                    tabs: tabItemList
                )),
          )),
    );
  }

  /// lineItem
  Widget lineItem() {
    return Container(
      height: 0.5,
      color: SCColors.color_EDEDF0,
    );
  }

}
