
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_enum.dart';
import 'package:smartcommunity/Page/ApplicationModule/MaterialEntry/View/AddEntry/sc_material_select_item.dart';
import '../../../../../Constants/sc_asset.dart';
import '../../../HouseInspect/View/sc_deliver_evidence_cell.dart';
import '../../../HouseInspect/View/sc_deliver_explain_cell.dart';

/// 基础信息cell

class SCBasicInfoCell extends StatelessWidget {

  /// 数据源
  final List list;

  /// 备注
  final String? remark;

  /// 点击选择
  final Function(int index)? selectAction;

  /// 输入内容
  final Function(String content)? inputAction;

  /// 添加图片
  final Function(List list)? addPhotoAction;

  SCBasicInfoCell({Key? key,
    required this.list,
    this.remark,
    this.selectAction,
    this.inputAction,
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
          '基础信息',
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
          selectListView(),
          line(),
          const SizedBox(height: 12.0,),
          inputItem(),
          const SizedBox(height: 10.0,),
          //photosItem(),
          //const SizedBox(height: 12.0,),
        ])
    );
  }

  /// selectListView
  Widget selectListView() {
    return ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          var dic = list[index];
          return SCMaterialSelectItem(
            isRequired: dic['isRequired'],
            title: dic['title'],
            content: dic['content'],
            selectAction: () {
              selectAction?.call(index);
          },);
        },
        separatorBuilder: (BuildContext context, int index) {
          return line();
        },
        itemCount: list.length);
  }

  /// 输入框
  Widget inputItem() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4.0)),
        child: SCDeliverExplainCell(
          title: '备注信息',
          content: remark ?? '',
          inputHeight: 92.0,
          inputAction: (String content) {
          inputAction?.call(content);
        },)
    );
  }

  /// 图片
  Widget photosItem() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4.0)),
        child: SCDeliverEvidenceCell(
          title: '上传照片',
          addIcon: SCAsset.iconMaterialAddPhoto,
          addPhotoType: SCAddPhotoType.all,
          addPhotoAction: (List list) {
            addPhotoAction?.call(list);
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