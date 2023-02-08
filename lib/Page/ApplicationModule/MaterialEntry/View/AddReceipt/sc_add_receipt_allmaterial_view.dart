import 'package:flutter/material.dart';
import '../Detail/sc_material_cell.dart';

/// 新增入库-所有物资列表view

class SCAddReceiptAllMaterialView extends StatelessWidget {

  const SCAddReceiptAllMaterialView({Key? key, required this.list}) : super(key: key);

  /// 数据源
  final List list;

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
      onTap: () {

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