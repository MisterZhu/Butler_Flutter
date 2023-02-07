import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/SelectCategoryAlert/sc_selectcategory_footer.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/SelectCategoryAlert/sc_selectcategory_header.dart';

import '../../../../../Utils/sc_utils.dart';
import '../../../../WorkBench/Home/View/Alert/SwitchSpace/sc_workbench_changespace_header.dart';

/// 选择分类弹窗

class SCSelectCategoryAlert extends StatefulWidget {
  @override
  SCSelectCategoryAlertState createState() => SCSelectCategoryAlertState();
}

class SCSelectCategoryAlertState extends State<SCSelectCategoryAlert> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: SCUtils().getScreenHeight() - 130.0,
      padding: EdgeInsets.only(bottom: SCUtils().getBottomSafeArea()),
      decoration: const BoxDecoration(
          color: SCColors.color_FFFFFF,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
      child: Column(
        children: [
          headerView(),
          topView(),
          line(),
          bottomView()
        ],
      ),
    );
  }

  /// header
  Widget headerView() {
    return SCChangeSpaceAlertHeader(
      title: '选择分类',
      onCancel: () {

      },
      onSure: () {

      },
    );
  }

  /// top-已选择的分类
  Widget topView() {
    return SCSelectCategoryHeader(list: ['', '', '', '']);
  }

  /// line
  Widget line() {
    return Padding(padding: const EdgeInsets.only(left: 16.0), child: Container(
      height: 0.5,
      width: double.infinity,
      color: SCColors.color_D9D9D9,
    ),);
  }

  /// bottom-分类列表
  Widget bottomView() {
    return const Expanded(child: SizedBox(
      width: double.infinity,
      child: SCSelectCategoryFooter(list: ['' , '' , '', '', '','' , '' , '', '', '','' , '' , '', '', '']),
    ), );
  }

}