import 'package:flutter/widgets.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/Detail/sc_allmaterial_titleview.dart';

import 'sc_allmaterial_listview.dart';
import 'sc_material_unfold_btn.dart';

/// 入库详情-所有物资cell

class SCAllMaterialCell extends StatefulWidget {
  @override
  SCAllMaterialCellState createState() => SCAllMaterialCellState();
}

class SCAllMaterialCellState extends State<SCAllMaterialCell> {
  /// 是否显示所有的数据
  bool isShowAll = false;

  /// 数据源
  List list = ['', '', '', '', ''];

  /// 超过4个折叠显示
  int maxLength = 4;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: SCColors.color_FFFFFF,
          borderRadius: BorderRadius.circular(4.0)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SCAllMaterialTitleView(),
          SCAllMaterialListView(
            list: getRealList(),
            onTap: (int index) {},
          ),
          Offstage(
            offstage: list.length > maxLength ? false : true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SCMaterialUnfoldBtn(
                    isUnfold: !isShowAll,
                    onPressed: (bool status) {
                      unfoldAction(status);
                    },
                  ),
                  const SizedBox(
                    height: 12.0,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  /// 数据
  List getRealList() {
    if (list.length > maxLength) {
      if (!isShowAll) {
        return list.sublist(0, maxLength);
      } else {
        return list;
      }
    } else {
      return list;
    }
  }

  /// 展开/折叠
  unfoldAction(bool status) {
    setState(() {
      isShowAll = status;
    });
  }
}
