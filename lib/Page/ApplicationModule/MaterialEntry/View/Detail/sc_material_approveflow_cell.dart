import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';

/// 审批流程cell

class SCMaterialApproveFlowCell extends StatelessWidget {

  const SCMaterialApproveFlowCell({Key? key, required this.title, this.onTap}) : super(key: key);
  
  /// title
  final String title;

  /// 点击
  final Function? onTap;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        height: 48.0,
        decoration: BoxDecoration(
          color: SCColors.color_FFFFFF,
          borderRadius: BorderRadius.circular(4.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          children: [
            titleView(),
            arrowIcon(),
          ],
        ),
      ),
    );
  }

  /// title
  Widget titleView() {
    return Expanded(child: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(
      fontSize: SCFonts.f16,
      fontWeight: FontWeight.w400,
      color: SCColors.color_1B1D33
    ),));
  }
  
  /// arrow
  Widget arrowIcon() {
    return Image.asset(SCAsset.iconArrowRight, width: 16.0, height: 16.0,);
  }

}