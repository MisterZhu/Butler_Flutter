
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/AddReceipt/sc_material_select_item.dart';

import '../../../../../Constants/sc_asset.dart';
import '../../../HouseInspect/View/sc_deliver_evidence_cell.dart';
import '../../../HouseInspect/View/sc_deliver_explain_cell.dart';

/// 取货信息cell

class SCPickupInfoCell extends StatelessWidget {

  /// 选择仓库名称
  final Function? selectNameAction;

  /// 选择类型
  final Function? selectTypeAction;

  /// 添加图片
  final Function? addPhotoAction;

  SCPickupInfoCell({Key? key,
    this.selectNameAction,
    this.selectTypeAction,
    this.addPhotoAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleItem(),
        contentItem(),
      ],
    );
  }

  /// titleItem
  Widget titleItem() {
    return const Padding(
      padding: EdgeInsets.only(top: 10.0, bottom: 11.0),
      child: Text(
          '取货信息',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: SCFonts.f16,
              fontWeight: FontWeight.w500,
              color: SCColors.color_1B1D33)),
    );
  }

  /// contentItem
  Widget contentItem() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      decoration: BoxDecoration(
        color: SCColors.color_FFFFFF,
        borderRadius: BorderRadius.circular(4.0)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SCMaterialSelectItem(title: '仓库名称', selectAction: () {

          },),
          line(),
          SCMaterialSelectItem(title: '类型', selectAction: () {

          },),
          line(),
          const SizedBox(height: 12.0,),
          inputItem(),
          const SizedBox(height: 10.0,),
          photosItem(),
          const SizedBox(height: 12.0,),
        ])
    );
  }

  /// 输入框
  Widget inputItem() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4.0)),
        child: SCDeliverExplainCell(title: '备注信息', inputHeight: 92.0, inputAction: (String content) {

        },)
    );
  }

  /// 图片
  Widget photosItem() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4.0)),
        child: SCDeliverEvidenceCell(title: '上传照片', addIcon: SCAsset.iconMaterialAddPhoto, addPhotoAction: (List list) {

        },)
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