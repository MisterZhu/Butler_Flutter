import 'package:flutter/widgets.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import '../../../../../Constants/sc_enum.dart';
import '../../../../../Utils/sc_utils.dart';
import '../../Model/sc_material_task_detail_model.dart';

/// 入库详情-所有物资cell-titleview

class SCAllMaterialTitleView extends StatelessWidget {

  final SCMaterialTaskDetailModel? model;

  /// 类型，type=0入库详情，type=1出库详情
  final SCWarehouseManageType type;

  SCAllMaterialTitleView({Key? key, required this.type, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 14.0), child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        titleView(),
        numView()
      ],
    ),);
  }
  
  /// titleView
  Widget titleView() {
    return Container(
      height: 22.0,
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Image.asset(SCAsset.iconMaterialIcon, width: 18.0, height: 18.0,),
          const SizedBox(width: 6.0,),
          Expanded(child: Text(model?.typeName ?? '', maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: SCColors.color_1B1D33
          ),)),
          const SizedBox(width: 6.0,),
          Text(
            type == SCWarehouseManageType.entry ? SCUtils.getEntryStatusText(model?.status ?? 0) : SCUtils.getOutboundStatusText(model?.status ?? 0),
            style: TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: type == SCWarehouseManageType.entry ? SCUtils.getEntryStatusTextColor(model?.status ?? 0) : SCUtils.getOutboundStatusTextColor(model?.status ?? 0),))
        ],
      ),
    );
  }
  
  /// 数量view 
  Widget numView() {
    return Container(
      height: 22.0,
      alignment: Alignment.centerLeft,
      child: Text('共 ${model?.materials?.length} 种 总数量 ${model?.materialNums}', maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(
          fontSize: SCFonts.f14,
          fontWeight: FontWeight.w400,
          color: SCColors.color_5E5F66
      ),),
    );
  }
}