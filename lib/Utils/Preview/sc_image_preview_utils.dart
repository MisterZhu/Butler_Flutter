import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Utils/Preview/sc_fade_route.dart';
import 'package:smartcommunity/Utils/Preview/sc_image_preview.dart';
import 'package:smartcommunity/Utils/sc_utils.dart';

import '../../Network/sc_config.dart';

class SCImagePreviewUtils {
  /// 图片预览
  static previewImage(
      {required List<String> imageList, bool needPerfix = false}) {
    SCUtils.getCurrentContext(completionHandler: (BuildContext context) {
      Navigator.of(context).push(SCFadeRoute(
          page: SCPhotoView(
        imageList: imageList,
        defaultIndex: 0,
        needPerfix: needPerfix,
        decoration: const BoxDecoration(
          color: SCColors.color_000000,
        ),
        pageChanged: (int index) {},
      )));
    });
  }
}
