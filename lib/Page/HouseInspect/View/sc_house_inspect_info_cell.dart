
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';

/// 正式验房-验房信息cell

class SCHouseInspectInfoCell extends StatelessWidget {

  List list = [
    {'name': '验房单1：8273465732', 'isUploaded': false},
    {'name': '验房单2：8273465732', 'isUploaded': true},
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
        '验房信息',
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
          return cell(dic['name'], dic['isUploaded']);
        },
        separatorBuilder: (BuildContext context, int index) {
          return line();
        },
        itemCount: list.length);
  }

  /// cell
  Widget cell(String name, bool status) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 11.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Text(
            name,
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: SCFonts.f14,
              color: SCColors.color_4DA6FF,
              fontWeight: FontWeight.w400,
            ),
          ),),
          const SizedBox(width: 10.0,),
          Container(
            width: 68.0,
            height: 26.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: SCColors.color_FFFFFF,
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: status ? SCColors.color_FFFFFF : SCColors.color_4285F4, width: 0.5)
            ),
            child: Text(
              status ? '已上传' : '立即上传',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: SCFonts.f12,
                color: status ? SCColors.color_B0B1B8 : SCColors.color_4285F4,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
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