import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/WorkBench/Home/GetXController/sc_changespace_controller.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Model/sc_space_model.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/Alert/SwitchSpace/sc_workbench_allspace_listview.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/Alert/SwitchSpace/sc_workbench_changespace_header.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/Alert/SwitchSpace/sc_workbench_currentspace_view.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/Alert/SwitchSpace/sc_workbench_searchbar.dart';
import 'package:smartcommunity/utils/sc_utils.dart';

/// 修改空间弹窗

class SCWorkBenchChangeSpaceAlert extends StatelessWidget {
  SCWorkBenchChangeSpaceAlert({
    Key? key,
    required this.selectList,
    required this.changeSpaceController,
    this.onSure,
    this.onCancel
  }) : super(key: key);

  /// 数据源-已选择的空间
  final List<SCSpaceModel> selectList;

  /// 切换空间controller
  final SCChangeSpaceController changeSpaceController;

  /// 取消
  final Function? onCancel;

  /// 确定
  final Function? onSure;

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
      onCancel: () {
        onCancel?.call();
      },
      onSure: () {
        onSure?.call();
      },
    );
  }

  /// 搜索栏
  Widget searchBar() {
    return SCChangeSpaceAlertSearchBar(
      onValueChanged: (value) {},
    );
  }

  /// 当前已选择的空间
  Widget currentSpaceView() {
    return SCCurrentSpaceView(
      list: selectList,
      currentId: changeSpaceController.currentId,
      hasNextSpace: changeSpaceController.hasNextSpace,
      lastSpaceName: changeSpaceController.spaceModel?.title ?? '',
      selectModel: changeSpaceController.spaceModel,
      switchSpaceAction: (int index){
        changeSpaceController.selectSpace(index);
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

  /// 空间listView
  Widget spaceListView() {
    List<SCSpaceModel> list = [];
    if (changeSpaceController.hasNextSpace == false && changeSpaceController.spaceModel != null && changeSpaceController.dataList.isEmpty) {
      list = [changeSpaceController.spaceModel!];
    } else {
      list = changeSpaceController.dataList;
    }
    return Expanded(child: SCAllSpaceListView(
      list: list,
      hasNextSpace: changeSpaceController.hasNextSpace,
      selectModel: changeSpaceController.spaceModel,
      onTap: (int index, SCSpaceModel subModel){
        changeSpaceController.updateCurrentSpace(subModel.id ?? '', subModel.flag ?? 0, true);
        changeSpaceController.updateSelectData(subModel);
        changeSpaceController.loadManageTreeData();
      },
    ));
  }
}
