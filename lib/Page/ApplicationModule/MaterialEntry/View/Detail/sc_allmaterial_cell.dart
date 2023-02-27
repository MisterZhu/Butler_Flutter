import 'package:flutter/widgets.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/Detail/sc_allmaterial_titleview.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import 'package:smartcommunity/Utils/Router/sc_router_path.dart';
import '../../../../../Constants/sc_enum.dart';
import '../../Model/sc_material_list_model.dart';
import '../../Model/sc_material_task_detail_model.dart';
import 'sc_allmaterial_listview.dart';
import 'sc_material_unfold_btn.dart';

/// 入库详情-所有物资cell

class SCAllMaterialCell extends StatefulWidget {
  final SCMaterialTaskDetailModel? model;

  /// 类型，type=entry入库详情，type=outbound出库详情
  final SCWarehouseManageType type;

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
            onTap: (SCMaterialListModel model) async {
              if (widget.type == SCWarehouseManageType.check) {
                /// 待盘点或盘点中时 status == 2 || status == 4
                var backParams = await SCRouterHelper.pathPage(SCRouterPath.checkMaterialDetailPage, {'model': model});
                if (backParams != null) {
                  setState(() {
                    model = backParams['model'];
                  });
                }
              }
            },
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
          ),
          const SizedBox(
            height: 4.0,
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
