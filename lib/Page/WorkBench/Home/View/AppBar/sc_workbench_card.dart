import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';

import '../../GetXController/sc_workbench_controller.dart';

/// 卡片

class SCWorkBenchCard extends StatelessWidget {
  const SCWorkBenchCard({Key? key,
    required this.data,
    this.onTap
  }) : super(key: key);

  final List data;

  final Function(int index)? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        height: 74.0,
        decoration: BoxDecoration(
            color: SCColors.color_FFFFFF,
            borderRadius: BorderRadius.circular(4.0)),
        child: StaggeredGridView.countBuilder(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
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
            }),
      ),
    );
  }

  /// 卡片
  Widget card(int index) {
    var map = data[index];
    num number = map['number'];
    String description = map['description'];
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
            numberItem(number, index == 2 ? '%': ''),
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
