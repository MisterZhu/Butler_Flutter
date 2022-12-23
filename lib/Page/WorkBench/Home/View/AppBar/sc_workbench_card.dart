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
    return SizedBox(
      height: 86.0,
      child: StaggeredGridView.countBuilder(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          mainAxisSpacing: 0.0,
          crossAxisSpacing: 11.0,
          crossAxisCount: 3,
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
    );
  }

  /// 卡片
  Widget card(int index) {
    var map = data[index];
    int num = map['number'];
    String iconUrl = map['iconUrl'];
    String description = map['description'];
    return GestureDetector(
      onTap: () {
        onTap?.call(index);
      },
      child: Container(
        height: 84.0,
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: SCColors.color_FFFFFF,
            borderRadius: BorderRadius.circular(4.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            numberItem(num),
            const SizedBox(
              height: 8.0,
            ),
            descriptionItem(description, iconUrl),
          ],
        ),
      ),
    );
  }

  /// 数量item
  Widget numberItem(int num) {
    return Text(
      '$num',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
          fontSize: SCFonts.f22,
          fontWeight: FontWeight.w700,
          color: SCColors.color_1B1D33),
    );
  }

  /// 描述
  Widget descriptionItem(String value, String url) {
    return Row(
      children: [
        Image.asset(
          url,
          width: 20.0,
          height: 20.0,
        ),
        const SizedBox(
          width: 6.0,
        ),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: SCColors.color_5E5F66),
        )
      ],
    );
  }
}
