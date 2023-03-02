import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_enum.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/Detail/sc_material_cell.dart';
import '../../Model/sc_material_list_model.dart';

/// 入库详情-所有物资listview

class SCAllMaterialListView extends StatelessWidget {
  const SCAllMaterialListView({Key? key, this.list, this.onTap, this.type, this.status}) : super(key: key);

  /// 所有物资
  final List<SCMaterialListModel>? list;

  /// cell点击
  final Function(SCMaterialListModel model)? onTap;

  /// 类型，type=entry入库详情，type=outbound出库详情
  final SCWarehouseManageType? type;

  /// 盘点状态
  final int? status;

  @override
  Widget build(BuildContext context) {
    if ((list ?? []).isEmpty) {
      if (type == SCWarehouseManageType.check) {
        return checkEmptyView();
      } else {
        return const SizedBox();
      }
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: allMaterialList(),
      );
    }
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

  /// checkEmptyView
  Widget checkEmptyView() {
    return Container(
      color: SCColors.color_FFFFFF,
      height: 100.0,
      alignment: Alignment.center,
      child: const Text(
        '暂无已盘点物资',
        style: TextStyle(
          fontSize: SCFonts.f14,
          fontWeight: FontWeight.w400,
          color: SCColors.color_8D8E99,
        ),
      ),
    );
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
      SCWarehouseManageType manageType = type ?? SCWarehouseManageType.entry;
      int cellType = scMaterialCellTypeNormal;
      if (manageType == SCWarehouseManageType.check) {
        cellType = scMaterialCellTypeInventory;
      }
      SCMaterialListModel subModel = list![index];
      return SCMaterialCell(
        model: subModel,
        type: cellType,
        status: status,
        onTap: () {
          onTap?.call(subModel);
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
