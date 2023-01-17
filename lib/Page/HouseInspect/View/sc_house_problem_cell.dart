
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/HouseInspect/View/sc_house_problem_photos_item.dart';
import 'package:smartcommunity/Page/HouseInspect/View/sc_house_problem_tags_item.dart';
import '../../../Constants/sc_asset.dart';

/// 正式验房-问题cell

class SCHouseProblemCell extends StatelessWidget {

  List tagList = ['地面不平整','墙漆脱落',];

  String desc = '墙面上凸下凹，四周都有墙漆掉落的情况墙面上凸下，凹，四周都有墙漆掉落的情况';

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          topItem(),
          const SizedBox(height: 6.0,),
          descItem(),
          const SizedBox(height: 12.0,),
          SCHouseProblemTagsCell(),
          SCHouseProblemPhotosCell(),
        ],
    );
  }

  /// topItem
  Widget topItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Text(
              '① 厨房-墙面',
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: SCFonts.f16,
                color: SCColors.color_1B1D33,
                fontWeight: FontWeight.w500,
              ),
            )),
            topRightItem(0),
          ]
      ),
    );
  }

  /// topRightItem
  Widget topRightItem(int status) {
    Color bgColor = SCColors.color_FFFFFF;
    if (status != 0) {
      bgColor = SCColors.color_F2F3F5;
    }

    return GestureDetector(
      onTap: () {

      },
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Offstage(
            offstage: status != 0,
            child: Image.asset(SCAsset.iconProblemDelete, width: 16.0, height: 16.0, fit: BoxFit.cover,),
          ),
          Container(
            decoration: BoxDecoration(
                color: bgColor, borderRadius: BorderRadius.circular(2.0)),
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            alignment: Alignment.center,
            child: Text(
              status == 0 ? '删除' : '已提交',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: SCFonts.f12,
                color: SCColors.color_1B1D33,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
    );
  }

  /// descItem
  Widget descItem() {
    return Text(
      desc,
      textAlign: TextAlign.left,
      style: const TextStyle(
        fontSize: SCFonts.f14,
        color: SCColors.color_1B1D33,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  /// cell
  Widget cell(String name, String content) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 11.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: SCFonts.f16,
                color: SCColors.color_5E5F66,
                fontWeight: FontWeight.w400,
              ),
            ),
            Expanded(child: Text(
              content,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: SCFonts.f16,
                color: SCColors.color_1B1D33,
                fontWeight: FontWeight.w400,
              ),
            ),)
          ],
        )
    );
  }

  /// line
  Widget line() {
    return Container(
      color: SCColors.color_FFFFFF,
      padding: const EdgeInsets.only(left: 12.0),
      child: Container(
        height: 0.5,
        width: double.infinity,
        color: SCColors.color_EDEDF0,
      ),
    );
  }

}