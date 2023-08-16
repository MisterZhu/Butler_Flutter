import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/src/constant/sc_cell_type.dart';
import 'package:sc_uikit/src/ui/detail/model/sc_ui_detailcell_model.dart';
import 'package:sc_uikit/src/ui/detail/single/sc_fold_title_cell.dart';
import 'package:sc_uikit/src/ui/text/sc_text_cell.dart';

/// cell-折叠组样式

class SCFoldSectionCell extends StatelessWidget {
  /// 数据源
  final List list;

  /// 左侧icon点击
  final Function(String value, int index)? leftAction;

  /// 右侧icon点击
  final Function(String value, int index)? rightAction;

  /// 折叠
  final bool fold;

  const SCFoldSectionCell(
      {Key? key,
      required this.list,
      required this.fold,
      this.leftAction,
      this.rightAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [listView()],
    );
  }

  /// listView
  Widget listView() {
    return ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return getCell(index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return line(index);
        },
        itemCount: fold ? 1 : list.length);
  }

  /// cell
  Widget getCell(int index) {
    SCUIDetailCellModel model = list[index];
    int type = model.type ?? 7;
    if (type == SCCellType.sc_cell_type7) {
      // 信息cell
      return infoCell(model, index);
    } else if (type == SCCellType.sc_cell_type9) {
      // 展开折叠cell
      return foldTitleCell(model, index);
    } else {
      return const SizedBox(
        height: 12.0,
      );
    }
  }

  /// 展开折叠cell
  Widget foldTitleCell(SCUIDetailCellModel model, int index) {
    String title = model.title ?? '';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: SCFoldTitleCell(
        title: title,
        fold: fold,
      ),
    );
  }

  /// 信息cell
  Widget infoCell(SCUIDetailCellModel model, int index) {
    return Padding(
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
    );
  }

  /// line
  Widget line(int index) {
    return SizedBox(
      height: index == list.length - 1 ? 0 : 12.0,
    );
  }
}
