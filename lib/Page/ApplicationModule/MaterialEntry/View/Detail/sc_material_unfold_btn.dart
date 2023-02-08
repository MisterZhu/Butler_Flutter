import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';

/// 展开折叠按钮

class SCMaterialUnfoldBtn extends StatelessWidget {
  const SCMaterialUnfoldBtn({Key? key, required this.isUnfold, this.onPressed})
      : super(key: key);

  /// 是否展开
  final bool isUnfold;

  /// 按钮点击
  final Function(bool isUnfold)? onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        color: SCColors.color_F7F8FA,
        padding: EdgeInsets.zero,
        borderRadius: BorderRadius.circular(4.0),
        minSize: 26.0,
        child: body(),
        onPressed: () {
          onPressed?.call(isUnfold);
        });
  }

  /// body
  Widget body() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          getTitle(),
          style: const TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: SCColors.color_8D8E99),
        ),
        const SizedBox(
          width: 4.0,
        ),
        Image.asset(
          isUnfold ? SCAsset.iconMaterialUnfold : SCAsset.iconMaterialFold,
          width: 16.0,
          height: 16.0,
        )
      ],
    );
  }

  /// 获取title
  String getTitle() {
    if (isUnfold) {
      return "展开";
    } else {
      return "收起";
    }
  }
}
