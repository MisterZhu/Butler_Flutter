import 'package:flutter/cupertino.dart';

import '../../Controller/sc_add_material_controller.dart';
import '../../Model/sc_material_list_model.dart';
import '../Detail/sc_material_cell.dart';

/// 新增物资listView

class SCAddMaterialListView extends StatelessWidget {
  /// SCAddMaterialController
  final SCAddMaterialController state;

  SCAddMaterialListView({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 11.0),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          SCMaterialListModel model = state.materialList[index];
          return cell(model);
        },
        separatorBuilder: (BuildContext context, int index) {
          return line(index);
        },
        itemCount: state.materialList.length);
  }

  Widget cell(SCMaterialListModel model) {
    return SCMaterialCell(
      model: model,
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
