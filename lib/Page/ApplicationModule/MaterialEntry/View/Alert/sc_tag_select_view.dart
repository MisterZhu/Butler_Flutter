

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sc_uikit/sc_uikit.dart';

/// 标签选择view

class SCTagSelectView extends StatefulWidget {

  SCTagSelectView({Key? key,
    required this.list,
    required this.currentIndex,
    this.radius = 2.0,
    this.tagHeight = 32.0,
    this.columnCount = 3,
    this.mainSpacing = 8.0,
    this.crossSpacing = 8.0,
    this.topSpacing = 8.0,
    this.tapAction,
  }) : super(key: key);

  /// 数据源
  final List list;

  /// 当前选中的index
  final int currentIndex;

  /// 标签的圆角
  final double radius;

  /// 单个标签的高度
  final double tagHeight;

  /// 每一行有几个
  final int columnCount;

  /// 上下的间距
  final double mainSpacing;

  /// 左右的间距
  final double crossSpacing;

  /// gridview上面的距离
  final double topSpacing;

  final Function(int value)? tapAction;

  @override
  SCTagSelectViewState createState() => SCTagSelectViewState();
}

class SCTagSelectViewState extends State<SCTagSelectView> {

  /// 选中的标签
  List selectList = [];

  /// 默认index
  int currentIndex = 0;

  @override
  initState() {
    super.initState();
    currentIndex = widget.currentIndex;
  }

  @override
  void didUpdateWidget(SCTagSelectView oldWidget) {
    currentIndex = widget.currentIndex;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    return gridView();
  }

  /// gridView
  Widget gridView() {
    int maxCount = widget.columnCount * 8;
    ScrollPhysics physics = widget.list.length > maxCount ? const ClampingScrollPhysics() : const NeverScrollableScrollPhysics();
    Widget gridView = StaggeredGridView.countBuilder(
        padding: EdgeInsets.zero,
        mainAxisSpacing: widget.mainSpacing,
        crossAxisSpacing: widget.crossSpacing,
        crossAxisCount: widget.columnCount,
        shrinkWrap: true,
        itemCount: widget.list.length,
        physics: physics,
        itemBuilder: (context, index) {
          return cell(index);
        },
        staggeredTileBuilder: (int index) {
          return const StaggeredTile.fit(1);
        });

    if (widget.list.length > maxCount) {
      return SizedBox(
        width: double.infinity,
        height: 320.0,
        child: gridView,
      );
    } else {
      return gridView;
    }
  }

  /// cell
  Widget cell(int index) {
    String name = widget.list[index] ?? '';
    bool isSelect = index == currentIndex;
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
        tagAction(index);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        alignment: Alignment.center,
        height: widget.tagHeight,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.radius),
            color: bgColor,
            border: Border.all(color: borderColor, width: borderWidth)
        ),
        child: Text(
          name,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: textColor),
          strutStyle: const StrutStyle(
            fontSize: SCFonts.f14,
            height: 1.25,
            forceStrutHeight: true,
          ),
        ),
      ),
    );
  }

  /// 标签点击
  tagAction(int index) {
    setState(() {
      currentIndex = index;
    });
    widget.tapAction?.call(index);
  }

}