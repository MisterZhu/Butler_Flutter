
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../../Constants/sc_asset.dart';

/// 验房单-房屋基本信息cell

class SCHouseInspectFormInfoCell extends StatelessWidget {

  List contactList = [
    {'icon': SCAsset.iconInspectFormOwner, 'name': '李大明'},
    {'icon': SCAsset.iconInspectFormPhone, 'name': '1923748177'},
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
      padding: const EdgeInsets.only(left: 12.0),
      child: listView(),
    );
  }

  Widget topItem() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12.0,),
        iconTextItem(SCAsset.iconInspectFormHouse, '富越香郡3幢1单元1201室', true),
        const SizedBox(height: 10.0,),
        topContactItem(),
        const SizedBox(height: 2.0,),
      ],
    );
  }

  /// topContactItem
  Widget topContactItem() {
    return StaggeredGridView.countBuilder(
        padding: EdgeInsets.zero,
        mainAxisSpacing: 12,
        crossAxisSpacing: 10,
        crossAxisCount: 2,
        shrinkWrap: true,
        itemCount: contactList.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return iconTextItem(contactList[index]['icon'], contactList[index]['name'], false);
        },
        staggeredTileBuilder: (int index) {
          return const StaggeredTile.fit(1);
        });
  }

  /// iconTextItem
  Widget iconTextItem(String icon, String name, bool houseName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(icon, width: 20.0, height: 20.0, fit: BoxFit.cover,),
        const SizedBox(width: 6,),
        Expanded(child: Text(
            name,
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: houseName ? SCFonts.f16 : SCFonts.f14,
              color: SCColors.color_1B1D33,
              fontWeight: houseName ? FontWeight.w500 : FontWeight.w400,
            )),
        )
      ],
    );
  }

  /// listView
  Widget listView() {
    return ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return cell(index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return line();
        },
        itemCount: 3);
  }

  Widget cell(int index) {
    if (index == 0) {
      return topItem();
    } else if (index == 1) {
      return middleItem();
    } else {
      return bottomItem();
    }
  }

  /// middleItem
  Widget middleItem() {
    return StaggeredGridView.countBuilder(
        padding: const EdgeInsets.only(top: 14.0),
        mainAxisSpacing: 12,
        crossAxisSpacing: 10,
        crossAxisCount: 2,
        shrinkWrap: true,
        itemCount: 6,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return textItem('通电情况:', '暂无数据');
        },
        staggeredTileBuilder: (int index) {
          return const StaggeredTile.fit(1);
        });
  }

  /// bottomItem
  Widget bottomItem() {
    return StaggeredGridView.countBuilder(
        padding: const EdgeInsets.only(top: 14.0),
        mainAxisSpacing: 12,
        crossAxisSpacing: 10,
        crossAxisCount: 2,
        shrinkWrap: true,
        itemCount: 4,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return textItem('客厅:', '无问题');
        },
        staggeredTileBuilder: (int index) {
          return const StaggeredTile.fit(1);
        });
  }

  /// textItem
  Widget textItem(String name, String content) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 70.0,
          child: Text(
              name,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: SCFonts.f14,
                color: SCColors.color_8D8E99,
                fontWeight: FontWeight.w400,
              )),
        ),
        Expanded(child: Text(
            content,
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: SCFonts.f14,
              color: SCColors.color_1B1D33,
              fontWeight: FontWeight.w400,
            )),
        )
      ],
    );
  }

  /// line
  Widget line() {
    return Container(
      color: SCColors.color_FFFFFF,
      child: Container(
        height: 0.5,
        width: double.infinity,
        color: SCColors.color_EDEDF0,
      ),
    );
  }

}