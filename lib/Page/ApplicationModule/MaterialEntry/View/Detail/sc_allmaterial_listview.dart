import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/Detail/sc_material_cell.dart';
import '../../Model/sc_material_list_model.dart';

/// 入库详情-所有物资listview

class SCAllMaterialListView extends StatelessWidget {
  const SCAllMaterialListView({Key? key, this.list, this.onTap}) : super(key: key);

  /// 所有物资
  final List<SCMaterialListModel>? list;

  /// cell点击
  final Function(int index)? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: allMaterialList(),
    );
    // double height = 104.5 * list.length;
    // return SizedBox(
    //   height: height,
    //   child: ListView.separated(
    //       physics: const NeverScrollableScrollPhysics(),
    //       padding: EdgeInsets.zero,
    //       shrinkWrap: true,
    //       itemBuilder: (BuildContext context, int index) {
    //         return cell(index);
    //       },
    //       separatorBuilder: (BuildContext context, int index) {
    //         return line();
    //       },
    //       itemCount: list.length),
    // );
  }

  /// 所有物资列表
  List<Widget> allMaterialList() {
    List<Widget> itemList = [];
    if (list != null) {
      for (int i = 0; i < list!.length; i++) {
        itemList.add(cell(i));
        if (i != list!.length - 1) {
          itemList.add(line());
        }
      }
    }
    return itemList;
  }

  /// cell
  Widget cell(int index) {
    if (list != null) {
      SCMaterialListModel subModel = list![index];
      return SCMaterialCell(
        model: subModel,
        type: scMaterialCellTypeNormal,
        onTap: () {
          onTap?.call(index);
        },
      );
    } else {
      return const SizedBox();
    }
  }

  /// line
  Widget line() {
    return const Padding(
      padding: EdgeInsets.only(left: 12.0),
      child: Divider(
        height: 0.5,
        color: SCColors.color_EDEDF0,
      ),
    );
  }
}
