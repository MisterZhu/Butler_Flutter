import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/WorkBench/Home/View/Alert/sc_alert_header_view.dart';
import 'package:smartcommunity/utils/sc_utils.dart';
import '../../Model/sc_home_task_model.dart';

/// 任务板块弹窗

class SCTaskModuleAlert extends StatefulWidget {
  SCTaskModuleAlert({Key? key,
    required this.title,
    required this.list,
    required this.currentIndex,
    this.radius = 13.0,
    this.tagHeight = 26.0,
    this.columnCount = 4,
    this.mainSpacing = 14.0,
    this.crossSpacing = 8.0,
    this.topSpacing = 17.0,
    this.closeTap,
  }) : super(key: key);

  final String title;
  /// 关闭
  final Function(SCHomeTaskModel model, int index)? closeTap;

  /// 数据源
  final List<SCHomeTaskModel> list;

  /// 最多选几个
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

  @override
  SCTaskModuleAlertState createState() => SCTaskModuleAlertState();
}

class SCTaskModuleAlertState extends State<SCTaskModuleAlert> {

  /// 选中的标签
  List<SCHomeTaskModel> selectList = [];

  /// 默认index
  int normalIndex = 0;

  @override
  initState() {
    super.initState();
    normalIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: SCColors.color_FFFFFF,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0))
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          titleItem(context),
          gridView(),
          Container(
            color: SCColors.color_FFFFFF,
            height: SCUtils().getBottomSafeArea(),
          )
        ],
      ),
    );
  }

  /// title
  Widget titleItem(BuildContext context) {
    return SCAlertHeaderView(
      title: widget.title,
      closeTap: () {
        Navigator.of(context).pop();
      },
    );
  }

  /// gridView
  Widget gridView() {
    int maxCount = widget.columnCount * 8;
    ScrollPhysics physics = widget.list.length > maxCount ? const ClampingScrollPhysics() : const NeverScrollableScrollPhysics();
    Widget gridView = StaggeredGridView.countBuilder(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: widget.topSpacing, bottom: 6.0),
        mainAxisSpacing: widget.mainSpacing,
        crossAxisSpacing: widget.crossSpacing,
        crossAxisCount: widget.columnCount,
        shrinkWrap: true,
        itemCount: widget.list.length,
        physics: physics,
        itemBuilder: (context, index) {
          SCHomeTaskModel model = widget.list[index];
          return cell(model, index);
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
  Widget cell(SCHomeTaskModel model, int index) {
    String name = model.name ?? '';
    bool isSelect = index == normalIndex;
    /// 背景颜色
    Color bgColor = isSelect == true ? SCColors.color_EBF2FF : SCColors.color_EDEDF0;
    /// 边框颜色
    Color borderColor = isSelect == true ? SCColors.color_4285F4 : Colors.transparent;
    /// 边框宽度
    double borderWidth = isSelect == true ? 0.5 : 0;
    /// title字体颜色
    Color textColor = isSelect == true ? SCColors.color_4285F4 : SCColors.color_1B1D33;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        tagAction(model, index);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
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

  /// 标签点击
  tagAction(SCHomeTaskModel model, int index) {
    setState(() {
      normalIndex = index;
    });
    widget.closeTap?.call(model, index);
    Navigator.of(context).pop();
  }
}