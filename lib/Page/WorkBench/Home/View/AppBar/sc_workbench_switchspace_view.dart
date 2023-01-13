import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';

/// 工作台-切换空间

class SCWorkBenchSwitchSpaceView extends StatelessWidget {
  const SCWorkBenchSwitchSpaceView({Key? key, this.avatar = SCAsset.iconUserDefault, this.space = '', this.onTap, this.headerTap})
      : super(key: key);

  /// 头像
  final String avatar;

  /// 空间
  final String space;
  /// 切换空间
  final Function? onTap;

  /// 点击头像
  final Function? headerTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          userImage(),
          const SizedBox(
            width: 14.0,
          ),
          titleItem(),
          const SizedBox(
            width: 4.0,
          ),
          arrowIcon()
        ],
      ),
    );
  }

  /// 头像
  Widget userImage() {
    return GestureDetector(
      onTap: () {
        headerTap?.call();
      },
      child: Container(
          width: 32.0,
          height: 32.0,
          decoration: BoxDecoration(
              color: SCColors.color_F2F3F5,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: SCColors.color_FFFFFF, width: 0.5)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: SCImage(
              url: avatar,
              fit: BoxFit.cover,
              width: 42.0,
              height: 42.0,
            ),
          )
      )
    );
  }

  /// 空间名称
  Widget titleItem() {
    int maxLength = 10;
    String title = space;
    if (space.length > maxLength) {
      /// 最多展示10个字
      title = '${space.substring(0, maxLength)}...';
    }
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
            fontSize: SCFonts.f16,
            fontWeight: FontWeight.w500,
            color: SCColors.color_1B1D33),
        strutStyle: const StrutStyle(
          fontSize: SCFonts.f16,
          height: 1.30,
          forceStrutHeight: true,
        ),
      ),
    );
  }

  /// 切换icon
  Widget arrowIcon() {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Image.asset(
        SCAsset.iconArrowRight,
        width: 16.0,
        height: 16.0,
      ),
    );
  }
}
