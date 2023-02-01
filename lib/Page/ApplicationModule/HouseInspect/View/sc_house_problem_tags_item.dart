
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_uikit/sc_uikit.dart';

/// 正式验房-问题tags

class SCHouseProblemTagsCell extends StatefulWidget {

  final List tagList;

  final int maxSelectedNum;

  SCHouseProblemTagsCell({Key? key, required this.tagList, required this.maxSelectedNum}) : super(key: key);

  @override
  SCHouseProblemTagsCellState createState() => SCHouseProblemTagsCellState();
}

class SCHouseProblemTagsCellState extends State<SCHouseProblemTagsCell> {

  List selectedList = [];

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
      children: widget.tagList.asMap().keys.map((index) => cell(widget.tagList[index])).toList(),
    );
  }

  /// cell
  Widget cell(String name) {
    bool isSelected = false;
    if (selectedList.contains(name)) {
      isSelected = true;
    }
    /// 边框颜色
    Color borderColor = isSelected == true ? SCColors.color_4285F4 : SCColors.color_E3E3E5;
    /// title字体颜色
    Color textColor = isSelected == true ? SCColors.color_4285F4 : SCColors.color_5E5F66;

    return GestureDetector(
      onTap: () {
        tagAction(name, isSelected);
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.0),
            border: Border.all(color: borderColor, width: 0.5)
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 4.0),
        child: Text(
          name,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: SCFonts.f14,
            color: textColor,
            fontWeight: FontWeight.w400,
          ),),
      ),
    );
  }

  /// 标签点击
  tagAction(String name, bool status) {
    /// 多选
    if (widget.maxSelectedNum > 1) {
      if (status == true) {
        setState(() {
          selectedList.remove(name);
        });
      } else {
        if (selectedList.length < widget.maxSelectedNum) {
          setState(() {
            selectedList.add(name);
          });
        }
      }
    } else if (widget.maxSelectedNum == 1) {/// 单选
      if (status == true) {
        setState(() {
          selectedList.remove(name);
        });
      } else {
        setState(() {
          selectedList.clear();
          selectedList.add(name);
        });
      }
    }
  }
}