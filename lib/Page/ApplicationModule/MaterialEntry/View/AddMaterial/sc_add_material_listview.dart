import 'package:flutter/cupertino.dart';

import '../../Controller/sc_add_material_controller.dart';
import '../../Model/sc_material_list_model.dart';
import '../Detail/sc_material_cell.dart';

/// 新增物资listView

class SCAddMaterialListView extends StatelessWidget {

  SCAddMaterialListView({Key? key, required this.list, this.radioTap}) : super(key: key);

  /// list
  final List<SCMaterialListModel> list;

  /// radio点击
  final Function? radioTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 11.0),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          SCMaterialListModel model = list[index];
          return cell(model);
        },
        separatorBuilder: (BuildContext context, int index) {
          return line(index);
        },
        itemCount: list.length);
  }

  Widget cell(SCMaterialListModel model) {
    return SCMaterialCell(
      model: model,
      type: scMaterialCellTypeRadio,
      numChangeAction: (int value) {
        model.localNum = value;
      },
      radioTap: (bool value) {
        model.isSelect = value;
        radioTap?.call();
      },
    );
  }

  /// line
  Widget line(int index) {
    return const SizedBox(
      height: 10.0,
    );
  }
}
