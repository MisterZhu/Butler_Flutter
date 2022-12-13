import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/Alert/SwitchSpace/sc_workbench_allspace_listview.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/Alert/SwitchSpace/sc_workbench_changespace_header.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/Alert/SwitchSpace/sc_workbench_currentspace_view.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/Alert/SwitchSpace/sc_workbench_searchbar.dart';
import 'package:smartcommunity/utils/sc_utils.dart';

/// 修改空间弹窗

class SCWorkBenchChangeSpaceAlert extends StatelessWidget {
  const SCWorkBenchChangeSpaceAlert({Key? key}) : super(key: key);

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
          searchBar(),
          const SizedBox(
            height: 10.0,
          ),
          currentSpaceView(),
          const SizedBox(
            height: 8.0,
          ),
          line(),
          spaceListView(),
        ],
      ),
    );
  }

  /// header
  Widget headerView() {
    return SCChangeSpaceAlertHeader(
      onCancel: () {},
      onSure: () {},
    );
  }

  /// 搜索栏
  Widget searchBar() {
    return SCChangeSpaceAlertSearchBar(
      onValueChanged: (value) {},
    );
  }

  /// 当前空间
  Widget currentSpaceView() {
    return SCCurrentSpaceView();
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

  /// 空间listView
  Widget spaceListView() {
    return Expanded(child: SCAllSpaceListView());
  }
}
