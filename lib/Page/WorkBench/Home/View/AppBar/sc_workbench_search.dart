import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';

/// 搜索框

class SCWorkBenchSearch extends StatelessWidget {
  SCWorkBenchSearch(
      {Key? key,  required this.unreadNum, this.searchAction, this.scanAction, this.messageAction})
      : super(key: key);

  final int unreadNum;
  /// 搜索
  final Function? searchAction;

  /// 扫一扫
  final Function? scanAction;

  /// 消息详情
  final Function? messageAction;

  /// 未读组件高出消息icon8.0
  double topOffset = 8.0;

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Container(
      height: 36.0 + topOffset,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          searchItem(),
          const SizedBox(
            width: 23.0,
          ),
          scanIcon(),
          const SizedBox(
            width: 12.0,
          ),
          messageItem()
        ],
      ),
    );
  }

  /// 搜索框
  Widget searchItem() {
    return Expanded(
      child: GestureDetector(
      onTap: () {
        searchAction?.call();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        height: 36.0,
        decoration: BoxDecoration(
            color: SCColors.color_E3E3E5,
            borderRadius: BorderRadius.circular(18.0)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              SCAsset.iconGreySearch,
              width: 16.0,
              height: 16.0,
            ),
            const SizedBox(
              width: 10.0,
            ),
            const Text(
              '搜索',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: SCFonts.f14,
                  fontWeight: FontWeight.w400,
                  color: SCColors.color_8D8E99),
            )
          ],
        ),
      ),
    ));
  }

  /// 扫一扫
  Widget scanIcon() {
    return GestureDetector(
      onTap: () {
        scanAction?.call();
      },
      child: Container(
        width: 36.0,
        height: 36.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: SCColors.color_FFFFFF,
            borderRadius: BorderRadius.circular(18.0)),
        child: Image.asset(
          SCAsset.iconGreyScan,
          width: 24.0,
          height: 24.0,
        ),
      ),
    );
  }

  Widget messageItem() {
    if (unreadNum > 0) {
      return SizedBox(
        width: 36.0,
        height: 36.0 + topOffset,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: bellIcon(),),
            Positioned(
              top: 0,
              right: 0,
              child: unreadItem(),)
          ],
        ),
      );
    } else {
      return bellIcon();
    }
  }

  /// 铃铛
  Widget bellIcon() {
    return GestureDetector(
      onTap: () {
        messageAction?.call();
      },
      child: Container(
        width: 36.0,
        height: 36.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: SCColors.color_FFFFFF,
            borderRadius: BorderRadius.circular(18.0)),
        child: Image.asset(
          SCAsset.iconGreyBell,
          width: 24.0,
          height: 24.0,
        ),
      ),
    );
  }

  /// 未读数量
  Widget unreadItem() {
    String text = unreadNum > 99 ? '99+' : '$unreadNum';
    return Offstage(
      offstage: unreadNum == 0,
      child: Container(
        height: 14.0,
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: SCColors.color_FF4040,
            borderRadius: BorderRadius.circular(7.0)),
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              fontSize: SCFonts.f10,
              fontWeight: FontWeight.w400,
              color: SCColors.color_FFFFFF),
        ),
      ),
    );
  }
}
