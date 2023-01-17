
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';

/// 正式验房-房屋状态cell

class SCHouseStatusCell extends StatelessWidget {

  List list = [
    {'name': '客厅', 'content': '无问题'},
    {'name': '餐厅', 'content': '无问题'},
    {'name': '厨房', 'content': '无问题'},
    {'name': '主卧', 'content': '无问题'},
    {'name': '次卧', 'content': '无问题'},
    {'name': '卫生间', 'content': '无问题'},
  ];
  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Container(
      color: SCColors.color_FFFFFF,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          titleItem(),
          listView(),
        ],
      ),
    );
  }

  /// title
  Widget titleItem() {
    return Container(
      width: double.infinity,
      height: 36.0,
      color: SCColors.color_F5F5F5,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 16.0),
      child: const Text(
        '房屋状态',
        textAlign: TextAlign.left,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: SCFonts.f16,
          color: SCColors.color_1B1D33,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// listView
  Widget listView() {
    return ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          var dic = list[index];
          return cell(dic['name'], dic['content']);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox();
        },
        itemCount: list.length);
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