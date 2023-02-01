
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Constants/sc_asset.dart';

/// 验房-评分cell

class SCHouseInspectScoreCell extends StatefulWidget {

  SCHouseInspectScoreCell({ Key? key,}) : super(key: key);

  @override
  SCHouseInspectScoreCellState createState() => SCHouseInspectScoreCellState();
}

class SCHouseInspectScoreCellState extends State<SCHouseInspectScoreCell> {

  List nameList = ['房屋质量满意度', '设计绿化满意度', '接待服务满意度'];

  List scoreList = [0, 0, 0];

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
          bottomItem()
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
          return getCell(index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 12.0,);
        },
        itemCount: nameList.length);
  }

  /// cell
  Widget getCell(int section) {
    return SizedBox(
      height: 24.0,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            nameList[section],
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: SCFonts.f14,
              color: SCColors.color_5E5F66,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(width: 16.0,),
          Expanded(child: starsItem(section)),
        ],
      ),
    );
  }

  /// starsItem
  Widget starsItem(int section) {
    return ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return starIcon(section, index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(width: 10.0,);
        },
        itemCount: 5);
  }

  /// starIcon
  Widget starIcon(int section, int index) {
    bool selected = index < scoreList[section] ? true : false;
    return GestureDetector(
      onTap: () {
        setState(() {
          scoreList[section] = index + 1;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: Image.asset(
        selected ? SCAsset.icoScoreStarSelected : SCAsset.icoScoreStarNormal,
        width: 24.0,
        height: 24.0,
        fit: BoxFit.cover,
      ),
    );
  }

  /// line
  Widget line() {
    return Container(
      color: SCColors.color_FFFFFF,
      padding: const EdgeInsets.only(top: 13.0, bottom: 12.0),
      child: Container(
        height: 0.5,
        width: double.infinity,
        color: SCColors.color_EDEDF0,
      ),
    );
  }

  /// bottomItem
  Widget bottomItem() {
    return Offstage(
      offstage: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          line(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              autographItem(0),
              autographItem(1),
            ],
          ),
        ],
      ),
    );
  }

  /// 签名
  Widget autographItem(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          index == 0 ? '业主签署：' : '验房人签署：',
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: SCFonts.f14,
            color: SCColors.color_5E5F66,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 6.0,),
        Container(
          //color: Colors.orange,
          alignment: Alignment.center,
          width: 90.0,
          height: 56.0,
          child: Image.asset(
            SCAsset.iconInspectSign,
            width: 83.0,
            height: 50.0,
            fit: BoxFit.fill,
          ),
        )
      ],
    );
  }

}
