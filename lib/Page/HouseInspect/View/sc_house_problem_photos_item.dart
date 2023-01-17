
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../Constants/sc_asset.dart';


/// 正式验房-问题照片

class SCHouseProblemPhotosCell extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return StaggeredGridView.countBuilder(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        crossAxisCount: 4,
        shrinkWrap: true,
        itemCount: 8,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return cell();
        },
        staggeredTileBuilder: (int index) {
          return const StaggeredTile.fit(1);
        });
  }

  /// cell
  Widget cell() {
    return GestureDetector(
      onTap: () {

      },
      behavior: HitTestBehavior.opaque,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4.0),
          child: SCImage(
            url: SCAsset.iconWorkBenchEmpty,
            placeholder: SCAsset.iconWorkBenchEmpty,
            fit: BoxFit.cover,
            width: 74.0,
            height: 74.0,
          ),)

    );
  }

}