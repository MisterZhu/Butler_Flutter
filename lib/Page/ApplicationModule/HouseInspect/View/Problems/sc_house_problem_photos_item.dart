
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sc_uikit/sc_uikit.dart';


/// 正式验房-问题照片

class SCHouseProblemPhotosCell extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return StaggeredGridView.countBuilder(
        padding: EdgeInsets.zero,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        crossAxisCount: 4,
        shrinkWrap: true,
        itemCount: 4,
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
          child: Container(
            color: SCColors.color_4DA6FF,
            width: 74.0,
            height: 74.0,
          ),)

    );
  }

}