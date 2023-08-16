import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/Alert/sc_alert_header_view.dart';
import '../../../../../Utils/sc_utils.dart';

/// 首页-时间筛选弹窗

class SCCardTimeFiltrateAlert extends StatefulWidget {
  SCCardTimeFiltrateAlert(
      {Key? key,
        required this.timeList,
        required this.selectTimeTypeList,
        this.resetAction,
        this.sureAction})
      : super(key: key);

  /// 时间数组
  final List timeList;

  /// 选中的任务类型
  final List selectTimeTypeList;

  /// 重置
  final Function? resetAction;

  /// 确定
  final Function(List selectTimeTypeList)? sureAction;

  @override
  SCCardTimeFiltrateAlertState createState() => SCCardTimeFiltrateAlertState();
}

class SCCardTimeFiltrateAlertState extends State<SCCardTimeFiltrateAlert> {

  int columnCount = 3;

  /// 选中的时间筛选类型
  List selectTimeTypeList = [];

  @override
  initState() {
    selectTimeTypeList = widget.selectTimeTypeList;
    super.initState();
  }

  @override
  void didUpdateWidget(SCCardTimeFiltrateAlert oldWidget) {
    selectTimeTypeList = widget.selectTimeTypeList;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    return Container(
      width: double.infinity,
      height: 249.0 + SCUtils().getBottomSafeArea(),
      decoration: const BoxDecoration(
          color: SCColors.color_FFFFFF,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleItem(context),
          const SizedBox(
            height: 12.0,
          ),
          Expanded(child: listView()),
        ],
      ),
    );
  }

  /// title
  Widget titleItem(BuildContext context) {
    return SCAlertHeaderView(
      title: '时间筛选',
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
        itemCount: 1);
  }

  Widget contentItem(int type) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        gridView(type),
      ],
    );
  }

  /// gridView
  Widget gridView(int type) {
    int maxCount = columnCount * 4;
    //ScrollPhysics physics = list.length > maxCount ? const ClampingScrollPhysics() : const NeverScrollableScrollPhysics();
    return StaggeredGridView.countBuilder(
        padding: EdgeInsets.zero,
        mainAxisSpacing: 12.0,
        crossAxisSpacing: 12.0,
        crossAxisCount: columnCount,
        shrinkWrap: true,
        itemCount: widget.timeList.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          String name = widget.timeList[index]["title"] ?? '';
          return cell(name);
        },
        staggeredTileBuilder: (int index) {
          return const StaggeredTile.fit(1);
        });
  }

  /// cell
  Widget cell(String name) {
    bool isSelect = false;
    isSelect = selectTimeTypeList.contains(name);

    /// 背景颜色
    Color bgColor =
    isSelect == true ? SCColors.color_EBF2FF : SCColors.color_F7F8FA;

    /// 边框颜色
    Color borderColor =
    isSelect == true ? SCColors.color_4285F4 : Colors.transparent;

    /// 边框宽度
    double borderWidth = isSelect == true ? 1 : 0;

    /// title字体颜色
    Color textColor =
    isSelect == true ? SCColors.color_0849B5 : SCColors.color_1B1D33;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          if (selectTimeTypeList.contains(name)) {
            selectTimeTypeList.remove(name);
          } else {
            selectTimeTypeList.add(name);
          }
          selectTimeTypeList = [name];
        });
        widget.sureAction?.call(selectTimeTypeList);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        alignment: Alignment.center,
        height: 28.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.0),
            color: bgColor,
            border: Border.all(color: borderColor, width: borderWidth)),
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


}
