import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';

/// 实地核验cell

class SCRealVerificationCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return view();
  }

  /// container
  Widget view() {
    return Container(
      decoration: BoxDecoration(
          color: SCColors.color_FFFFFF,
          borderRadius: BorderRadius.circular(4.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 14.0,
          ),
          titleView(),
          const SizedBox(
            height: 14.0,
          ),
          roomInfoView(),
          const SizedBox(
            height: 12.0,
          ),
          roomAddressView(),
          const SizedBox(
            height: 12.0,
          ),
          line(),
          roomDealView()
        ],
      ),
    );
  }

  /// title
  Widget titleView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: [
          Image.asset(
            SCAsset.iconHotel,
            width: 18.0,
            height: 18.0,
          ),
          const SizedBox(width: 6.0,),
          const Expanded(
              child: Text(
                "酒店名宿",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: SCFonts.f14,
                    fontWeight: FontWeight.w400,
                    color: SCColors.color_1B1D33),
              ))
        ],
      ),
    );
  }

  /// 房间信息
  Widget roomInfoView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: roomTitleView(),
    );
  }

  /// 房间-title
  Widget roomTitleView() {
    return const Text(
      '高级双床房  共2间 高级双床房  共2间 高级双床房  共2间 高级双床房  共2间 高级双床房  共2间 高级双床房  共2间',
      style: TextStyle(
          fontSize: SCFonts.f16,
          fontWeight: FontWeight.w500,
          color: SCColors.color_1B1D33),
    );
  }

  /// 房间-地址
  Widget roomAddressView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: [
          Image.asset(
            SCAsset.iconAddress,
            width: 14.0,
            height: 14.0,
          ),
          const SizedBox(
            width: 3.0,
          ),
          const Expanded(
              child: Text(
                '怀挺民宿',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: SCFonts.f12,
                    fontWeight: FontWeight.w400,
                    color: SCColors.color_5E5F66),
              )),
          CupertinoButton(
              padding: EdgeInsets.zero,
              minSize: 16.0,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    SCAsset.iconPhone,
                    width: 16.0,
                    height: 16.0,
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  const Text(
                    '李小敏',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: SCFonts.f12,
                        fontWeight: FontWeight.w400,
                        color: SCColors.color_5E5F66),
                  )
                ],
              ),
              onPressed: () {})
        ],
      ),
    );
  }

  /// line
  Widget line() {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Container(
        height: 1.0,
        color: SCColors.color_EDEDF0,
      ),
    );
  }

  /// 房间-立即处理
  Widget roomDealView() {
    return Container(
      height: 64.0,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      alignment: Alignment.center,
      child: Row(
        children: [
          const Expanded(
              child: Text(
                '2022-11-14 12:00:00',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: SCFonts.f14,
                    fontWeight: FontWeight.w400,
                    color: SCColors.color_5E5F66),
              )),
          SizedBox(
            width: 100.0,
            height: 40.0,
            child: CupertinoButton(
                borderRadius: BorderRadius.circular(4.0),
                padding: EdgeInsets.zero,
                minSize: 40.0,
                color: SCColors.color_4285F4,
                child: const Text(
                  '立即接单',
                  style: TextStyle(
                      fontSize: SCFonts.f16,
                      fontWeight: FontWeight.w400,
                      color: SCColors.color_FFFFFF),
                ),
                onPressed: () {}),
          )
        ],
      ),
    );
  }
}
