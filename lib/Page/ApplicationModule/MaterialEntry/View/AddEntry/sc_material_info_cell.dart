import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/AddEntry/sc_add_entry_allmaterial_view.dart';
import '../../../../../Constants/sc_asset.dart';
import '../../Model/sc_material_list_model.dart';

/// 物资信息cell

class SCMaterialInfoCell extends StatelessWidget {
  /// 选择仓库名称
  final Function? selectNameAction;

  /// 选择类型
  final Function? selectTypeAction;

  /// 点击新增
  final Function? addAction;

  /// 删除物资
  final Function(int index)? deleteAction;

  /// 物资数据源
  final List<SCMaterialListModel> list;

  /// 刷新数量
  final Function(int index, int value)? updateNumAction;

  /// 是否显示添加
  final bool showAdd;

  /// 0显示物资信息，1显示物资分类
  final int? materialType;

  final String title;

  SCMaterialInfoCell(
      {Key? key,
        required this.title,
        this.materialType = 0,
      this.selectNameAction,
      this.selectTypeAction,
      this.addAction,
      required this.list,
      this.deleteAction,
      this.updateNumAction,
      required this.showAdd
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleItem(),
        numItem(),
        const SizedBox(
          height: 6.0,
        ),
        listview(),
      ],
    );
  }

  /// titleItem
  Widget titleItem() {
    return Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: SCFonts.f16,
                      fontWeight: FontWeight.w500,
                      color: SCColors.color_1B1D33)),
            ),
            topRightItem(),
          ],
        ));
  }

  /// 新增
  Widget topRightItem() {
    if (showAdd) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          addAction?.call();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              SCAsset.iconMaterialAdd,
              width: 18.0,
              height: 18.0,
            ),
            const SizedBox(
              width: 6.0,
            ),
            const Text('新增',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: SCFonts.f14,
                    fontWeight: FontWeight.w400,
                    color: SCColors.color_4285F4)),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  /// 数量
  Widget numItem() {
    return Text('共 ${getTypeNumber()} 种  总数量 ${getNumber()}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
            fontSize: SCFonts.f14,
            fontWeight: FontWeight.w400,
            color: SCColors.color_5E5F66));
  }

  Widget listview() {
    if (materialType == 1) {
      return classifyView();
    } else {
      return SCAddEntryAllMaterialView(
        list: list,
        deleteAction: (int index) {
          deleteAction?.call(index);
        },
        updateNumAction: (int index, int value) {
          updateNumAction?.call(index, value);
        },
      );
    }
  }

  /// 物资分类列表
  Widget classifyView() {
    return Container(
      decoration: BoxDecoration(
          color: SCColors.color_FFFFFF,
          borderRadius: BorderRadius.circular(4.0)),
      height: 100,
    );
  }

  Widget cell() {
    return Container(
      height: 100,
      color: SCColors.color_FFFFFF,
    );
  }

  /// 获取种类
  int getTypeNumber() {
    int count = list.length;
    return count;
  }

  /// 获取数量
  int getNumber() {
    int count = 0;
    for (SCMaterialListModel model in list) {
      count += model.localNum ?? 0;
    }
    return count;
  }
}
