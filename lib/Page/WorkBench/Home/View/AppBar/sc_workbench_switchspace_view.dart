import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';

/// 工作台-切换空间

class SCWorkBenchSwitchSpaceView extends StatelessWidget {

  const SCWorkBenchSwitchSpaceView({Key? key, this.onTap, this.headerTap}) : super(key: key);

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
      onTap: (){
        headerTap?.call();
      },
      child: Image.asset(
        SCAsset.iconUserDefault,
        width: 32.0,
        height: 32.0,
      ),
    );
  }

  /// 空间名称
  Widget titleItem() {
    String title = '慧享生活馆';
    int maxLength = 10;
    if (title.length > maxLength) {
      /// 最多展示10个字
      title = '${title.substring(0, maxLength)}...';
    }
    return GestureDetector(
      onTap: (){
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
      ),
    );
  }

  /// 切换icon
  Widget arrowIcon() {
    return GestureDetector(
      onTap: (){
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
