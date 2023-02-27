import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';

import '../../Model/sc_check_type_model.dart';

/// 删除分类cell

class SCDeleteCategoryCell extends StatelessWidget {
  const SCDeleteCategoryCell({Key? key, required this.model, this.onTap}) : super(key: key);

  /// model
  final SCCheckTypeModel model;

  /// 点击
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    String title = model.name ?? '';
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap?.call();
      },
      child: SizedBox(
        height: 48.0,
        child: Row(
          children: [
            Image.asset(
              SCAsset.iconDeleteMaterial,
              width: 22.0,
              height: 22.0,
            ),
            const SizedBox(
              width: 12.0,
            ),
            Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: SCFonts.f16,
                      fontWeight: FontWeight.w400,
                      color: SCColors.color_1B1D33),
                ))
          ],
        ),
      ),
    );
  }
}
