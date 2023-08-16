import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Model/sc_space_model.dart';
import 'package:smartcommunity/Skin/Tools/sc_scaffold_manager.dart';

/// 已选择的空间

class SCCurrentSpaceView extends StatelessWidget {
  SCCurrentSpaceView({
    Key? key,
    required this.list,
    required this.hasNextSpace,
    required this.lastSpaceName,
    required this.currentId,
    this.switchSpaceAction,
    this.selectModel
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

  /// 当前节点id
  final String currentId;

  /// 已选的空间
  final SCSpaceModel? selectModel;

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
    int itemCount = getItemCount();
    ScrollPhysics physics;
    if (itemCount > maxRow) {
      physics = const BouncingScrollPhysics();
    } else {
      physics = const NeverScrollableScrollPhysics();
    }
    Widget listView = ListView.builder(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: physics,
        itemCount: itemCount,
        controller: scrollController,
        itemBuilder: (BuildContext context, int index) {
          return cell(index);
        });
    if (itemCount > maxRow) {
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
        int itemCount = getItemCount();
        if (index == itemCount - 1) {
          if (hasNextSpace == false) {
            switchSpaceAction?.call(index);
          } else {
            bool canTap = isLastCellCanTap(index);
            if (canTap == true) {
              switchSpaceAction?.call(index);
            }
          }
        } else {
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
    int itemCount = getItemCount();
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
    } else if (index == itemCount - 1) {
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
    int itemCount = getItemCount();
    if (index == 0) {
      color = SCColors.color_5E5F66;
      if (list.isNotEmpty) {
        SCSpaceModel model = list[index];
        title = model.title ?? '';
      } else {
        title = SCScaffoldManager.instance.user.tenantName ?? '';
      }
    } else if(index == itemCount - 1) {
      if (currentId.isEmpty) {
        if (selectModel == null) {
          color = SCColors.color_4285F4;
          title = '全部';
        } else {
          SCSpaceModel model = list[index];
          color = SCColors.color_1B1C33;
          title = model.title ?? '';
        }
      } else {
        if (hasNextSpace) {
          color = SCColors.color_4285F4;
          title = '全部';
        } else {
          SCSpaceModel model = list[index];
          color = SCColors.color_1B1C33;
          title = model.title ?? '';
        }
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

  /// listView-count
  int getItemCount() {
    int itemCount;
    if (currentId.isEmpty) {
      if (selectModel == null) {
        if (list.isEmpty) {
          itemCount = 2;
        } else {
          itemCount = list.length + 1;
        }
      } else {
        itemCount = list.length;
      }
    } else {
      if (hasNextSpace) {
        itemCount = list.length + 1;
      } else {
        itemCount = list.length;
      }
    }
    return itemCount;
  }

  /// 滑动到底部
  scrollToBottom() {
    int itemCount = getItemCount();
    SchedulerBinding.instance.addPostFrameCallback((_) { //build完成后的回调
      if (itemCount >= maxRow) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,//滚动到底部
          duration: const Duration(milliseconds: 10),
          curve: Curves.easeOut,
        );
      }
    });
  }

  /// 最后一个cell是否可以点击
  bool isLastCellCanTap(int index) {
    bool status = false;
    if (currentId.isEmpty) {
      if (selectModel == null) {
        status = false;
      } else {
        status = true;
      }
    } else {
      if (hasNextSpace) {
        status = false;
      } else {
        status = true;
      }
    }
    return status;
  }
}
