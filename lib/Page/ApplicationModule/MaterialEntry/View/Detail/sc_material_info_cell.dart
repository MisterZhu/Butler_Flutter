import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';
import '../../Model/sc_material_entry_detail_model.dart';

/// 入库信息cell

class SCMaterialEntryInfoCell extends StatelessWidget {
  final SCMaterialEntryDetailModel? model;

  SCMaterialEntryInfoCell({Key? key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(decoration: BoxDecoration(
      color: SCColors.color_FFFFFF,
      borderRadius: BorderRadius.circular(4.0),
    ), child: Padding(padding: const EdgeInsets.all(12.0), child: Column(
      children: [
        entryUserView(),
        const SizedBox(
          height: 10.0,
        ),
        entryNumView(),
        const SizedBox(
          height: 10.0,
        ),
        entryTimeView(),
        const SizedBox(
          height: 10.0,
        ),
        entryRemarkView()
      ],
    ),),);
  }

  /// 入库人view
  Widget entryUserView() {
    return Row(
      children: [
        desLabel('入库人'),
        contactView('${model?.creatorName}')
      ],
    );
  }

  /// 入库单号
  Widget entryNumView() {
    return Row(
      children: [
        desLabel('入库单号'),
        numView('${model?.number}')
      ],
    );
  }

  /// 入库时间
  Widget entryTimeView() {
    return Row(
      children: [
        desLabel('入库时间'),
        textView(1, '${model?.gmtCreate}')
      ],
    );
  }

  /// 备注
  Widget entryRemarkView() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        desLabel('备注'),
        textView(10, '${model?.remark}')
      ],
    );
  }

  /// description-label
  Widget desLabel(String text) {
    return SizedBox(width: 100.0, child: Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
          fontSize: SCFonts.f14,
          fontWeight: FontWeight.w400,
          color: SCColors.color_5E5F66),
    ),);
  }

  /// 联系人
  Widget contactView(String name) {
    return Expanded(child: CupertinoButton(
      minSize: 22.0,
        padding: EdgeInsets.zero,
        alignment: Alignment.centerRight,
        child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Image.asset(SCAsset.iconPhone, width: 20.0, height: 20.0,),
            const SizedBox(width: 8.0,),
            Text(name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(
                fontSize: SCFonts.f14,
                fontWeight: FontWeight.w400,
                color: SCColors.color_1B1D33
            ),)
          ],
        )
      ],
    ), onPressed: () {}));
  }

  /// 单号
  Widget numView(String num) {
    return Expanded(child: CupertinoButton(
        minSize: 22.0,
        padding: EdgeInsets.zero,
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisSize: MainAxisSize.min,
      children: [
        Text(num, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(
            fontSize: SCFonts.f14,
            fontWeight: FontWeight.w400,
            color: SCColors.color_1B1D33
        ),),
        const SizedBox(width: 8.0,),
        Image.asset(SCAsset.iconMaterialCopy, width: 20.0, height: 20.0,),
      ],
    ), onPressed: () {}));
  }

  /// 普通label
  Widget textView(int maxLines, String text) {
    return Expanded(child: Text(text, textAlign: TextAlign.right, maxLines: maxLines, overflow: TextOverflow.ellipsis, style: const TextStyle(
        fontSize: SCFonts.f14,
        fontWeight: FontWeight.w400,
        color: SCColors.color_1B1D33
    ),));
  }
}
