import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';

import '../../Controller/sc_patrol_detail_controller.dart';

/// 巡查详情view

class SCPatrolDetailView extends StatefulWidget {

  /// SCPatrolDetailController
  final SCPatrolDetailController state;

  const SCPatrolDetailView({Key? key, required this.state}) : super(key: key);

  @override
  SCPatrolDetailViewState createState() => SCPatrolDetailViewState();
}

class SCPatrolDetailViewState extends State<SCPatrolDetailView> {
  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return cell1();
          } else if (index == 1) {
           return cell2();
          }
          return cell3();
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 10.0,
          );
        },
        itemCount: 3);
  }

  /// cell1
  Widget cell1() {
    return SCDetailCell(
      list: widget.state.list1(),
      leftAction: (String value, int index) {},
      rightAction: (String value, int index) {},
      imageTap: (int imageIndex, List imageList, int index) {
        // SCImagePreviewUtils.previewImage(imageList: [imageList[index]]);
      },
    );
  }

  /// cell2
  Widget cell2() {
    return SCDetailCell(
      list: widget.state.list2(),
      leftAction: (String value, int index) {},
      rightAction: (String value, int index) {},
      imageTap: (int imageIndex, List imageList, int index) {
        // SCImagePreviewUtils.previewImage(imageList: [imageList[index]]);
      },
      detailAction: (int subIndex) {
        print("点击了第几个：${subIndex}");
      },
    );
  }

  /// cell3
  Widget cell3() {
    return SCDetailCell(
      list: widget.state.list3(),
      leftAction: (String value, int index) {},
      rightAction: (String value, int index) {},
      imageTap: (int imageIndex, List imageList, int index) {
        // SCImagePreviewUtils.previewImage(imageList: [imageList[index]]);
      },
    );
  }

}