import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';

/// 详情-header

class SCFixedCheckMaterialDetailHeaderView extends StatelessWidget {
  const SCFixedCheckMaterialDetailHeaderView(
      {Key? key,
      required this.materialName,
      required this.unitName,
      required this.norms})
      : super(key: key);

  /// 物资名称
  final String materialName;

  /// 单位
  final String unitName;

  /// 规格
  final String norms;

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return SizedBox(
      height: 36.0 * list().length + 26.0,
      child: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 14.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: SCColors.color_FFFFFF,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return cell(
                      list()[index]['name'] ?? '',
                      list()[index]['content'] ?? '',
                      list()[index]['isInput'] ?? false);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox();
                },
                itemCount: list().length),
          )),
    );
  }

  /// cell
  Widget cell(String leftText, String rightText, bool isInput) {
    return SizedBox(
      height: 36.0,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [leftLabel(leftText), rightLabel(rightText, isInput)],
      ),
    );
  }

  /// leftLabel
  Widget leftLabel(String text) {
    return SizedBox(
      width: 100.0,
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        strutStyle: const StrutStyle(
          fontSize: SCFonts.f14,
          height: 1.25,
          forceStrutHeight: true,
        ),
        style: const TextStyle(
          fontSize: SCFonts.f14,
          fontWeight: FontWeight.w400,
          color: SCColors.color_5E5F66,
        ),
      ),
    );
  }

  /// rightLabel
  Widget rightLabel(String text, bool isInput) {
    return Expanded(
        child: Text(
      text,
      textAlign: TextAlign.right,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      strutStyle: const StrutStyle(
        fontSize: SCFonts.f14,
        height: 1.25,
        forceStrutHeight: true,
      ),
      style: const TextStyle(
          fontSize: SCFonts.f14,
          fontWeight: FontWeight.w400,
          color: SCColors.color_1B1D33),
    ));
  }

  /// 数据源
  List list() {
    List headerList = [
      {'name': '物资名称', 'content': materialName},
      {'name': '单位', 'content': unitName},
      {'name': '规格', 'content': norms},
    ];
    return headerList;
  }
}
