import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import 'package:smartcommunity/Page/WorkBench/Home/Model/sc_verification_order_model.dart';

/// 实地核验cell

class SCRealVerificationCell extends StatelessWidget {

  const SCRealVerificationCell({Key? key, required this.model, this.callAction, this.doneAction}) : super(key: key);

  final SCVerificationOrderModel model;

  /// 打电话
  final Function(String phone)? callAction;

  /// 完成
  final Function(SCVerificationOrderModel model)? doneAction;

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
    String title = model.hotelRegisterBaseInfoV?['hotelLabelNames'] ?? '';
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
          Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
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
    String title = model.hotelRegisterBaseInfoV?['hotelName'] ?? '';
    return Text(
      title,
      style: const TextStyle(
          fontSize: SCFonts.f16,
          fontWeight: FontWeight.w500,
          color: SCColors.color_1B1D33),
    );
  }

  /// 房间-地址
  Widget roomAddressView() {
    String address = model.hotelRegisterBaseInfoV?['address'] ?? '';
    String contacts = model.hotelRegisterBaseInfoV?['contacts'] ?? '';
    String phone = model.hotelRegisterBaseInfoV?['phoneNum'] ?? '';
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
          Expanded(
              child: Text(
                address,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
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
                  Text(
                    contacts,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: SCFonts.f12,
                        fontWeight: FontWeight.w400,
                        color: SCColors.color_5E5F66),
                  )
                ],
              ),
              onPressed: () {
                callAction?.call(phone);
              })
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
    String applyTime = model.applyTime ?? '';
    return Container(
      height: 64.0,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
              child: Text(
                applyTime,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
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
                onPressed: () {
                  doneAction?.call(model);
                }),
          )
        ],
      ),
    );
  }
}
