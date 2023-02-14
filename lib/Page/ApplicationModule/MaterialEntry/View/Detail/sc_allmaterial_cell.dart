import 'package:flutter/widgets.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/Detail/sc_allmaterial_titleview.dart';

import '../../Model/sc_material_entry_detail_model.dart';
import 'sc_allmaterial_listview.dart';
import 'sc_material_unfold_btn.dart';

/// 入库详情-所有物资cell

class SCAllMaterialCell extends StatefulWidget {
  final SCMaterialEntryDetailModel? model;

  /// 类型，type=0入库详情，type=1出库详情
  final int type;

  SCAllMaterialCell({Key? key, required this.type, this.model}) : super(key: key);

  @override
  SCAllMaterialCellState createState() => SCAllMaterialCellState();
}

class SCAllMaterialCellState extends State<SCAllMaterialCell> {
  /// 是否显示所有的数据
  bool isShowAll = false;

  /// 超过4个折叠显示
  int maxLength = 4;

  @override
  Widget build(BuildContext context) {
    bool hiddenUnfold = true;
    if (widget.model?.materials != null && widget.model!.materials!.length > maxLength) {
      hiddenUnfold = false;
    }
    return DecoratedBox(
      decoration: BoxDecoration(
          color: SCColors.color_FFFFFF,
          borderRadius: BorderRadius.circular(4.0)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SCAllMaterialTitleView(type: widget.type, model: widget.model,),
          SCAllMaterialListView(
            list: getRealList(),
            onTap: (int index) {},
          ),
          Offstage(
            offstage: hiddenUnfold,
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
  getRealList() {
    if (widget.model?.materials != null && widget.model!.materials!.length > maxLength) {
      if (!isShowAll) {
        return widget.model!.materials!.sublist(0, maxLength);
      } else {
        return widget.model!.materials!;
      }
    } else {
      return widget.model?.materials;
    }
  }

  /// 展开/折叠
  unfoldAction(bool status) {
    setState(() {
      isShowAll = status;
    });
  }
}
