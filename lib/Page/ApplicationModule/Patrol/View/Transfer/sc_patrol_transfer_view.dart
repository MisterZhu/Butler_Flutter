import 'package:flutter/cupertino.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';

import '../../Controller/sc_patrol_transfer_controller.dart';

/// 转派view

class SCPatrolTransferView extends StatefulWidget {

  final SCPatrolTransferController controller;

  const SCPatrolTransferView({Key? key, required this.controller}) : super(key: key);

  @override
  SCPatrolTransferViewState createState() => SCPatrolTransferViewState();
}

class SCPatrolTransferViewState extends State<SCPatrolTransferView> {
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
          } else{
            return cell2();
          }
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
      list: const [{
        "type": 7,
        "title": '选择部门',
        "subTitle": '',
        "content": "",
        "subContent": '',
        "rightIcon": SCAsset.iconArrowRight
      }],
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
      list: const [{
        "type": 7,
        "title": '选择人员',
        "subTitle": '',
        "content": "",
        "subContent": '',
        "rightIcon": SCAsset.iconArrowRight
      }],
      leftAction: (String value, int index) {},
      rightAction: (String value, int index) {},
      imageTap: (int imageIndex, List imageList, int index) {
        // SCImagePreviewUtils.previewImage(imageList: [imageList[index]]);
      },
    );
  }
}