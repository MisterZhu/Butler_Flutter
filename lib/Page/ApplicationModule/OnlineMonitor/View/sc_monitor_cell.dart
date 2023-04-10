
import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';

import '../../../../Network/sc_config.dart';
import '../Model/sc_monitor_list_model.dart';

/// 监控cell

class SCMonitorCell extends StatelessWidget {

  /// 详情
  final Function? onTapAction;

  final SCMonitorListModel? model;

  SCMonitorCell({Key? key,
    this.model,
    this.onTapAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return GestureDetector(
      onTap: () {
        onTapAction?.call();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
        color: SCColors.color_FFFFFF,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            imageItem(),
            const SizedBox(height: 6.0,),
            Text(
              model?.cameraName ?? '',
              textAlign: TextAlign.left,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: SCFonts.f16,
                  fontWeight: FontWeight.w400,
                  color: SCColors.color_1B1C33
              ),)
          ]
        )
      )
    );
  }

  /// 图片
  Widget imageItem() {
    double imageScale = 159.0 / 96.0;
    String url = '';
    if (model?.picUrl != null) {
      url = SCConfig.getImageUrl(model?.picUrl  ?? '');
    } else {
      url = model?.status == 1 ? SCAsset.iconMonitorLoadingDefault : SCAsset.iconMonitorOfflineDefault;
    }
    return AspectRatio(
      aspectRatio: imageScale,
      child: ClipRRect(
        child: SCImage(
          url: url,
          fit: BoxFit.cover,
          placeholder: model?.status == 1 ? SCAsset.iconMonitorLoadingDefault : SCAsset.iconMonitorOfflineDefault,
        ),
      ),
    );
  }
}