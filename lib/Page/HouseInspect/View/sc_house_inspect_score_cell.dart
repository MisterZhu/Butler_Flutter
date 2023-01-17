
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../Constants/sc_asset.dart';

/// 验房-评分cell

class SCHouseInspectScoreCell extends StatelessWidget {

  List list = [
    {'name': '房屋质量满意度', 'score': 3},
    {'name': '设计绿化满意度', 'score': 4},
    {'name': '接待服务满意度', 'score': 5},
  ];
  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(4.0)),
      padding: const EdgeInsets.only(left: 12.0, top: 12.0, bottom: 13.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleItem(),
          const SizedBox(height: 18.0,),
          listView(),
        ],
      ),
    );
  }
  /// title
  Widget titleItem() {
    return const Text(
        '验房评分',
        textAlign: TextAlign.left,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: SCFonts.f16,
          color: SCColors.color_1B1D33,
          fontWeight: FontWeight.w500,
        ),
    );
  }

  /// body
  Widget listView() {
    return ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return getCell(list[index]['name'], list[index]['score']);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 12.0,);
        },
        itemCount: list.length);
  }

  /// cell
  Widget getCell(String name, int score) {
    return SizedBox(
      height: 24.0,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            name,
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: SCFonts.f14,
              color: SCColors.color_5E5F66,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(width: 16.0,),
          Expanded(child: starsItem(score)),
        ],
      ),
    );
  }

  /// starsItem
  Widget starsItem(int score) {
    return ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return starIcon(index < score ? true : false);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(width: 10.0,);
        },
        itemCount: 5);
  }

  /// starIcon
  Widget starIcon(bool selected) {
    return Image.asset(
      selected ? SCAsset.icoScoreStarSelected : SCAsset.icoScoreStarNormal,
      width: 24.0,
      height: 24.0,
      fit: BoxFit.cover,
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
