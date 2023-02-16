import 'package:flutter/cupertino.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/Model/sc_selectcategory_model.dart';

import 'sc_selectcategory_header_cell.dart';

/// 选择分类header

class SCSelectCategoryHeader extends StatefulWidget {

  const SCSelectCategoryHeader({Key? key, required this.list, this.onTap}) : super(key: key);

  /// 数据源
  final List list;

  /// cell点击
  final Function(int index, SCSelectCategoryModel model)? onTap;

  @override
  SCSelectCategoryHeaderState createState() => SCSelectCategoryHeaderState();
}

class SCSelectCategoryHeaderState extends State<SCSelectCategoryHeader> {

  /// 最多展示多少行
  int maxLength = 4;

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    double height = getHeight();
    ScrollPhysics physics = widget.list.length > maxLength ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics();
    return SizedBox(
      height: height,
      child: ListView.separated(
        shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: physics,
          itemBuilder: (BuildContext context, int index) {
        return cell(index);
      }, separatorBuilder: (BuildContext context, int index) {
        return line(index);
      }, itemCount: widget.list.length),
    );
  }

  /// cell
  Widget cell(int index) {
    bool isHiddenTopLine = false;
    bool isHiddenBottomLine = false;

    if (widget.list.length == 1) {
      isHiddenTopLine = true;
      isHiddenBottomLine = true;
    } else {
      if (index == widget.list.length - 1) {
        isHiddenTopLine = false;
        isHiddenBottomLine = true;
      } else if(index == 0){
        isHiddenTopLine = true;
        isHiddenBottomLine = false;
      } else {
        isHiddenTopLine = false;
        isHiddenBottomLine = false;
      }
    }

    return SCSelectCategoryHeaderCell(
      isHiddenTopLine: isHiddenTopLine,
      isHiddenBottomLine: isHiddenBottomLine,
      model: widget.list[index],
      onTap: (SCSelectCategoryModel model) {
        bool enable = model.enable ?? false;
        if (enable) {
          widget.onTap?.call(index, model);
        }
      },
    );
  }

  /// line
  Widget line(int index) {
    return const SizedBox();
  }

  /// 组件高度
  double getHeight() {
    double cellHeight = SCSelectCategoryHeaderCell.getHeight();
    int count = widget.list.length;
    if(count > maxLength) {
      return cellHeight * maxLength;
    } else {
      return cellHeight * count;
    }
  }
}