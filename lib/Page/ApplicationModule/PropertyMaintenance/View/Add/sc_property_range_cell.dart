import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';

import '../../../../../Constants/sc_asset.dart';

/// 资产维保-范围cell

class SCPropertyRangeCell extends StatelessWidget {

  /// title
  final String? title;

  /// 范围
  final int? rangeValue;

  /// 是否可以编辑范围
  final bool? disableEditRange;

  /// 范围数组
  final List? rangeList;

  /// 点击选择范围
  final Function(int index)? selectRangeAction;

  const SCPropertyRangeCell({Key? key, this.title, this.rangeValue, this.disableEditRange, this.rangeList, this.selectRangeAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return checkRangeItem();
  }

  /// 盘点范围
  Widget checkRangeItem() {
    return Offstage(
      offstage: rangeList == null ? true : false,
      child: Container(
        height: 48.0,
        padding: const EdgeInsets.only(left: 12.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              width: 100.0,
              child: Text(title ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: SCFonts.f16,
                      fontWeight: FontWeight.w400,
                      color: SCColors.color_1B1D33)),
            ),
            const SizedBox(
              width: 12.0,
            ),
            Expanded(child: selectRangeItem()),
            const SizedBox(
              width: 12.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget selectRangeItem() {
    if (rangeList != null) {
      return Wrap(
        alignment: WrapAlignment.start,
        spacing: 16.0,
        runSpacing: 10.0,
        children: rangeList!
            .asMap()
            .keys
            .map((index) => rangeCell(index))
            .toList(),
      );
    } else {
      return const SizedBox();
    }
  }

  /// rangeCell
  Widget rangeCell(int index) {
    bool disable = disableEditRange ?? false;
    return GestureDetector(
      onTap: () {
        if (!disable) {
          selectRangeAction?.call(index);
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            rangeValue == index
                ? SCAsset.iconOpened
                : SCAsset.iconNotOpened,
            width: 18.0,
            height: 18.0,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            rangeList?[index],
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: SCFonts.f16,
              color: disable ? SCColors.color_B0B1B8 : SCColors.color_1B1D33,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}