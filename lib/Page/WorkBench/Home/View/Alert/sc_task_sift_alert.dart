

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/Alert/sc_alert_header_view.dart';

import '../../../../../Utils/sc_utils.dart';

/// 首页-任务筛选弹窗

class SCTaskSiftAlert extends StatefulWidget {

  SCTaskSiftAlert({Key? key,
    required this.myTaskList,
    required this.taskTypeList,
    required this.selectTaskList,
    required this.selectTypeList,
    this.resetAction,
    this.sureAction,
  }) : super(key: key);

  /// 我的任务数组
  final List myTaskList;

  /// 任务类型数组
  final List taskTypeList;

  /// 选中的任务
  final List selectTaskList;

  /// 选中的任务类型
  final List selectTypeList;

  /// 重置
  final Function? resetAction;

  /// 确定
  final Function(List list1, List list2)? sureAction;

  @override
  SCTaskSiftAlertState createState() => SCTaskSiftAlertState();
}

class SCTaskSiftAlertState extends State<SCTaskSiftAlert> {

  /// 选中的任务
  List selectList1 = [];

  /// 选中的任务
  List selectList2 = [];

  int columnCount = 3;

  @override
  initState() {
    super.initState();
    selectList1 = widget.selectTaskList;
    selectList2 = widget.selectTypeList;

  }

  @override
  void didUpdateWidget(SCTaskSiftAlert oldWidget) {
    selectList1 = widget.selectTaskList;
    selectList2 = widget.selectTypeList;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    return Container(
      width: double.infinity,
      height: 378.0 + SCUtils().getBottomSafeArea(),
      decoration: const BoxDecoration(
          color: SCColors.color_FFFFFF,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleItem(context),
          const SizedBox(height: 12.0,),
          Expanded(child: listView()),
          bottomItem(),
        ],
      ),
    );
  }

  /// title
  Widget titleItem(BuildContext context) {
    return SCAlertHeaderView(
      title: '筛选',
      closeTap: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget listView() {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return contentItem(index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 4.0);
        },
        itemCount: 2);
  }


  Widget contentItem(int type) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle(type),
        const SizedBox(height: 8.0,),
        gridView(type),
      ],
    );
  }

  Widget sectionTitle(int index) {
    return Text(
        index == 0 ? '我的任务' : '任务类型',
        textAlign: TextAlign.left,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
        fontSize: SCFonts.f14,
        fontWeight: FontWeight.w400,
        color: SCColors.color_5E5F66),
    );
  }
  /// gridView
  Widget gridView(int type) {
    List list = type == 0 ? widget.myTaskList : widget.taskTypeList;
    int maxCount = columnCount * 4;
    //ScrollPhysics physics = list.length > maxCount ? const ClampingScrollPhysics() : const NeverScrollableScrollPhysics();
    return StaggeredGridView.countBuilder(
        padding: EdgeInsets.zero,
        mainAxisSpacing: 12.0,
        crossAxisSpacing: 12.0,
        crossAxisCount: columnCount,
        shrinkWrap: true,
        itemCount: list.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          String name = list[index] ?? '';
          return cell(type, name);
        },
        staggeredTileBuilder: (int index) {
          return const StaggeredTile.fit(1);
        });
  }

  /// cell
  Widget cell(int type, String name) {
    bool isSelect = false;
    if (type == 0) {
      isSelect = selectList1.contains(name);
    } else if (type == 1) {
      isSelect = selectList2.contains(name);
    }
    /// 背景颜色
    Color bgColor = isSelect == true ? SCColors.color_EBF2FF : SCColors.color_F7F8FA;
    /// 边框颜色
    Color borderColor = isSelect == true ? SCColors.color_4285F4 : Colors.transparent;
    /// 边框宽度
    double borderWidth = isSelect == true ? 1 : 0;
    /// title字体颜色
    Color textColor = isSelect == true ? SCColors.color_0849B5 : SCColors.color_1B1D33;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          if (type == 0) {
            // if (selectList1.contains(name)) {
            //   selectList1.remove(name);
            // } else {
            //   selectList1.add(name);
            // }
            selectList1 = [name];
          } else if (type == 1) {
            // if (selectList2.contains(name)) {
            //   selectList2.remove(name);
            // } else {
            //   selectList2.add(name);
            // }
            selectList2 = [name];
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        alignment: Alignment.center,
        height: 28.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.0),
            color: bgColor,
            border: Border.all(color: borderColor, width: borderWidth)
        ),
        child: Text(
          name,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: SCFonts.f12,
              fontWeight: FontWeight.w400,
              color: textColor),
          strutStyle: const StrutStyle(
            fontSize: SCFonts.f12,
            height: 1.25,
            forceStrutHeight: true,
          ),
        ),
      ),
    );
  }

  Widget bottomItem() {
    return Container(
      width: double.infinity,
      alignment: Alignment.topLeft,
      height: 54.0 + MediaQuery.of(context).padding.bottom,
      color: SCColors.color_FFFFFF,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          resetButtonItem(),
          const SizedBox(width: 8.0,),
          Expanded(child: sureButtonItem()),
        ],
      ),
    );
  }

  /// 重置按钮
  Widget resetButtonItem() {
    return Container(
        width: 80.0,
        height: 40.0,
        decoration: BoxDecoration(
            color: SCColors.color_F5F5F5,
            borderRadius: BorderRadius.circular(4.0),
        ),
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Text(
            '重置',
            style: TextStyle(
              fontSize: SCFonts.f16,
              fontWeight: FontWeight.w400,
              color: SCColors.color_1B1D33,),
          ),
          onPressed: () {
            widget.resetAction?.call();
          },
        )
    );
  }

  /// 确定按钮
  Widget sureButtonItem() {
    return Container(
        width: double.infinity,
        height: 40.0,
        decoration: BoxDecoration(
            color: SCColors.color_4285F4,
            borderRadius: BorderRadius.circular(4.0)),
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Text(
            '确定',
            style: TextStyle(
              fontSize: SCFonts.f16,
              fontWeight: FontWeight.w400,
              color: SCColors.color_FFFFFF,),
          ),
          onPressed: () {
            widget.sureAction?.call(selectList1, selectList2);
          },
        )
    );
  }


}