
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';

/// 正式验房-房屋信息cell

class SCHouseInfoCell extends StatelessWidget {

  List list = [
    {'name': '业主', 'content': '李大明'},
    {'name': '小区名', 'content': '富悦翔君'},
    {'name': '房号', 'content': '1幢1单元201'},
    {'name': '面积', 'content': '89.23m²'},
    {'name': '地址', 'content': '浙江省杭州市西湖区浙江省杭州市西湖区文一西路1789号浙江大学文华校区金融科创园A座'}
  ];
  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            titleItem(),
            line(),
            listView(),
          ],
        ),
    );
  }

  /// title
  Widget titleItem() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      child: Text(
        '房屋信息',
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

  /// 活动列表
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
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 11.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 104.0,
            child: Text(
              name,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: SCFonts.f16,
                color: SCColors.color_5E5F66,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Expanded(child: Text(
            content,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: SCFonts.f16,
              color: SCColors.color_5E5F66,
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