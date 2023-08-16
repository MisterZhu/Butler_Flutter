
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Utils/sc_utils.dart';
import '../../../../../Constants/sc_asset.dart';

///物资入库-筛选

class SCMaterialSiftItem extends StatelessWidget {

  /// 按钮点击
  final Function(int index)? tapAction;

  final List tagList;

  SCMaterialSiftItem({Key? key,
    required this.tagList,
    this.tapAction,
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
      child: gridview()
    );
  }

  /// gridview
  Widget gridview() {
    return StaggeredGridView.countBuilder(
        padding: const EdgeInsets.symmetric(horizontal: 16.0,),
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 10.0,
        crossAxisCount: 3,
        shrinkWrap: true,
        itemCount: tagList.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return cell(index);
        },
        staggeredTileBuilder: (int index) {
          return const StaggeredTile.fit(1);
        });
  }

  /// cell
  Widget cell(int index) {
    AlignmentGeometry alignment = Alignment.centerLeft;
    if (index == 1) {
      alignment = Alignment.center;
    } else if (index == 2) {
      alignment = Alignment.centerRight;
    }
    return GestureDetector(
      onTap: () {
        tapAction?.call(index);
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 44.0,
        alignment: alignment,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
                tagList[index],
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