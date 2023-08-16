import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';

import '../../GetXController/sc_workbench_edit_controller.dart';

/// 编辑工作台page

class SCWorkBenchEditView extends StatefulWidget {

  final SCWorkBenchEditController state;

  const SCWorkBenchEditView({Key? key, required this.state}) : super(key: key);

  @override
  SCWorkBenchEditViewState createState() => SCWorkBenchEditViewState();
}

class SCWorkBenchEditViewState extends State<SCWorkBenchEditView> {

  String _movingValue = ''; // 记录正在移动的值

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return myTaskView();
          } else {
            return otherTaskView();
          }
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox();
        },
        itemCount: 2);
  }

  /// 我的任务
  Widget myTaskView() {
    int rows = 0;
    if (widget.state.myTaskTitleList.length % 3 == 0) {
      rows = widget.state.myTaskTitleList.length ~/ 3;
    } else {
      rows = widget.state.myTaskTitleList.length ~/ 3 + 1;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 6.0),
          child: Text(
            '我的任务',
            style: TextStyle(
                fontSize: SCFonts.f14,
                fontWeight: FontWeight.w400,
                color: SCColors.color_1B1D33),
          ),
        ),
        SizedBox(
          height: 52.0 * rows,
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 0.0,
                crossAxisSpacing: 0.0,
                childAspectRatio: (5 / 2)),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: buildItems(), //禁止滚动
          ),
        )
      ],
    );
  }

  /// 其他任务
  Widget otherTaskView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 6.0),
          child: Text(
            '其他任务',
            style: TextStyle(
                fontSize: SCFonts.f14,
                fontWeight: FontWeight.w400,
                color: SCColors.color_1B1D33),
          ),
        ),
        StaggeredGridView.countBuilder(
            padding: EdgeInsets.zero,
            mainAxisSpacing: 0.0,
            crossAxisSpacing: 0.0,
            crossAxisCount: 3,
            shrinkWrap: true,
            itemCount: widget.state.otherTaskTitleList.length,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return baseItem(widget.state.otherTaskTitleList[index], double.infinity, true,
                  SCAsset.iconEditAppAdd, onTap: () {
                setState(() {
                  String text = widget.state.otherTaskTitleList[index];
                  widget.state.otherTaskTitleList.removeAt(index);
                  widget.state.myTaskTitleList.add(text);
                });
              });
            },
            staggeredTileBuilder: (int index) {
              return const StaggeredTile.fit(1);
            })
      ],
    );
  }

  // 生成GridView的items
  List<Widget> buildItems() {
    List<Widget> items = <Widget>[];
    for (int i = 0; i < widget.state.myTaskTitleList.length; i++) {
      var value = widget.state.myTaskTitleList[i];
      items.add(draggableItem(value, i));
    }
    return items;
  }

  // 生成可拖动的item
  Widget draggableItem(value, index) {
    if (index == 0 || index == 1) {
      return baseItem(value, double.infinity, false, '');
    }
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Draggable(
        data: value,
        feedback: baseItem(value, constraints.maxWidth - 12.0, false, ''),
        childWhenDragging: null,
        onDragStarted: () {
          // print('=== onDragStarted');
          setState(() {
            _movingValue = value;
          });
        },
        onDraggableCanceled: (Velocity velocity, Offset offset) {
          // print('=== onDraggableCanceled');
          setState(() {
            _movingValue = '';
          });
        },
        onDragCompleted: () {
          // print('=== onDragCompleted');
        },
        child: DragTarget(
          builder: (context, candidateData, rejectedData) {
            return baseItem(
                value, double.infinity, true, SCAsset.iconEditAppDelete,
                onTap: () {
              setState(() {
                String text = widget.state.myTaskTitleList[index];
                widget.state.myTaskTitleList.removeAt(index);
                widget.state.otherTaskTitleList.add(text);
              });
            });
          },
          onWillAccept: (moveData) {
            // print('=== onWillAccept: $moveData ==> $value');

            var accept = moveData != null;
            if (accept) {
              exchangeItem(moveData, value, false);
            }
            return accept;
          },
          onAccept: (moveData) {
            // print('=== onAccept: $moveData ==> $value');
            exchangeItem(moveData, value, true);
          },
          onLeave: (moveData) {
            // print('=== onLeave: $moveData ==> $value');
          },
        ),
      );
    });
  }

  // 基础展示的item 此处设置width,height对GridView 无效，主要是偷懒给feedback用
  Widget baseItem(value, width, canEdit, String icon, {Function? onTap}) {
    if (value == _movingValue) {
      return Container();
    }
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
          child: Container(
            width: width,
            height: 40,
            color: SCColors.color_F7F8FA,
            child: Center(
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: SCColors.color_1B1D33),
              ),
            ),
          ),
        ),
        Positioned(
            top: 0,
            right: 0,
            child: Offstage(
                offstage: !canEdit,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    onTap?.call();
                  },
                  child: SCImage(
                    url: icon,
                    width: 18.0,
                    height: 18.0,
                    fit: BoxFit.cover,
                  ),
                )))
      ],
    );
  }

  // 重新排序
  void exchangeItem(moveData, toData, onAccept) {
    // if (moveData == 'OC' ||
    //     moveData == 'Swift' ||
    //     toData == 'OC' ||
    //     toData == 'Swift') {
    //   setState(() {
    //     _movingValue = '';
    //   });
    //   return;
    // }
    // print("moveData===$moveData,toData===$toData,onAccept===$onAccept");
    setState(() {
      var toIndex = widget.state.myTaskTitleList.indexOf(toData);

      widget.state.myTaskTitleList.remove(moveData);
      widget.state.myTaskTitleList.insert(toIndex, moveData);
      // print("最终数据===${myTaskTitle}");
      if (onAccept) {
        _movingValue = '';
      }
    });
  }
}
