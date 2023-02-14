import 'package:flutter/material.dart';
import '../../Model/sc_material_list_model.dart';
import '../Detail/sc_material_cell.dart';

/// 新增入库-所有物资列表view

class SCAddEntryAllMaterialView extends StatelessWidget {

  const SCAddEntryAllMaterialView({Key? key, required this.list, this.deleteAction}) : super(key: key);

  /// 数据源
  final List<SCMaterialListModel> list;

  /// 删除物资
  final Function(int index)? deleteAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: allMaterialList(),
    );
  }

  /// 所有物资列表
  List<Widget> allMaterialList() {
    List<Widget> itemList = [];
    for (int i=0; i<list.length; i++) {
      itemList.add(cell(i));
      if (i != list.length - 1) {
        itemList.add(line());
      }
    }
    return itemList;
  }

  /// cell
  Widget cell(int index) {
    return SCMaterialCell(
      type: scMaterialCellTypeDelete,
      model: list[index],
      onTap: () {

      },
      deleteAction: () {
        deleteAction?.call(index);
      },
    );
  }

  /// line
  Widget line() {
    return const SizedBox(
      height: 10.0,
    );
  }
}