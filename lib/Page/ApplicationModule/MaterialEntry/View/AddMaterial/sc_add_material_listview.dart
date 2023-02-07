import 'package:flutter/cupertino.dart';

import '../Detail/sc_material_cell.dart';

/// 新增物资listView

class SCAddMaterialListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 11.0),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return cell(index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return line(index);
        },
        itemCount: 6);
  }

  Widget cell(int index) {
    return SCMaterialCell(
      type: scMaterialCellTypeRadio,
    );
  }

  /// line
  Widget line(int index) {
    return const SizedBox(
      height: 10.0,
    );
  }
}
