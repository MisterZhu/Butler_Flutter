import 'package:flutter/material.dart';

import 'sc_fixedcheck_material_detail_cell.dart';

/// 资产列表listView

class SCFixedPropertyListView extends StatelessWidget {

  const SCFixedPropertyListView({Key? key, required this.cellType, this.tapAction})
      : super(key: key);

  /// cell类型
  final SCFixedCheckMaterialDetailCellType cellType;

  /// cell点击
  final Function(int index)? tapAction;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return cell(index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return line();
        },
        itemCount: 30);
  }

  /// cell
  Widget cell(int index) {
    return SCFixedCheckMaterialDetailCell(
      cellType: cellType,
      btnTapAction: () {
        tapAction?.call(index);
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
