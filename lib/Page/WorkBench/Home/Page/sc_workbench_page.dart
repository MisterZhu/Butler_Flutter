import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/WorkBench/sc_workbench_view.dart';

import '../../../../Utils/sc_utils.dart';
import '../Model/sc_home_task_model.dart';
import '../View/Alert/sc_task_module_alert.dart';

/// 工作台-page

class SCWorkBenchPage extends StatefulWidget {
  @override
  SCWorkBenchPageState createState() => SCWorkBenchPageState();
}

class SCWorkBenchPageState extends State<SCWorkBenchPage> with SingleTickerProviderStateMixin {

  /// tab-title
  List<String> tabTitleList = ['待办', '处理中'];

  /// 分类
  List<String> classificationList = ['工单处理', '订单处理', '居民审核', '维保维修', '三巡一保', '报事报修', '工单处理'];

  /// tabController
  late TabController tabController;

  @override
  initState() {
    super.initState();
    tabController =
        TabController(length: tabTitleList.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SCColors.color_FFFFFF,
      body: body(),
    );
  }

  /// body
  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: SCColors.color_F2F3F5,
      child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
        return SCWorkBenchView(
          height: constraints.maxHeight,
          tabTitleList: tabTitleList,
          classificationList: classificationList,
          tabController: tabController,
          menuTap: () {
            showTaskAlert();
          },
        );
      }),
    );
  }

  /// 弹出任务模块弹窗
  showTaskAlert() {
    List testList = [
      {'id': '0','name': '全部','isSelect': false},
      {'id': '1','name': '工单处理','isSelect': false},
      {'id': '2','name': '居民审核','isSelect': false},
      {'id': '3','name': '维保任务','isSelect': false},
      {'id': '4','name': '巡检任务','isSelect': false},
      {'id': '5','name': '巡查任务','isSelect': false},
      {'id': '6','name': '巡更任务','isSelect': false},
      {'id': '7','name': '装修审核','isSelect': false},
      {'id': '8','name': '资产审核','isSelect': false},
    ];
    List<SCHomeTaskModel> list = testList.map((e) => SCHomeTaskModel.fromJson(e)).toList();
    SCUtils.getCurrentContext(completionHandler: (BuildContext context) {
      SCDialogUtils().showCustomBottomDialog(
          context: context,
          widget: SCTaskModuleAlert(
            list: list,
            closeTap: (selectList) {
            },
          ));
    });
  }

}