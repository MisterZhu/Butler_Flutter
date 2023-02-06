import 'package:flutter/widgets.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';

/// 入库详情-所有物资cell-titleview

class SCAllMaterialTitleView extends StatelessWidget {
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
          const Expanded(child: Text('采购入库', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: SCColors.color_1B1D33
          ),)),
          const SizedBox(width: 6.0,),
          const Text('待提交', style: TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: SCColors.color_FF7F09
          ),)
        ],
      ),
    );
  }
  
  /// 数量view 
  Widget numView() {
    return Container(
      height: 22.0,
      alignment: Alignment.centerLeft,
      child: const Text('共 2 种物资  总数量 208', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(
          fontSize: SCFonts.f14,
          fontWeight: FontWeight.w400,
          color: SCColors.color_5E5F66
      ),),
    );
  }
}