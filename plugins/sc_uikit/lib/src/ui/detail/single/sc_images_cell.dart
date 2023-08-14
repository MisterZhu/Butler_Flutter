import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sc_uikit/sc_uikit.dart';

/// 预警详情-处理明细-图片

class SCImagesCell extends StatelessWidget {
  /// list
  final List list;

  /// padding
  final EdgeInsetsGeometry? contentPadding;

  // crossAxisCount
  final int? crossAxisCount;

  /// 点击图片
  final Function(int index, List imageList)? onTap;

  SCImagesCell(
      {Key? key, required this.list, this.contentPadding, this.crossAxisCount, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return photosItem();
  }

  /// photosItem
  Widget photosItem() {
    if (list.isNotEmpty) {
      return StaggeredGridView.countBuilder(
          padding: contentPadding,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          crossAxisCount: crossAxisCount ?? 4,
          shrinkWrap: true,
          itemCount: list.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return photoItem(index);
          },
          staggeredTileBuilder: (int index) {
            return const StaggeredTile.fit(1);
          });
    } else {
      return const SizedBox();
    }
  }

  /// 图片
  Widget photoItem(int index) {
    String url = list[index];
    return GestureDetector(
      onTap: () {
        previewImage(index);
      },
      child: AspectRatio(
          aspectRatio: 1.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: SCImage(
              url: url,
              width: 79.0,
              height: 79.0,
              fit: BoxFit.cover,
            ),
          )),
    );
  }

  /// 图片预览
  previewImage(int index) {
    onTap?.call(index, list);
  }
}
