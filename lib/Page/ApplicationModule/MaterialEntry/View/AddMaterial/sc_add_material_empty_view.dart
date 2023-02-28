import 'package:flutter/widgets.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';

/// 选择物资空白占位图

class SCAddMaterialEmptyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 140.0,
        ),
        Image.asset(SCAsset.iconMaterialEmpty, width: 144.0, height: 144.0,),
        const SizedBox(
          height: 16.0,
        ),
        const Text("暂无盘点物资", style: TextStyle(
          fontSize: SCFonts.f14,
          fontWeight: FontWeight.w400,
          color: SCColors.color_8D8E99
        ),)
      ],
    );
  }
}