import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:sc_uikit/src/constant/sc_cell_type.dart';
import 'package:sc_uikit/src/ui/detail/model/sc_ui_detailcell_model.dart';
import 'package:sc_uikit/src/ui/detail/single/sc_content_cell.dart';
import 'package:sc_uikit/src/ui/detail/single/sc_line_cell.dart';
import 'package:sc_uikit/src/ui/detail/single/sc_remainingtime_cell.dart';
import 'package:sc_uikit/src/ui/detail/single/sc_tag_cell.dart';
import '../single/sc_title_cell.dart';

/// 详情cell
class SCDetailCell extends StatelessWidget {

  /// 数据源
  final List list;

  /// 左侧标题icon点击
  final Function(String value, int index)? leftAction;

  /// 右侧内容icon点击
  final Function(String value, int index)? rightAction;

  /// 点击图片
  final Function(int imageIndex, List list, int index)? imageTap;

  /// 详情
  final Function(int index)? detailAction;

  /// padding
  final EdgeInsetsGeometry? padding;

  const SCDetailCell(
      {Key? key,
        required this.list,
        this.leftAction,
        this.rightAction,
        this.detailAction,
        this.imageTap,
        this.padding})
      : super(key: key); // 信息内容cell

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: SCColors.color_FFFFFF,
          borderRadius: BorderRadius.circular(4.0)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [body(context)],
      ),
    );
  }

  /// body
  Widget body(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: padding ?? const EdgeInsets.symmetric(vertical: 12.0),
        itemBuilder: (BuildContext context, int index) {
          return getCell(index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 12.0,
          );
        },
        itemCount: list.length);
  }

  /// cell
  Widget getCell(int index) {
    SCUIDetailCellModel model = list[index];
    int type = model.type ?? 7;
    if (type == SCCellType.sc_cell_type1) {
      return timeCell(model, index);
    } else if (type == SCCellType.sc_cell_type2) {
      return titleCell(model, index);
    } else if (type == SCCellType.sc_cell_type3) {
      return lineCell(model, index);
    } else if (type == SCCellType.sc_cell_type4) {
      return tagCell(model, index);
    } else if (type == SCCellType.sc_cell_type5) {
      return contentCell(model, index);
    } else if (type == SCCellType.sc_cell_type6) {
      return imageCell(model, index);
    } else if (type == SCCellType.sc_cell_type7) {
      return infoCell(model, index);
    } else {
      return const SizedBox(
        height: 12.0,
      );
    }
  }

  /// 时间cell
  Widget timeCell(SCUIDetailCellModel model, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: SCRemainingTimeCell(
        time: model.time ?? 0,
        title: model.title,
        titleColor: model.titleColor,
        content: model.content,
        contentColor: model.contentColor,
      ),
    );
  }

  /// 标题
  Widget titleCell(SCUIDetailCellModel model, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: SCTitleCell(
        leftIcon: model.leftIcon,
        rightIcon: model.rightIcon,
        title: model.title,
        titleColor: model.titleColor,
        content: model.content,
        contentColor: model.contentColor,
        leftAction: () {
          leftAction?.call(model.subTitle ?? '', index);
        },
        rightAction: () {
          rightAction?.call(model.subContent ?? '', index);
        },
      ),
    );
  }

  /// 线
  Widget lineCell(SCUIDetailCellModel model, int index) {
    return const SCLineCell(
      padding: EdgeInsets.only(left: 16.0),
    );
  }

  /// 标签
  Widget tagCell(SCUIDetailCellModel model, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: SCTagsCell(list: model.tags ?? []),
    );
  }

  /// 内容
  Widget contentCell(SCUIDetailCellModel model, int index) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
        child: SCContentCell(
          content: model.content ?? '',
          maxLength: model.maxLength,
        ));
  }

  /// 图片
  Widget imageCell(SCUIDetailCellModel model, int index) {
    return SCImagesCell(
      list: model.images ?? [],
      contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
      onTap: (int imageIndex, List imageList) {
        imageTap?.call(imageIndex, imageList, index);
      },
    );
  }

  /// 信息
  Widget infoCell(SCUIDetailCellModel model, int index) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        detailAction?.call(index);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: SCTextCell(
          title: model.title,
          titleColor: model.titleColor,
          titleFontSize: model.titleFontSize,
          content: model.content,
          contentColor: model.contentColor,
          contentFontSize: model.contentFontSize,
          leftIcon: model.leftIcon,
          rightIcon: model.rightIcon,
          maxLength: model.maxLength,
          leftAction: () {
            leftAction?.call(model.subTitle ?? '', index);
          },
          rightAction: () {
            rightAction?.call(model.subContent ?? '', index);
          },
        ),
      ),
    );
  }

}
