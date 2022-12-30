import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';

/// 工作台-空白占位图
class SCWorkBenchEmptyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Container(
      color: SCColors.color_F2F3F5,
      child: listView(),
    );
  }

  /// listView
  Widget listView() {
    return ListView.separated(
        padding: const EdgeInsets.only(top: 44.0),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return emptyIconCell();
          } else if (index == 1) {
            return titleCell();
          } else {
            return const SizedBox();
          }
        },
        separatorBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return const SizedBox(
              height: 16.0,
            );
          } else {
            return const SizedBox();
          }
        },
        itemCount: 2);
  }

  /// 空白图片
  Widget emptyIconCell() {
    return Image.asset(
      SCAsset.iconWorkBenchEmpty,
      width: 143.0,
      height: 143.0,
    );
  }

  /// title
  Widget titleCell() {
    return const Text(
      '暂无内容',
      textAlign: TextAlign.center,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: SCFonts.f14,
          fontWeight: FontWeight.w400,
          color: SCColors.color_B0B1B8),
    );
  }
}
