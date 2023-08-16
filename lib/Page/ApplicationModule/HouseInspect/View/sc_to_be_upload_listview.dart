
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/HouseInspect/View/Problems/sc_house_problem_cell.dart';
import '../../../../Constants/sc_asset.dart';

/// 待上传事项page

class SCToBeUploadListView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      child: ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return cell();
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 10.0,);
          },
          itemCount: 4),
    );
  }

  Widget cell() {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4.0)),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            topItem(),
            const SizedBox(height: 2.0,),
            timeItem(),
            const SizedBox(height: 6.0,),
            problemListView()
          ],
        )
    );
  }

  /// topItem
  Widget topItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          SCAsset.iconToBeUploadHouse,
          width: 16.0,
          height: 16.0,
          fit: BoxFit.cover,
        ),
        const SizedBox(width: 4.0,),
        Expanded(child: Text(
          '慧享生活馆1幢1单元101室',
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: SCFonts.f14,
            color: SCColors.color_1B1D33,
            fontWeight: FontWeight.w500,
          ),
        ))
      ],
    );
  }

  /// timeItem
  Widget timeItem() {
    return const Text(
      '2022-12-12 12:00',
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: SCFonts.f12,
        color: SCColors.color_8D8E99,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  /// problemListView
  Widget problemListView() {
    return ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return problemItem();
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 6.0,);
        },
        itemCount: 2);
  }

  /// problemItem
  Widget problemItem() {
    return Container(
        decoration: BoxDecoration(
            color: SCColors.color_F7F8FA, borderRadius: BorderRadius.circular(4.0)),
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: SCHouseProblemCell(isToBeUpload: true,),
    );
  }
}