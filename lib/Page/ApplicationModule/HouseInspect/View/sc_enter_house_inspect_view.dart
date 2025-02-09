
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/HouseInspect/View/SelectHouse/sc_more_buildings_view.dart';
import 'package:smartcommunity/Utils/Router/sc_router_helper.dart';
import '../../../../Constants/sc_asset.dart';
import '../../../../Utils/Router/sc_router_path.dart';
import '../../../../Utils/sc_utils.dart';

class SCEnterHouseInspectView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      child: Container(
      width: double.infinity,
      height: 156.0,
      padding: const EdgeInsets.only(left: 13.0, right: 12.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(4.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          leftItem(),
          const SizedBox(width: 14.0,),
          Expanded(child: middleItem(),),
          rightItem(),
        ],
      ),
    ),);
  }

  /// leftItem
  Widget leftItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 23.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(SCAsset.iconInspectUndone, width: 16.0, height: 16.0,),
          Expanded(child: Container(width: 2.0, color: SCColors.color_E3E3E6,)),
          Image.asset(SCAsset.iconInspectUndone, width: 16.0, height: 16.0,),
        ],
      ),
    );
  }

  /// middleItem
  Widget middleItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 21.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleItem('交付确认'),
          titleItem('正式验房'),
        ],
      ),
    );
  }

  /// rightItem
  Widget rightItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          topButtonItem(),
          bottomButtonItem(),
        ],
      ),
    );
  }

  /// topButtonItem
  Widget topButtonItem() {
    return Offstage(
      offstage: false,
      child: Container(
          width: 84.0,
          height: 32.0,
          decoration: BoxDecoration(
              color: SCColors.color_FFFFFF,
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(color: SCColors.color_4285F4, width: 1.0)
          ),
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            child: const Text(
              '确认收房',
              style: TextStyle(
                fontSize: SCFonts.f14,
                fontWeight: FontWeight.w400,
                color: SCColors.color_4285F4,),
            ),
            onPressed: () {

            },
          )
      ),
    );
  }

  /// bottomButtonItem
  Widget bottomButtonItem() {
    return Container(
        width: 84.0,
        height: 32.0,
        decoration: BoxDecoration(
            color: SCColors.color_FFFFFF,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: SCColors.color_4285F4, width: 1.0)
        ),
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Text(
            '正式验房',
            style: TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w400,
              color: SCColors.color_4285F4,),
          ),
          onPressed: () {
            SCRouterHelper.pathPage(SCRouterPath.formalHouseInspectPage, null);
          },
        )
    );
  }

  /// title
  Widget titleItem(String name) {
    return Text(
        name,
        textAlign: TextAlign.left,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: SCFonts.f14,
          color: SCColors.color_8D8E99,
          fontWeight: FontWeight.w500,
        ),
    );
  }
}