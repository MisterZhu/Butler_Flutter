import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';

import '../../GetXController/sc_workbench_controller.dart';

/// 卡片

class SCWorkBenchCard extends StatelessWidget {
  const SCWorkBenchCard({Key? key, required this.data,required this.timeTypeTitle,this.onTap,this.downOnTap})
      : super(key: key);

  final List data;

  final String timeTypeTitle;

  final Function(int index)? onTap;

  final Function()? downOnTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 20.0),
      child: Container(
        height: 120.0,
        decoration: BoxDecoration(
            color: SCColors.color_FFFFFF,
            borderRadius: BorderRadius.circular(4.0)),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(padding: EdgeInsets.only(left: 12),
                  child: Text(
                    "数据看板",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: SCFonts.f12,
                        fontWeight: FontWeight.w400,
                        color: SCColors.color_5E5F66),
                  ),
                ),
            GestureDetector(
              onTap: () {
                /// 数据看板筛选
                downOnTap?.call();
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 12.0),
                child: Row(
                  children:  [
                     Text(
                      timeTypeTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: SCFonts.f12,
                          fontWeight: FontWeight.w400,
                          color: SCColors.color_5E5F66),
                    ),
                    const SizedBox(width: 4.0),
                    Image.asset(
                      SCAsset.iconDown,
                      width: 12.0,
                      height: 12.0,
                    ),
                  ],
                ),
              ),
            )

          ]),
          StaggeredGridView.countBuilder(
              padding: EdgeInsets.zero,
              mainAxisSpacing: 0.0,
              crossAxisSpacing: 10.0,
              crossAxisCount: 4,
              shrinkWrap: true,
              itemCount: data.length,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return card(index);
              },
              staggeredTileBuilder: (int index) {
                return const StaggeredTile.fit(1);
              })
        ]),
      ),
    );
  }

  /// 卡片
  Widget card(int index) {
    var map = data[index];
    num number = map['number'];
    String description = map['description'];
    String richText = ''; // 富文本
    if (map.containsKey('richText')) {
      richText = map['richText'];
    }
    return GestureDetector(
      onTap: () {
        onTap?.call(index);
      },
      child: Container(
        height: 74.0,
        //padding: const EdgeInsets.only(left: 12.0),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            numberItem(number, richText),
            const SizedBox(
              height: 4.0,
            ),
            descriptionItem(description),
          ],
        ),
      ),
    );
  }

  /// 数量item
  Widget numberItem(num number, String rightText) {
    return RichText(
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        textAlign: TextAlign.center,
        text: TextSpan(
            text: '$number',
            style: const TextStyle(
                fontSize: SCFonts.f22,
                color: SCColors.color_1B1D33,
                fontWeight: FontWeight.w700),
            children: [
              TextSpan(
                  text: rightText,
                  style: const TextStyle(
                      fontSize: SCFonts.f15,
                      color: SCColors.color_1B1D33,
                      fontWeight: FontWeight.w400))
            ]));
  }

  /// 描述
  Widget descriptionItem(String value) {
    return Text(
      value,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
          fontSize: SCFonts.f12,
          fontWeight: FontWeight.w400,
          color: SCColors.color_5E5F66),
    );
  }
}
