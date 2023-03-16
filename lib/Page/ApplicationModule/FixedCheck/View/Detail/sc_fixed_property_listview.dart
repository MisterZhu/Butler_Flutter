import 'package:flutter/material.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/AddMaterial/sc_add_material_empty_view.dart';

import '../../../MaterialEntry/Model/sc_material_list_model.dart';
import 'sc_fixedcheck_material_detail_cell.dart';

/// 资产列表listView

class SCFixedPropertyListView extends StatelessWidget {

  const SCFixedPropertyListView({Key? key, required this.cellType, this.tapAction, required this.list})
      : super(key: key);

  /// cell类型
  final SCFixedCheckMaterialDetailCellType cellType;

  /// cell点击
  final Function(int index)? tapAction;

  /// 数据源
  final List<SCMaterialListModel> list;

  @override
  Widget build(BuildContext context) {
    if (list.isEmpty) {
      return SCAddMaterialEmptyView();
    } else {
      return ListView.separated(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return cell(index);
          },
          separatorBuilder: (BuildContext context, int index) {
            return line();
          },
          itemCount: list.length);
    }
  }

  /// cell
  Widget cell(int index) {
    SCMaterialListModel model = list[index];
    return SCFixedCheckMaterialDetailCell(
      model: model,
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
