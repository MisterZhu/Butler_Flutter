import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialCheck/View/AddCheck/sc_delete_category_cell.dart';

import '../../Model/sc_check_type_model.dart';

/// 分类列表listview

class SCAllCategoryListView extends StatelessWidget {

  const SCAllCategoryListView({Key? key, required this.list, this.deleteAction}) : super(key: key);

  /// 数据源
  final List<SCCheckTypeModel> list;

  /// 删除
  final Function(int index)? deleteAction;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: SCColors.color_FFFFFF,
          borderRadius: BorderRadius.circular(4.0)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [listView()],
      ),
    );
  }

  /// listView
  Widget listView() {
    return ListView.separated(
        padding: const EdgeInsets.only(left: 12.0, right: 0, top: 0, bottom: 0),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return cell(index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return line(index);
        },
        itemCount: list.length);
  }

  /// cell
  Widget cell(int index) {
    SCCheckTypeModel model = list[index];
    return SCDeleteCategoryCell(model: model, onTap: () {
      deleteAction?.call(index);
    },);
  }

  /// line
  Widget line(int index) {
    return const Divider(
      height: 0.5,
      color: SCColors.color_EDEDF0,
    );
  }
}
