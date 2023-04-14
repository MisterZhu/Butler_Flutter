import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../../Network/sc_config.dart';
import '../../../../../Utils/Preview/sc_image_preview_utils.dart';
import '../../Controller/sc_warning_detail_controller.dart';
import '../../Model/sc_warningcenter_model.dart';

/// 预警详情-处理明细-图片

class SCWarningDetailPhotosItem extends StatelessWidget {

  /// SCWarningDetailController
  final SCWarningDetailController state;

  SCWarningDetailPhotosItem({Key? key, required this.state})
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
    if (state.detailModel.fileVoList != null) {
      return StaggeredGridView.countBuilder(
          padding: EdgeInsets.zero,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          crossAxisCount: 4,
          shrinkWrap: true,
          itemCount: state.detailModel.fileVoList?.length,
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
    SCFileVoList? file = state.detailModel.fileVoList?[index];
    String fileKey = file?.fileKey ?? '';
    String url = SCConfig.getImageUrl(fileKey);
    return GestureDetector(
      onTap: () {
        previewImage(url);
      },
      child: SizedBox(
          width: 79.0,
          height:  79.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: SCImage(
              url: url,
              width: 79.0,
              height: 79.0,
              fit: BoxFit.fill,),
          )
      ),
    );
  }

  /// 图片预览
  previewImage(String url) {
    SCImagePreviewUtils.previewImage(imageList: [url]);
  }
}