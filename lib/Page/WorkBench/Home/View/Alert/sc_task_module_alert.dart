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
    required this.list,
    this.closeTap,
  }) : super(key: key);

  /// 关闭
  final Function(List selectList)? closeTap;

  /// 数据源
  final List<SCHomeTaskModel> list;

  @override
  SCTaskModuleAlertState createState() => SCTaskModuleAlertState();
}

class SCTaskModuleAlertState extends State<SCTaskModuleAlert> {

  /// 选中的标签
  List<SCHomeTaskModel> selectList = [];

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: SCColors.color_FFFFFF,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0))
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
      title: '任务板块',
      closeTap: () {
        Navigator.of(context).pop();
        widget.closeTap?.call(selectList);
      },
    );
  }

  /// gridView
  Widget gridView() {
    int maxCount = 4 * 8;
    ScrollPhysics physics = widget.list.length > maxCount ? const ClampingScrollPhysics() : const NeverScrollableScrollPhysics();
    Widget gridView = StaggeredGridView.countBuilder(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 17.0, bottom: 18.0),
        mainAxisSpacing: 14.0,
        crossAxisSpacing: 8.0,
        crossAxisCount: 4,
        shrinkWrap: true,
        itemCount: widget.list.length,
        physics: physics,
        itemBuilder: (context, index) {
          SCHomeTaskModel model = widget.list[index];
          return cell(model);
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
  Widget cell(SCHomeTaskModel model) {
    String name = model.name ?? '';
    bool isSelect = model.isSelect ?? false;
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
        tagAction(model);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
        alignment: Alignment.center,
        height: 26.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13.0),
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
            color: textColor
        ),),
      ),
    );
  }

  /// 标签点击
  tagAction(SCHomeTaskModel model) {
    bool isSelect = model.isSelect ?? false;
    if (isSelect) {
        selectList.removeWhere((element) {
          String? id = element.id;
          if (id == model.id) {
            return true;
          }
          return false;
        });
    } else {
        selectList.add(model);
    }
    setState(() {
      model.isSelect = !isSelect;
    });
  }
}