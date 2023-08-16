

import 'package:flutter/material.dart';
import 'package:smartcommunity/Page/ApplicationModule/WarningCenter/View/Detail/sc_warning_detail_middle_view.dart';
import 'package:smartcommunity/Page/ApplicationModule/WarningCenter/View/Detail/sc_warning_detail_top_view.dart';
import '../../Controller/sc_warning_detail_controller.dart';

/// 预警详情-view
class SCWarningDetailView extends StatelessWidget {

  /// SCWarningDetailController
  final SCWarningDetailController state;
  final TabController tabController;
  SCWarningDetailView({Key? key, required this.state, required this.tabController}): super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SCWarningDetailTopView(state: state,),
          const SizedBox(height: 10.0,),
          Expanded(child: SCWarningDetailMiddleView(state: state, tabController: tabController,)),
        ],
      ),
    );
  }

}