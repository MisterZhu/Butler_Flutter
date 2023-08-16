
import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';

import '../../../../../Constants/sc_asset.dart';

/// 物资入库-顶部搜索

class SCMaterialSearchItem extends StatelessWidget {

  final String name;
  /// 点击
  final Function? searchAction;

  SCMaterialSearchItem({Key? key,
    required this.name,
    this.searchAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Container(
        color: SCColors.color_FFFFFF,
        width: double.infinity,
        height: 44.0,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 7.0),
        child: GestureDetector(
          onTap: () {
            searchAction?.call();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            height: 30.0,
            decoration: BoxDecoration(
                color: SCColors.color_F2F3F5,
                borderRadius: BorderRadius.circular(15.0)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  SCAsset.iconGreySearch,
                  width: 16.0,
                  height: 16.0,
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: SCFonts.f14,
                      fontWeight: FontWeight.w400,
                      color: SCColors.color_B0B1B8),
                )
              ],
            ),
          ),
        )
    );
  }
}