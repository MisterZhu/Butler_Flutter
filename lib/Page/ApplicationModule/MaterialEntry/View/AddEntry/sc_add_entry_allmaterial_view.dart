import 'package:flutter/material.dart';
import '../../../PropertyFrmLoss/Model/sc_property_list_model.dart';
import '../../Model/sc_material_list_model.dart';
import '../Detail/sc_material_cell.dart';

/// 新增入库-所有物资列表view

class SCAddEntryAllMaterialView extends StatelessWidget {

  const SCAddEntryAllMaterialView({Key? key,
    required this.list, this.deleteAction,
    this.updateNumAction,
    this.hideMaterialNumTextField,
    this.isReturnEntry,
    this.propertyList,
    this.isProperty
  }) : super(key: key);

  /// 数据源
  final List<SCMaterialListModel> list;

  /// 数据源
  final List<SCPropertyListModel>? propertyList;

  /// 删除物资
  final Function(int index)? deleteAction;

  /// 刷新数量
  final Function(int index, int value)? updateNumAction;

  /// 隐藏物资数量输入框
  final bool? hideMaterialNumTextField;

  /// 是否是物资出入库-归还入库
  final bool? isReturnEntry;
  /// 是否是资产
  final bool? isProperty;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: isProperty == true ? allPropertyList() : allMaterialList(),
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

  /// 所有物资列表
  List<Widget> allPropertyList() {
    List<Widget> itemList = [];
    for (int i=0; i<propertyList!.length; i++) {
      itemList.add(cell(i));
      if (i != propertyList!.length - 1) {
        itemList.add(line());
      }
    }
    return itemList;
  }


  /// cell
  Widget cell(int index) {
    if (isProperty == true) {
      SCPropertyListModel propertyModel = propertyList![index];
      return SCMaterialCell(
        hideMaterialNumTextField: hideMaterialNumTextField,
        type: scPropertyCellTypeDelete,
        propertyModel: propertyModel,
        onTap: () {

        },
        deleteAction: () {
          deleteAction?.call(index);
        },
      );
    } else {
    SCMaterialListModel model = list[index];
    if (isReturnEntry == true) {
        return SCMaterialCell(
          model: model,
          type: scMaterialCellTypeNormal,
        );
      } else {
        return SCMaterialCell(
          hideMaterialNumTextField: hideMaterialNumTextField,
          type: scMaterialCellTypeDelete,
          model: model,
          onTap: () {

          },
          deleteAction: () {
            deleteAction?.call(index);
          },
          numChangeAction: (int value) {
            model.localNum = value;
            updateNumAction?.call(index, value);
          },
        );
      }
    }
  }

  /// line
  Widget line() {
    return const SizedBox(
      height: 10.0,
    );
  }
}