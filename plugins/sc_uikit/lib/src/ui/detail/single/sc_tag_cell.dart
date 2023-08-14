import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';

/// 标签

class SCTagsCell extends StatelessWidget {
  final List list;

  const SCTagsCell({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return tagsItem();
  }

  /// 标签
  Widget tagsItem() {
    if (list.isNotEmpty) {
      return SizedBox(
        height: 17.0,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return tagCell(index, list);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                width: 8.0,
              );
            },
            itemCount: list.length),
      );
    } else {
      return const SizedBox(
        height: 0.0,
      );
    }
  }

  /// tagCell
  Widget tagCell(int index, List tagList) {
    SCTagsModel model = tagList[index];
    String title = model.title ?? '';
    Color textColor = model.textColor ?? SCColors.color_4285F4;
    Color bgColor = model.bgColor ?? SCColors.color_EBF2FF;
    Color borderColor = model.borderColor ?? Colors.transparent;
    return Container(
        height: 17.0,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(2.0),
            border: Border.all(color: borderColor, width: 0.5)),
        child: Text(
          title,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: SCFonts.f12,
              fontWeight: FontWeight.w400,
              color: textColor,
              height: 1.3),
        ));
  }
}
