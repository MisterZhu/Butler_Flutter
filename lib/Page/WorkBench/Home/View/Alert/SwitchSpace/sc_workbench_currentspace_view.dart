import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';

/// 已选择的空间

class SCCurrentSpaceView extends StatelessWidget {
  List<String> list = ['浙江慧享科技信息有限公司', '慧享生活馆', '慧享雅苑1'];

  /// cell高度
  final double cellHeight = 40.0;

  /// circle-大小
  final double circleSize = 10.0;

  /// listView最大行数
  final int maxRow = 4;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 22.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [titleView(), listView()],
      ),
    );
  }

  /// title
  Widget titleView() {
    return const Text(
      '已选择',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: SCFonts.f14,
          fontWeight: FontWeight.w400,
          color: SCColors.color_8D8E9A),
    );
  }

  /// listView
  Widget listView() {
    ScrollPhysics physics;
    if (list.length > maxRow) {
      physics = const BouncingScrollPhysics();
    } else {
      physics = const NeverScrollableScrollPhysics();
    }
    Widget listView = ListView.builder(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: physics,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return cell(index);
        });
    if (list.length > maxRow) {
      return SizedBox(
        height: cellHeight * maxRow,
        child: listView,
      );
    } else {
      return listView;
    }
  }

  /// cell
  Widget cell(int index) {
    return SizedBox(
      height: cellHeight,
      child: Row(
        children: [
          leftCircle(index),
          const SizedBox(
            width: 14.0,
          ),
          rightTitle(index)
        ],
      ),
    );
  }

  /// cell-左侧circle
  Widget leftCircle(int index) {
    Color circleColor;
    Color color1;
    Color color2;
    if (index == 0) {
      color1 = Colors.transparent;
      color2 = SCColors.color_4285F4;
      circleColor = SCColors.color_8EB6F8.withOpacity(0.4);
    } else if (index == list.length - 1) {
      color1 = SCColors.color_4285F4;
      color2 = Colors.transparent;
      circleColor = SCColors.color_4285F4;
    } else {
      color1 = SCColors.color_4285F4;
      color2 = SCColors.color_4285F4;
      circleColor = SCColors.color_4285F4;
    }
    return Column(
      children: [
        Expanded(
            flex: 1,
            child: Container(
              width: 0.5,
              color: color1,
            )),
        Container(
          width: circleSize,
          height: circleSize,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(circleSize / 2.0),
              color: circleColor),
        ),
        Expanded(
            flex: 1,
            child: Container(
              width: 0.5,
              color: color2,
            ))
      ],
    );
  }

  /// cell-右侧title
  Widget rightTitle(int index) {
    Color color = index == 0 ? SCColors.color_5E5F66 : SCColors.color_1B1C33;
    return Text(
      list[index],
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: SCFonts.f16, fontWeight: FontWeight.w400, color: color),
    );
  }
}
