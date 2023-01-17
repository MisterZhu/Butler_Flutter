
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';

/// 正式验房-问题tags

class SCHouseProblemTagsCell extends StatelessWidget {

  List tagList = ['地面不平整', '墙漆脱落', '淋浴水管漏水', '水管漏水', '地板翘起来了了', '防水问题'];

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 14.0,
      runSpacing: 14.0,
      children: tagList.asMap().keys.map((index) => cell(tagList[index])).toList(),
    );
  }

  /// cell
  Widget cell(String name) {
    return GestureDetector(
      onTap: () {

      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2.0),
            border: Border.all(color: SCColors.color_E3E3E5, width: 0.5)
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 4.0),
        child: Text(
          name,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: SCFonts.f14,
            color: SCColors.color_5E5F66,
            fontWeight: FontWeight.w400,
          ),),
      ),
    );
  }

}