import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';
import 'package:smartcommunity/Constants/sc_asset.dart';

/// 物资cell

class SCMaterialCell extends StatelessWidget {
  const SCMaterialCell({Key? key, this.onTap}) : super(key: key);

  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            imageView(),
            const SizedBox(
              width: 8.0,
            ),
            infoView(),
            const SizedBox(
              width: 10.0,
            ),
            numView()
          ],
        ),
      ),
    );
  }

  /// 物资图片
  Widget imageView() {
    return Container(
      width: 80.0,
      height: 80.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.0),
          color: SCColors.color_D9D9D9),
      child: Image.asset(
        SCAsset.iconTestMaterial,
        width: 80.0,
        height: 80.0,
      ),
    );
  }

  /// 物资信息
  Widget infoView() {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: const [
        Text(
          '物资名称物资名称物资名称物资名称物资名称物资名称物资名称物资名称物资名称',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: SCFonts.f14,
              fontWeight: FontWeight.w500,
              color: SCColors.color_1B1D33),
        ),
        Text(
          '型号:TG368 单位:个\n条码:87974389787',
          maxLines: 10,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: SCFonts.f12,
              fontWeight: FontWeight.w400,
              color: SCColors.color_8D8E99),
        )
      ],
    ));
  }

  /// 物资数量
  Widget numView() {
    return const Padding(padding: EdgeInsets.only(top: 22.0), child: Text(
      'x200',
      style: TextStyle(
          fontSize: SCFonts.f14,
          fontWeight: FontWeight.w400,
          color: SCColors.color_8D8E99),
    ),);
  }
}
