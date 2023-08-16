import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/Mine/Home/Model/sc_community_common_model.dart';
import 'package:smartcommunity/Page/Mine/Home/View/SelectCommunityAlert/sc_community_alertheader.dart';
import 'package:smartcommunity/Page/Mine/Home/View/SelectCommunityAlert/sc_community_listview.dart';
import 'package:smartcommunity/Page/WorkBench/Home/GetXController/sc_changespace_controller.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Model/sc_space_model.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/Alert/SwitchSpace/sc_workbench_allspace_listview.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/Alert/SwitchSpace/sc_workbench_changespace_header.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/Alert/SwitchSpace/sc_workbench_currentspace_view.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/Alert/SwitchSpace/sc_workbench_searchbar.dart';
import 'package:smartcommunity/utils/sc_utils.dart';

/// 修改项目弹窗

class SCSelectCommunityAlert extends StatelessWidget {
  SCSelectCommunityAlert({
    Key? key,
    required this.list,
    required this.title,
    this.currentIndex,
    this.onSure,
    this.onCancel
  }) : super(key: key);

  /// 数据源-项目列表
  final List<SCCommunityCommonModel> list;

  /// 取消
  final Function? onCancel;

  /// 确定
  final Function(int index)? onSure;

  /// title
  final String title;

  /// currentIndex
  final int? currentIndex;

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
          line(),
          communityListView(),
        ],
      ),
    );
  }

  /// header
  Widget headerView() {
    return SCCommunityAlertHeader(
      title: '选择项目',
      onCancel: () {
        onCancel?.call();
      },
    );
  }

  /// 横线和请选择
  Widget line() {
    return Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Divider(
              height: 0.5,
              color: SCColors.color_D9D9D9,
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(
              '请选择',
              style: TextStyle(
                  fontSize: SCFonts.f14,
                  fontWeight: FontWeight.w400,
                  color: SCColors.color_8D8E9A),
            )
          ],
        ));
  }

  /// 项目listView
  Widget communityListView() {
    return Expanded(child: SCCommunityListView(currentIndex: currentIndex ,list: list, onTap: (int index) {
      onSure?.call(index);
    },)
    );
  }
}
