import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Model/sc_space_model.dart';

/// 已选择的空间

class SCCurrentSpaceView extends StatelessWidget {
  SCCurrentSpaceView({
    Key? key,
    required this.list,
    required this.hasNextSpace,
    required this.lastSpaceName,
    this.switchSpaceAction
  }) : super(key: key);

  final List<SCSpaceModel> list;

  /// cell高度
  final double cellHeight = 40.0;

  /// circle-大小
  final double circleSize = 10.0;

  /// listView最大行数
  final int maxRow = 4;

  /// 切换空间
  final Function(int index)? switchSpaceAction;

  /// 是否有下一级空间
  final bool hasNextSpace;

  /// 最后一层空间名称
  final String lastSpaceName;

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    scrollToBottom();
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
        itemCount: list.length + 1,
        controller: scrollController,
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
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: (){
        if (index != list.length && index != 0) {
          switchSpaceAction?.call(index);
        }
      },
      child: SizedBox(
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
      ),
    );
  }

  /// cell-左侧circle
  Widget leftCircle(int index) {
    Color circleColor;
    Color color1;
    Color color2;
    Color borderColor;
    double borderWidth;
    if (index == 0) {
      color1 = Colors.transparent;
      color2 = SCColors.color_4285F4;
      circleColor = SCColors.color_EBF2FF;
      borderWidth = 1.0;
      borderColor = SCColors.color_4285F4.withOpacity(0.8);
    } else if (index == list.length) {
      if (hasNextSpace) {
        color1 = SCColors.color_4285F4;
        color2 = Colors.transparent;
        circleColor = SCColors.color_FFFFFF;
        borderWidth = 1.0;
        borderColor = SCColors.color_4285F4;
      } else {
        color1 = SCColors.color_4285F4;
        color2 = Colors.transparent;
        circleColor = SCColors.color_4285F4;
        borderWidth = 1.0;
        borderColor = SCColors.color_4285F4;
      }
    } else {
      color1 = SCColors.color_4285F4;
      color2 = SCColors.color_4285F4;
      circleColor = SCColors.color_4285F4;
      borderWidth = 1.0;
      borderColor = SCColors.color_4285F4;
    }
    return Column(
      children: [
        Expanded(
            flex: 1,
            child: Container(
              width: 1,
              color: color1,
            )),
        Container(
          width: circleSize,
          height: circleSize,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(circleSize / 2.0),
              color: circleColor,
            border: Border.all(color: borderColor, width: borderWidth)
          ),
        ),
        Expanded(
            flex: 1,
            child: Container(
              width: 1,
              color: color2,
            ))
      ],
    );
  }

  /// cell-右侧title
  Widget rightTitle(int index) {
    String title = '';
    Color color;
    if (index == 0) {
      color = SCColors.color_5E5F66;
      SCSpaceModel model = list[index];
      title = model.title ?? '';
    } else if(index == list.length) {
      if (hasNextSpace) {
        color = SCColors.color_4285F4;
        title = '全部';
      } else {
        color = SCColors.color_1B1C33;
        title = lastSpaceName;
      }
    } else {
      color = SCColors.color_1B1C33;
      SCSpaceModel model = list[index];
      title = model.title ?? '';
    }
    return Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: SCFonts.f16, fontWeight: FontWeight.w400, color: color),
    );
  }

  /// 滑动到底部
  scrollToBottom() {
    SchedulerBinding.instance.addPostFrameCallback((_) { //build完成后的回调
      if (list.length >= maxRow) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,//滚动到底部
          duration: const Duration(milliseconds: 10),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
