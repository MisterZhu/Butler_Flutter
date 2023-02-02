

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Utils/sc_utils.dart';

import '../../../../../Constants/sc_asset.dart';

///物资入库-筛选

class SCMaterialSiftItem extends StatelessWidget {

  /// 状态点击
  final Function? stateTapAction;

  /// 类型点击
  final Function? typeTapAction;

  /// 排序点击
  final Function? sortTapAction;

  List list = ['状态', '类型', '排序'];

  SCMaterialSiftItem({Key? key,
    this.stateTapAction,
    this.typeTapAction,
    this.sortTapAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    double space = (SCUtils().getScreenWidth() - 150.0 - 32.0) / 2;
    return Container(
      color: SCColors.color_FFFFFF,
      width: double.infinity,
      height: 44.0,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          siftItem(0),
          SizedBox(width: space,),
          siftItem(1),
          SizedBox(width: space,),
          siftItem(2),
        ],
      )
    );
  }

  Widget siftItem(int index) {
    return GestureDetector(
      onTap: () {

      },
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 50.0,
        height: 44.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              list[index],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: SCFonts.f14,
                fontWeight: FontWeight.w400,
                color: SCColors.color_8D8E99)),
            const SizedBox(width: 4.0,),
            Image.asset(SCAsset.iconMaterialArrowDown, width: 14.0, height: 14.0,),
          ],
        ),
      ),
    );
  }
}